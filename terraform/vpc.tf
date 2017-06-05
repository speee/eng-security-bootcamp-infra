resource "aws_vpc" "main" {
  cidr_block = "10.11.0.0/16"
}

resource "aws_subnet" "main_public" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.11.11.0/24"
  availability_zone = "ap-northeast-1c"
}

resource "aws_subnet" "main_private" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.11.13.0/24"
  availability_zone = "ap-northeast-1c"
}
