output "external_ip_address_app" {
  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
}

output "lb_external_address_spec" {
  value = yandex_lb_network_load_balancer.reddit-app-load-balancer.listener.*.external_address_spec[0]
}
