resource "aws_elb" "elb_rproxy" {
  name = "elb-rproxy"

  subnets = [
    "${aws_subnet.main_public.id}"
  ]

  security_groups = [
    "${aws_security_group.elb_rproxy.id}"
  ]

  listener {
    lb_port = 443
    lb_protocol = "https"
    instance_port = 80
    instance_protocol = "http"

    ssl_certificate_id = "arn:aws:acm:ap-northeast-1:606064815760:certificate/d23da974-2c04-419b-af2c-5b6bcbcfa522"
  }

  instances = [
    "${aws_instance.rproxy.id}"
  ]

  tags = {
    Name = "elb-rproxy"
  }
}

resource "aws_security_group" "elb_rproxy" {
  name = "elb-rproxy"
  description = "Security group for rproxy ELB"

  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
    cidr_blocks = [
      # from Speee
      "122.212.158.58/32",
      "124.35.147.130/32",
      "124.35.253.130/32",
      # mrkn
      "153.175.224.167/32"
    ]
  }

  egress {
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb-rproxy"
  }
}
