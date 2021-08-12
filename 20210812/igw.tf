resource "aws_internet_gateway" "yk-gw" {
  vpc_id = aws_vpc.yk-test-vpc.id
  tags = {
    Name = "yk GW"
  }
}