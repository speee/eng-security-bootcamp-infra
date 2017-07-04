resource "aws_instance" "app_000" {
  ami = "${data.aws_ami.ubuntu-xenial.id}"
  instance_type = "t2.micro"
  disable_api_termination = true
  subnet_id = "${aws_subnet.main_public.id}"
  associate_public_ip_address = true

  lifecycle = {
    ignore_changes = [
      "ami",
      "user_data"
    ]
  }

  vpc_security_group_ids = [
    "${aws_security_group.app.id}",
    "${aws_security_group.app_000.id}",
    "${aws_security_group.ssh_via_bastion.id}"
  ]

  user_data = "${data.template_file.user_data.rendered}"

  tags {
    Name = "app-000"
  }
}

resource "aws_route53_record" "app_000_internal" {
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name = "app-000"
  type = "A"
  ttl = "30"
  records = ["${aws_instance.app_000.private_ip}"]
}

resource "aws_security_group" "app_000" {
  name = "app-000"
  description = "Security group for app-000 instance"

  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks = [
      # from Speee
      "122.212.158.58/32",
      "124.35.147.130/32",
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
    Name = "app-000"
  }
}

resource "aws_instance" "app" {
  count = 15
  ami = "${data.aws_ami.ubuntu-xenial.id}"
  instance_type = "t2.micro"
  disable_api_termination = true
  subnet_id = "${aws_subnet.main_private.id}"
  associate_public_ip_address = false

  lifecycle = {
    ignore_changes = [
      "ami",
      "user_data"
    ]
  }

  vpc_security_group_ids = [
    "${aws_security_group.app.id}",
    "${aws_security_group.ssh_via_bastion.id}"
  ]

  user_data = "${data.template_file.user_data.rendered}"

  tags {
    Name = "${format("app-%03d", 15 - count.index)}"
  }
}

resource "aws_route53_record" "app_internal" {
  count = 15
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name = "${format("app-%03d", 15 - count.index)}"
  type = "A"
  ttl = "30"
  records = ["${element(aws_instance.app.*.private_ip, count.index)}"]
}

resource "aws_security_group" "app" {
  name = "app"
  description = "Security group for app instance"

  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    security_groups = [
      "${aws_security_group.rproxy.id}"
    ]
  }

  egress {
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app"
  }
}
