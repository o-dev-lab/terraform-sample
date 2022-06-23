resource "aws_vpc" "yk-test-vpc" {
  cidr_block = "172.11.0.0/16"
  tags = {
    Name ="yk-vpc"
  }
}

resource "aws_vpc" "yk-db-vpc" {
  cidr_block = "172.20.0.0/16"
  tags = {
    Name ="yk-vpc"
  }
}

resource "aws_vpc_peering_connection" "db_vpc_peering" {
  peer_vpc_id = aws_vpc.yk-db-vpc.id
  vpc_id = aws_vpc.yk-test-vpc.id
  auto_accept = true
  tags = {
    Name = "db_vpc_peering_yk"
  }
}