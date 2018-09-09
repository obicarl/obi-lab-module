module "rhel_73" {
  source = "./linux"

  # Host authorization
  linux_username = "${var.linux_username}"
  linux_password = "${var.linux_password}"

  # AWS configuration
  redhat_ami   = "${var.redhat_ami}"
  key_name        = "${var.key_name}"
  key_file_path   = "${var.key_file_path}"
  subnet_id       = "${var.subnet_id}"
  security_groups = ["${split(",",var.security_groups)}"]

  # EBS volume info
  disk_sizes = "${var.disk_sizes}"
  lin_mount_points = "${var.lin_mount_points}"
  type = "${var.type}"
  domain_name = "${var.domain_name}"
  node_name = "${var.node_name}"
}
