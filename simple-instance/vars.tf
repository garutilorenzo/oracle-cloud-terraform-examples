variable "compartment_ocid" {

}

variable "region" {

}

variable "availability_domain" {

}

variable "PATH_TO_PUBLIC_KEY" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to your public key"
}

variable "environment" {
  type = string
}

variable "is_private" {
  type    = bool
  default = false
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "default_fault_domain" {
  default = "FAULT-DOMAIN-1"
}

variable "os_image_id" {
  default = "ocid1.image.oc1.eu-zurich-1.aaaaaaaag2uyozo7266bmg26j5ixvi42jhaujso2pddpsigtib6vfnqy5f6q" # Canonical-Ubuntu-20.04-aarch64-2022.01.18-0
}