variable "compartment_ocid" {

}

variable "region" {

}

variable "fault_domains" {
  type    = list(any)
  default = ["FAULT-DOMAIN-1", "FAULT-DOMAIN-2", "FAULT-DOMAIN-3"]
}

variable "oci_core_vcn_cidr" {
  default = "10.0.0.0/16"
}

variable "oci_core_subnet_cidr10" {
  default = "10.0.0.0/24"
}

variable "oci_core_subnet_cidr11" {
  default = "10.0.1.0/24"
}

variable "oci_core_vcn_dns_label" {
  default = "defaultvcn"
}

variable "oci_core_subnet_dns_label10" {
  default = "publicsubnet10"
}

variable "oci_core_subnet_dns_label11" {
  default = "publicsubnet11"
}

variable "my_public_ip_cidr" {
  type        = string
  description = "My public ip CIDR"
}

variable "environment" {
  type = string
}