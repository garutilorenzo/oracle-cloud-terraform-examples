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
  default = "ocid1.image.oc1.eu-zurich-1.aaaaaaaabt5i2qa7sdt65orrb66anzyljybm3furr2q7ykxodt5zmfxqbyzq" # Canonical-Ubuntu-22.04-aarch64-2023.07.20-0
}

variable "shape" {
  default = "VM.Standard.A1.Flex" # VM.Standard.E2.1.Micro
}

variable "memory_in_gbs" {
  default = "6"
}

variable "ocpus" {
  default = "1"
}