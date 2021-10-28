variable "compartment_ocid" {

}

variable "tenancy_ocid" {

}

variable "region" {
  default = "<your_region>"
}

variable "user_ocid" {

}

variable "fingerprint" {

}

variable "private_key_path" {

}

variable "availability_domain" {
  default = "<availability_domain>"
}

variable "default_fault_domain" {
  default = "FAULT-DOMAIN-1"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh/id_rsa.pub"
}

variable "os_image_id" {
  default = "ocid1.image.oc1.eu-zurich-1.aaaaaaaam4u4w4dprotagbxx4glcmjtndbkunzs5kvz5qpkqybemlv4wds3a" # Ubuntu 20.04
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

variable "tutorial_tag_key" {
  default = "oracle-tutorial"
}

variable "tutorial_tag_value" {
  default = "terraform"
}

variable "my_public_ip_address" {
  default = "<public_ip>"
}