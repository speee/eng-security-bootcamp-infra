#! /bin/sh

useradd -U -m -s /bin/bash infra
mkdir -p /home/infra/.ssh
chmod 700 /home/infra/.ssh
echo "${infra_pubkey}" > /home/infra/.ssh/authorized_keys
chmod 600 /home/infra/.ssh/authorized_keys
chown -R infra:infra /home/infra/.ssh

cat <<SUDO > /etc/sudoers.d/infra
Defaults:%wheel !requiretty
Defaults:%wheel env_keep += SSH_AUTH_SOCK

%infra ALL=(ALL) NOPASSWD: ALL
SUDO

apt-get update -y
apt-get install -y ssh sudo
service ssh start
