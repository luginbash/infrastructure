ssh_authorized_keys: 
%{ for key in ssh_pubkeys ~}
  - ${key}
%{ endfor ~}

hostname:
k3os:
  fallback_mode: install
  install:
    silent: true
    device: /dev/sda
  data_sources:
  - hetzner
  sysctl:
  ntp_server:
  - 0.europe.pool.ntp.org
  - 1.europe.pool.ntp.org
  dns_nameservers:
  - 1.1.1.1
  - 9.9.9.9
  server_url: https://someserver:6443
  token: TOKEN_VALUE
  labels:
    region: eu-west-1
    k3os.io/upgrade: enabled
  k3s_args:
  - agent
  taints:
  - key1=value1:NoSchedule
  - key1=value1:NoExecute
