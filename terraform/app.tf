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

resource "aws_security_group" "app_000" {
  name = "app-000"
  description = "Security group for app-000 instance"

  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks = [
      "0.0.0.0/0"
      # from Speee (disabled)
      # "122.212.158.58/32",
      # "124.35.147.130/32"
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
