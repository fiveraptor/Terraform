#Legt den Provider fest. Hier die Hetzner Cloud
terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.36.2"
    }
  }
}

#Hier wird die Variable von unserem API Token abgefragt
variable "hcloud_token" {
  sensitive = true
}

provider "hcloud" {
  token = var.hcloud_token
}

#SSH Public Key erstellen und anwenden
resource "hcloud_ssh_key" "default" {
  name = "station"
  public_key = file("C:/Users/joris/.ssh/id_rsa.pub")
}


#Node1 Server erstellen mit folgenden Details
resource "hcloud_server" "debian" {
  name = "debian"
  image = "debian-11"
  server_type = "cx11"
  location = "nbg1"
  ssh_keys  = [
  "station"
  ]
    public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  connection {
    type     = "ssh"
    user     = "root"
    password = ""
    private_key = file("~/.ssh/id_rsa")
    host     = hcloud_server.debian.ipv4_address
  }

  #Das init.sh Script auf die VM kopieren
  provisioner "file" {
    source  = "init.sh"
    destination = "/tmp/init.sh"
  }

  #Das init.sh script auf der VM ausführen
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "/tmp/init.sh"
    ]
  }
}