#
# Configuration and Deployment of AWS Instance for Linux
#
####

resource "aws_network_interface" "linux" {
  subnet_id       = "${var.subnet_id}"
  security_groups = ["${var.security_groups}"]

  tags {
    Name       = "${replace(var.node_name,"_","-")}-pipeline"
    Created_by = "Obinna Okpokwasili(@obi)"
    owner      = "Terraform Support Engineering"
  }
}

data "template_file" "aws_userdata" {
  template = "${file("${path.module}/userdata.sh.tpl")}"

  vars {
    linux_username    = "${var.linux_username}"
    linux_password    = "${var.linux_password}"
    instance_hostname = "${replace(var.node_name,"_","-")}"
    instance_id       = "${element(split(".",aws_network_interface.linux.0.private_ip),3)}"
    instance_domain   = "${var.domain_name}"
  }
}

resource "aws_instance" "linux" {
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    "aws_ebs_volume.linux-volume",
  ]

  tags {
    Name = "${replace(var.node_name,"_","-")}"
  }

  ami           = "${var.redhat_ami}"
  instance_type = "t2.medium"
  key_name      = "${var.key_name}"

  root_block_device {
    volume_size           = "55"
    delete_on_termination = "true"
  }

  network_interface {
    network_interface_id = "${aws_network_interface.linux.id}"
    device_index         = 0
  }

  user_data = "${data.template_file.aws_userdata.rendered}"

  tags {
    Name       = "${var.node_name}${element(split(".",aws_network_interface.linux.0.private_ip),3)}"
    Created_by = "Obinna Okpokwasili(@obi)"
    owner      = "Terraform Support Engineering"
  }

  connection {
    host     = "${aws_instance.linux.0.private_ip}"
    type     = "ssh"
    user     = "${var.linux_username}"
    password = "${var.linux_password}"
    timeout  = "10m"
  }
}
 

resource "aws_ebs_volume" "linux-volume" {
  count             = "${length(var.disk_sizes)}"
  availability_zone = "us-east-1a"
  size              = "${element(var.disk_sizes, count.index)}"
  type              = "${var.type}"
  encrypted         = true

  tags {
    Name       = "${replace(var.node_name,"_","-")}${element(split(".",aws_network_interface.linux.0.private_ip),3)}_disk_${count.index + 1}"
    Created_by = "Obinna Okpokwasili(@obi)"
    owner      = "Terraform Support Engineering"
  }
}

resource "aws_volume_attachment" "linux-volume-att" {
  depends_on = [
    "aws_ebs_volume.linux-volume",
  ]

  count        = "${length(var.disk_sizes)}"
  device_name  = "${element(var.lin_mount_points, count.index)}"
  volume_id    = "${element(aws_ebs_volume.linux-volume.*.id, count.index)}"
  instance_id  = "${aws_instance.linux.id}"
  skip_destroy = true
}

output "aws_instance_ip" {
  value = "${aws_instance.linux.0.private_ip}"
}
