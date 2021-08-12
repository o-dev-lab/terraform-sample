resource "aws_instance" "web" {
  ami = "ami-083ac7c7ecf9bb9b0"
  instance_type = "c5.large"
  key_name = "oregon-key"
  count = length(data.aws_availability_zones.available.names)
  subnet_id = aws_subnet.yk-subnet-pri[count.index].id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  source_dest_check = false
  root_block_device {
    volume_size = "10"
    volume_type = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = "WAS Server:${count.index + 1}"
  }
}


