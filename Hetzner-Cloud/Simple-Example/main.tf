terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.36.2"
    }
  }
}

variable "hcloud_token" {
  sensitive = true
}

provider "hcloud" {
  # Configuration options
  token = var.hcloud_token
}

# Create a new SSH key
resource "hcloud_ssh_key" "default" {
  name = "station"
  public_key = file("C:/Users/joris/.ssh/id_rsa.pub")
}


# Create node1 with following options
resource "hcloud_server" "node1" {
  name = "node1"
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
}

# Create node2 with following options
resource "hcloud_server" "node2" {
  name = "node2"
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
}