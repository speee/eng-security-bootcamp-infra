data "aws_ami" "ubuntu-xenial" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
}

data "template_file" "id_rsa-infra-pub" {
  template = "${file("templates/id_rsa.infra.pub")}"
}

resource "aws_key_pair" "infra" {
  key_name = "infra-key"
  public_key = "${data.template_file.id_rsa-infra-pub.rendered}"
}
