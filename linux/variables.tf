#
# Terraform Variable declarations
#
# ###

# AWS Details
variable "subnet_id" {
  description = "AWS Subnet to which the host should be provisioned."
}

variable "security_groups" {
  type        = "list"
  description = "Array of AWS Security groups"
}

variable "key_name" {
  description = "Existing AWS KeyPair name.  Must match the KeyPair referenced in key_file_path"
}

variable "redhat_ami" {
  description = "AWS Instance AMI"
}

# Username to leverage when connecting to the remote host
variable "linux_username" {
  description = "Instance Username"
}

variable "linux_password" {
  description = "User password"
}

variable "key_file_path" {
  description = "Location of the local private key file for the EC2 instance."
}

variable "node_name" {
  description = "Assigned Node name for the host"
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

variable "domain_name" {
  description = "domain_name"
}