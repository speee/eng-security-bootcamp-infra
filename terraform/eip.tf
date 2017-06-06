resource "aws_eip" "main_nat" {
  vpc = true
}

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc = true
}

output "bastion_public_ip" {
  value = "${aws_eip.bastion.public_ip}"
}
