
resource "google_compute_instance" "workload" {
  name = format("%s-gcp1-workload", var.project_prefix)
  project       = var.gcp_project_id
  machine_type  = "n1-standard-1"
  zone          = "europe-west6-a"
  tags          = ["ssh","http"]
  boot_disk {
    initialize_params {
      image     =  "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  labels = {
    webserver =  "true"     
  }
  metadata =  {
    startup-script = templatefile("./workload_custom_data.sh", { tailscale_key = var.tailscale_key, tailscale_hostname = "vela-gcp1-workload"})
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
  network_interface {
    subnetwork = google_compute_subnetwork.spoke1.self_link
    access_config {
      // Ephemeral IP
    }
  }
}

output "workload" {
  value = {
    "public_ip" = resource.google_compute_instance.workload.network_interface[0].access_config[0].nat_ip 
    "private_ip" = resource.google_compute_instance.workload.network_interface[0].network_ip
  }
}
