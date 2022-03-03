variable "compartment_ocid" {

}

variable "region" {

}

variable "environment" {
  type = string
}

variable "instance_pool_id" {
  type = string
}

variable "is_private" {
  type    = bool
  default = true
}

variable "vcn_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "instance_pool_size" {
  type    = number
  default = 2
}