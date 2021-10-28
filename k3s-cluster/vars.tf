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

variable "fault_domains" {
  type    = list(any)
  default = ["FAULT-DOMAIN-1", "FAULT-DOMAIN-2", "FAULT-DOMAIN-3"]
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

variable "k3s_server_private_ip" {
  default = "10.0.0.50"
}

variable "instance_pool_size" {
  default = 3
}

variable "tutorial_tag_key" {
  default = "oracle-tutorial"
}

variable "tutorial_tag_value" {
  default = "k3s-terraform"
}

variable "my_public_ip_address" {
  default = "<public_ip>"
}

variable "k3s_token" {
  default = "2aaf122eed3409ds2c6fagfad4073-92dcdgade664d8c1c7f49z"
}

variable "install_longhorn" {
  default = true
}

variable "longhorn_release" {
  default = "v1.2.2"
}