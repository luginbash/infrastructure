#cloud-config
timezone: UTC
locale: en_US.UTF-8
disable_root: true
apt:
  sources:
    saltstack.list:
      source: "deb http://repo.saltstack.com/py3/ubuntu/16.04/amd64/latest xenial main"
      keyid: 754A1A7AE731F165D5E6D4BD0E08A149DE57BFBE
package_update: true
package_upgrade: true
packages:
  - salt-minion
  - bird
  - rng-tools
salt_minion:
  conf:
    master: ${master_addr}
		master_finger: ${master_finger}

network:
  version: 2
  ethernets:
    lo:
      match:
        name: lo
      addresses: [ ${my_prefix} ]

