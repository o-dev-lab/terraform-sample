resource "aws_subnet" "yk-subnet-pub" {
  count = length(data.aws_availability_zones.available.names)

  cidr_block = "172.11.${count.index}.0/24"
  vpc_id = aws_vpc.yk-test-vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "Public Subnet_${data.aws_availability_zones.available.names[count.index]}_yk"
  }
}

resource "aws_subnet" "yk-subnet-pri" {
  count = length(data.aws_availability_zones.available.names)
  cidr_block = "172.11.${count.index+10}.0/24"
  vpc_id = aws_vpc.yk-test-vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "Private Subnet_${data.aws_availability_zones.available.names[count.index]}_yk"
  }
}

resource "aws_subnet" "yk-subnet-db" {
  count = length(data.aws_availability_zones.available.names)
  cidr_block = "172.20.${count.index+10}.0/24"
  vpc_id = aws_vpc.yk-db-vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "Private Subnet_${data.aws_availability_zones.available.names[count.index]}_yk"
  }
}