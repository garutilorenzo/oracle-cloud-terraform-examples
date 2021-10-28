data "template_cloudinit_config" "k3s_server_tpl" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/files/k3s-install-server.sh", { k3s_token = var.k3s_token, is_k3s_server = true, k3s_url = var.k3s_server_private_ip, install_longhorn = var.install_longhorn, longhorn_release = var.longhorn_release })
  }
}

data "template_cloudinit_config" "k3s_agent_tpl" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/files/k3s-install-agent.sh", { k3s_token = var.k3s_token, is_k3s_server = false, k3s_url = var.k3s_server_private_ip })
  }
}

data "oci_core_instance_pool_instances" "k3s_agents_instances" {
  depends_on = [
    oci_core_instance_pool.k3s_agents,
  ]
  compartment_id   = var.compartment_ocid
  instance_pool_id = oci_core_instance_pool.k3s_agents.id
}

data "oci_core_instance" "k3s_agents_instances_ips" {
  count       = var.instance_pool_size
  instance_id = data.oci_core_instance_pool_instances.k3s_agents_instances.instances[count.index].id
}