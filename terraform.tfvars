dns_zone_name    = "sxvova"
dns_name         = "sxvova.opensource-ukraine.org."

static_ip = [
  {
    name   = "jenkins-ip",
    region = "us-east4",
  },
  {
    name   = "ansible-ip",
    region = "us-east1"
  }
]

dns_record = [
  {
    name = "tjenkins",
  },
  {
    name = "tfansible",
  }
]
default_disk = [
  {
    name = "jenkins-disk",
    zone = "us-east4-c",
  },
  {
    name = "ansible-disk",
    zone = "us-east1-b"
  }
]
instance = [
  {
    name = "terraform-jenkins",
    zone = "us-east4-c",
  },
  {
    name = "terraform-ansible",
    zone = "us-east1-b",
  }

]
