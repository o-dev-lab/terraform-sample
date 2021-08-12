resource "aws_eip" "yk-a-nat" {
  count = length(data.aws_availability_zones.available.names)
  vpc = true
  tags = {
    Name = "EIP_${data.aws_availability_zones.available.names[count.index]}_yk"
  }
}

resource "aws_nat_gateway" "yk-nat-gateway" {
  count = length(data.aws_availability_zones.available.names)
  allocation_id = aws_eip.yk-a-nat[count.index].id
  subnet_id = aws_subnet.yk-subnet-pub[count.index].id

  //  depends_on = ["aws_internet_gateway.front-gateway"]
  tags = {
    Name = "NG_${data.aws_availability_zones.available.names[count.index]}_yk"
  }
}