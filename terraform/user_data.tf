data "template_file" "user_data" {
  template = "${file("templates/init.sh")}"

  vars = {
    infra_pubkey = "${data.template_file.id_rsa-infra-pub.rendered}"
  }
}
