resource "aws_instance" "rproxy" {
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
    "${aws_security_group.rproxy.id}",
    "${aws_security_group.ssh_via_bastion.id}"
  ]

  user_data = "${data.template_file.user_data.rendered}"

  tags {
    Name = "rproxy-001"
  }
}

resource "aws_security_group" "rproxy" {
  name = "rproxy"
  description = "Security group for rproxy instance"

  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rproxy"
  }
}
