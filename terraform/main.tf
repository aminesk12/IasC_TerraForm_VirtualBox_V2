terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

locals {
  vm_ips = [
    "192.168.56.10",
    "192.168.56.11"
  ]
}

resource "virtualbox_vm" "node" {
  count  = 2
  name   = "node-${format("%02d", count.index + 1)}"
  image  = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus   = 2
  memory = "512 mib"
  
  network_adapter {
    type           = "hostonly"
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }

  # Wait for VM to fully boot before attempting provisioning
  provisioner "local-exec" {
    command = "sleep 30"
  }
  
  provisioner "file" {
    source      = "setup.sh"
    destination = "/tmp/setup.sh"
    connection {
      type        = "ssh"
      user        = "vagrant"
      password    = "vagrant"
      host        = local.vm_ips[count.index]
      timeout     = "2m"
      agent       = false
      # Disable host key verification for simplicity in testing
      host_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ=="
    }
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup.sh",
      "sudo /tmp/setup.sh"
    ]
    connection {
      type        = "ssh"
      user        = "vagrant"
      password    = "vagrant"
      host        = local.vm_ips[count.index]
      timeout     = "2m"
      agent       = false
      # Disable host key verification for simplicity in testing
      host_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ=="
    }
  }
}

# Define outputs to see VM information
output "vm_ips" {
  value = local.vm_ips
  description = "The IP addresses of the VMs"
}

output "vm_names" {
  value = virtualbox_vm.node[*].name
  description = "The names of the VMs"
}