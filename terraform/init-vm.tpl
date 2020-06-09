#cloud-config
timezone: UTC
locale: en_US.UTF-8
disable_root: true
apt:
  sources:
    saltstack.list:
      source: "deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main"
      keyid: 754A1A7AE731F165D5E6D4BD0E08A149DE57BFBE
package_update: true
package_upgrade: true
packages:
  - salt-minion
  - bird
  - rng-tools
salt_minion:
  conf:
    master: "${master_addr}"
    master_finger: "${master_finger}"
users:
  - name: "${master_user}"
    groups: [ sudo, docker, adm, bird ]
    ssh_pwauth: False
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock-passwd: true
    ssh-authorized-keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE63jGNfDxmbC18TQDrIM//RZ85R/2JSjo0jhwqMkLyl salt-master@salt
      - ${SSH_PUBKEY_1}
      - ${SSH_PUBKEY_2}
      - ${SSH_PUBKEY_3}
      - ${SSH_PUBKEY_4}
      - ${SSH_PUBKEY_5}

