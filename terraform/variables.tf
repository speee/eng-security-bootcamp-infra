data "aws_ami" "ubuntu-xenial" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "infra" {
  key_name = "infra-key"
  public_key = <<KEY
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCX0M2p6O7IvxG1sIJXc15XVLjnp2gllQ8jOMpmSf67oZVqFDnyMyUFv0cKwyfvM06YHXLRQTjUq4aEacObsccsj09K1T0E1HDEyxjf8UPs4e+GgQ1upAlFvaBKha/3iYjGmXAgYz5OpWBoRvOvmL/htD/qvJNX/kgrEj07IX/P5JsBrBL/HGQoVtHQFhdBV1MwVxiLxCxaSDopXifYoJj6ocpq413kBYUlZn7U0hs0GFCYXfgnLziFoDJriQK+yiyyInl0Ny+M+sF0M/dXNp0QmGPEK2Chv0KPcGNe2f8BWAVOkKq1tSCDYld18MfOqZx3716EmPzV9zw1QfR/36FEK9vNs+bWBXL7hBscFckPdFa3jZ8pXNB+FqGYqXNAhegaH2KmAjWL81Ya42e1wPGbub03XNpQ44WMw7KkGJdj6+O2lSMLutHu9dMvB3iXlPA3NfZSgzbz8gVa6kDi/7W5K5i1thGxxkiTrKJFYsB5gJmJ/8v6x2wVz3ievbF+FqHQOtheSGzfJIa8ubGqRIDSwCjAEnVhT/vt8T7dVr4P+xNEr8eLSIJxyANf89P/ptsJ47GdrgpMloU2Rz53DqjHTaPjQHDsq6Kckm4rphTBySHgTfNJuWmKvRK2zBPINlg3//i162Al1xPR5sr2OwIHt9Vq4ZlxDJcko2EA9ypDRw== speee-security-bootcamp-infra
KEY
}
