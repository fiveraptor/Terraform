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


#Wordpress Server erstellen mit folgenden Details
resource "hcloud_server" "wordpress" {
  name = "Wordpress"
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
    host     = hcloud_server.wordpress.ipv4_address
  }

  #Das init.sh Script auf die VM kopieren
  provisioner "file" {
    source  = "scripts/init.sh"
    destination = "/tmp/init.sh"
  }

    #Das init.sh script auf der VM ausführen
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "/tmp/init.sh"
    ]
  }

  provisioner "file" {
  source  = "scripts/wordpress-setup.sh"
  destination = "/tmp/wordpress-setup.sh"
  }

  #Das init.sh script auf der VM ausführen
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/wordpress-setup.sh",
      "/tmp/wordpress-setup.sh"
    ]
  }
}


#MySQL Server erstellen mit folgenden Details
resource "hcloud_server" "mysql" {
  name = "MySQL"
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
    host     = hcloud_server.mysql.ipv4_address
  }

  #Das init.sh Script auf die VM kopieren
  provisioner "file" {
    source  = "scripts/init.sh"
    destination = "/tmp/init.sh"
  }

    #Das init.sh script auf der VM ausführen
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "/tmp/init.sh"
    ]
  }

  provisioner "file" {
  source  = "scripts/mysql-setup.sh"
  destination = "/tmp/mysql-setup.sh"
  }

  #Das init.sh script auf der VM ausführen
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/mysql-setup.sh",
      "/tmp/mysql-setup.sh"
    ]
  }
}