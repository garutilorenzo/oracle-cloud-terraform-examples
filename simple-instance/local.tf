locals {
  tags = {
    "oracle-tutorial" = "terraform"
    "environment"     = "${var.environment}"
  }
}