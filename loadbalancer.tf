resource "aws_lb" "loadbalancer" {
  name                       = "app-lb-tf"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.allow_elb.id]
  subnets                    = [aws_subnet.public.id, aws_subnet.public1.id]
  enable_deletion_protection = false

  tags = {
    Environment = var.env
  }
}

resource "aws_lb_target_group" "lb_target" {
  name     = "tf-app-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target.arn
  }
}
