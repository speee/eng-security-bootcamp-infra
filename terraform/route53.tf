resource "aws_route53_zone" "primary" {
  name = "speee-sbc.mrkn.jp"
}

output "primary_zone_nameservers" {
  value = ["${aws_route53_zone.primary.name_servers}"]
}

resource "aws_route53_record" "bastion" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name = "bastion"
  type = "A"
  ttl = "60"
  records = ["${aws_eip.bastion.public_ip}"]
}

resource "aws_route53_zone" "internal" {
  name = "speee-sbc.mrkn.jp"
  vpc_id = "${aws_vpc.main.id}"
}
