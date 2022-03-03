locals {
  tags = {
    "oracle-tutorial" = "terraform"
    "environment"     = "${var.environment}"
  }

  ssh_keys = [for ssh_key in var.ssh_keys_path : file(ssh_key)]
}