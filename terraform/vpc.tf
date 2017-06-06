resource "aws_vpc" "main" {
  cidr_block = "10.11.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
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

resource "aws_internet_gateway" "main_igw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table" "main_public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main_igw.id}"
  }
}

resource "aws_main_route_table_association" "main_public" {
  vpc_id = "${aws_vpc.main.id}"
  route_table_id = "${aws_route_table.main_public.id}"
}

resource "aws_nat_gateway" "main_nat" {
  allocation_id = "${aws_eip.main_nat.id}"
  subnet_id = "${aws_subnet.main_public.id}"
}

resource "aws_route_table" "main_private" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.main_nat.id}"
  }
}

resource "aws_route_table_association" "main_private_route_001" {
  route_table_id = "${aws_route_table.main_private.id}"
  subnet_id = "${aws_subnet.main_private.id}"
}
