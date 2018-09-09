# Terraform Variable declarations
#
# ###

# AWS specific variables
// variable "region" {
//   type = "map"
//   description = "AWS Region to which the servers should be provisioned"
// }

variable "subnet_id" {
  description = "AWS Subnet to which the host should be provisioned."
}

variable "security_groups" {
  description = "Comma delimited string of AWS Security groups"
}

variable "key_name" {
  description = "Existing AWS KeyPair name.  Must match the KeyPair referenced in key_file_path"
}

variable "key_file_path" {
  description = "Location of the local private key file for the EC2 instance."
}

variable "domain_name" {
  description = "domain_name"
}

# Linux Username to leverage when connecting to the remote host
variable "linux_username" {
  description = "Linux Instance Username"

}

variable "disk_sizes" {
  type        = "list"
  description = "sizes of disk in array"
}

variable "lin_mount_points" {
  type        = "list"
  description = "mount points"
}

variable "type" {
  description = "Ebs volume type"
}

# Host specific details

variable "linux_password" {
  description = "linux_password"
}

variable "node_name" {
  description = "Assigned Node name for the host"
}

variable "redhat_ami" {
  description = "AWS Instance AMI"
}
