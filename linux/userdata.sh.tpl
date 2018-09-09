#cloud-config
hostname: ${instance_hostname}${instance_id}
fqdn: ${instance_hostname}${instance_id}.${instance_domain}
manage_etc_hosts: true

# sshd configuration
ssh_pwauth:   true
disable_root: 0

system_info:
 default_user:
  name: ${linux_username}
  groups: [ cloudadmins ]
  sudo: [ "ALL=(ALL) NOPASSWD:ALL" ]
  shell: /bin/bash
  lock_passwd: false
  primary-group: cloudadmins
  no-user-group: true

groups:
  - cloudadmins

chpasswd:
  list: |
    ${linux_username}:${linux_password}
  expire: False

output : { all : '| tee -a /var/log/cloud-init-output.log' }
