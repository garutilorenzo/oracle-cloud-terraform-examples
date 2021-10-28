output "k3s_server_ip" {
  value = oci_core_instance.k3s_server.public_ip
}

output "k3s_agents_ips" {
  depends_on = [
    data.oci_core_instance_pool_instances.k3s_agents_instances,
  ]
  value = data.oci_core_instance.k3s_agents_instances_ips.*.public_ip
}

output "lb_ip" {
  value = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.ip_addresses
}