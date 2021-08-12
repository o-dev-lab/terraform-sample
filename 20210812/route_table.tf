resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.yk-test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.yk-gw.id
  }
  tags = {
    Name = "pub_route_table_yk"
  }
}

resource "aws_route_table_association" "pub_rt_subnet" {
  count = length(data.aws_availability_zones.available.names)
  subnet_id = aws_subnet.yk-subnet-pub[count.index].id
  route_table_id = aws_route_table.pub_route_table.id
}



resource "aws_route_table" "pri_route_table" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.yk-test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.yk-nat-gateway[count.index].id
  }

  route {
    cidr_block = "172.20.0.0/16"
    gateway_id = aws_vpc.yk-db-vpc.id
  }

  //  route {
  //    cidr_block = "172.20.10.0/24"
  //    gateway_id = aws_vpc_peering_connection.db_vpc_peering.id
  //  }
  //  route {
  //    cidr_block = "172.20.11.0/24"
  //    gateway_id = aws_vpc_peering_connection.db_vpc_peering.id
  //  }
  //  route {
  //    cidr_block = "172.20.12.0/24"
  //    gateway_id = aws_vpc_peering_connection.db_vpc_peering.id
  //  }
  //  route {
  //    cidr_block = "172.20.13.0/24"
  //    gateway_id = aws_vpc_peering_connection.db_vpc_peering.id
  //  }

  tags = {
    Name = "pri_route_table_${data.aws_availability_zones.available.names[count.index]}_yk"
  }
}

resource "aws_route_table_association" "pri_rt_subnet" {
  count = length(data.aws_availability_zones.available.names)
  subnet_id = aws_subnet.yk-subnet-pri[count.index].id
  route_table_id = aws_route_table.pri_route_table[count.index].id
}





resource "aws_route_table" "db_route_table" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.yk-db-vpc.id

  route {
    cidr_block = "172.11.0.0/16"
    gateway_id = aws_vpc.yk-test-vpc.id
  }

  tags = {
    Name = "db_route_table_${data.aws_availability_zones.available.names[count.index]}_yk"
  }
}


resource "aws_route_table_association" "db_rt_subnet" {
  count = length(data.aws_availability_zones.available.names)
  subnet_id = aws_subnet.yk-subnet-db[count.index].id
  route_table_id = aws_route_table.db_route_table[count.index].id
}

