data "cloudinit_config" "ubuntu_init" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/files/oci-ubuntu-install.sh", {})
  }
}