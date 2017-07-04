resource "aws_instance" "bastion" {
  ami = "${data.aws_ami.ubuntu-xenial.id}"
  instance_type = "t2.micro"
  disable_api_termination = true
  subnet_id = "${aws_subnet.main_public.id}"

  lifecycle = {
    ignore_changes = [
      "ami",
      "user_data"
    ]
  }

  vpc_security_group_ids = [
    "${aws_security_group.bastion.id}"
  ]

  user_data = "${data.template_file.user_data.rendered}"

  tags {
    Name = "bastion-001"
  }
}

resource "aws_route53_record" "bastion_internal" {
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name = "bastion"
  type = "A"
  ttl = "30"
  records = ["${aws_instance.bastion.private_ip}"]
}

resource "aws_security_group" "bastion" {
  name = "bastion"
  description = "Security group for bastion instance"

  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = [
      # from Speee
      "122.212.158.58/32",
      "124.35.147.130/32",
      "124.35.253.130/32",
      # mrkn
      "153.175.224.167/32",
      # RTC
      "133.130.119.6/32"
    ]
  }

  egress {
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion"
  }
}

resource "aws_security_group" "ssh_via_bastion" {
  name = "ssh-via-bastion"
  description = "Security group for instances can be ssh-connected via bastion"

  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    security_groups = [
      "${aws_security_group.bastion.id}"
    ]
  }

  egress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    security_groups = [
      "${aws_security_group.bastion.id}"
    ]
  }

  tags = {
    Name = "ssh-via-bastion"
  }
}
