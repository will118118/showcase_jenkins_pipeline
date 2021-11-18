#output "jenkins-web-address" {
#    value = "${aws_instance.jenkins.public_dns}:8080"
#}

output "elb" {
  value = aws_lb.loadbalancer.dns_name
}
