output "node_1_info" {
  value = {
    name = virtualbox_vm.node[0].name
    ip   = virtualbox_vm.node[0].network_adapter[0].ipv4_address
    mac_address = virtualbox_vm.node[0].network_adapter[0].mac_address
    device = virtualbox_vm.node[0].network_adapter[0].device
  }
  description = "Information about node 1"
}

output "node_2_info" {
  value = {
    name = virtualbox_vm.node[1].name
    ip   = virtualbox_vm.node[1].network_adapter[0].ipv4_address
    mac_address = virtualbox_vm.node[1].network_adapter[0].mac_address
    device = virtualbox_vm.node[1].network_adapter[0].device
  }
  description = "Information about node 2"
}