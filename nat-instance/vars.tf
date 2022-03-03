variable "compartment_ocid" {

}

variable "region" {

}

variable "availability_domain" {

}

variable "environment" {
  type = string
}

variable "PATH_TO_PUBLIC_KEY" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to your public key"
}

variable "setup_bastion" {
  type    = bool
  default = true
}

variable "bastion_user" {
  type    = string
  default = "bastion"
}

variable "bastion_group" {
  type    = string
  default = "bastion"
}

variable "ssh_keys_path" {
  type    = list(any)
  default = ["~/.ssh/id_rsa.pub"]
}

variable "default_fault_domain" {
  default = "FAULT-DOMAIN-1"
}

variable "fault_domains" {
  type    = list(any)
  default = ["FAULT-DOMAIN-1", "FAULT-DOMAIN-2", "FAULT-DOMAIN-3"]
}

variable "vcn_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "os_image_id" {
  type    = string
  default = "ocid1.image.oc1.eu-zurich-1.aaaaaaaag2uyozo7266bmg26j5ixvi42jhaujso2pddpsigtib6vfnqy5f6q" # Canonical-Ubuntu-20.04-aarch64-2022.01.18-0
}