resource "aws_lb" "alb-yk" {
  name = "alb-yk"
  idle_timeout = 5
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_sg.id]
  subnets = aws_subnet.yk-subnet-pub.*.id
  enable_deletion_protection = true

}

resource "aws_lb_target_group" "tg" {
  name = "web-tg-yk"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.yk-test-vpc.id
  tags = {
    Name ="web-tg-yk"
  }

}
resource "aws_lb_target_group_attachment" "tg_att" {
  count = length(data.aws_availability_zones.available.names)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.web[count.index].id
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb-yk.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

