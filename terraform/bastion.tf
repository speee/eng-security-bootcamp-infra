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

resource "aws_security_group" "bastion" {
  name = "bastion"
  description = "Security group for bastion instance"

  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = [
      "122.212.158.58/32"
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
