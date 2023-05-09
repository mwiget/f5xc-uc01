resource "google_compute_network" "spoke1" {
  name                            =  format("%s-spoke1", var.project_prefix)
  routing_mode                    = "REGIONAL"
  project                         = var.gcp_project_id
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
} 

data "google_compute_network" "inside" {
  depends_on = [module.gcp1]
  name = format("%s-gcp1-inside", var.project_prefix)
  project = var.gcp_project_id
}

resource "google_compute_firewall" "allow-internal" {
  name    = format("%s-spoke1-allow-internal",var.project_prefix)
  network = google_compute_network.spoke1.name
  project = var.gcp_project_id
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    "10.0.0.0/8"
  ]
}

#resource "google_compute_route" "vip" {
#  name        = "${var.name}-network-route"
#  dest_range  = var.allow_cidr_blocks[0]
#  network     = google_compute_network.spoke1.name
#  next_hop_instance = regex("mwlab-gcp-\\w+-\\w+",module.site.output.tf_output)
#  next_hop_instance_zone = var.gcp_az_name
#  priority    = 100
#  depends_on        = [module.site]
#}

resource "google_compute_firewall" "allow-ssh" {
  name    = format("%s-spoke1-allow-ssh",var.project_prefix)
  network = google_compute_network.spoke1.name
  project = var.gcp_project_id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [ "0.0.0.0/0" ]
  target_tags = ["ssh"]
}

resource "google_compute_subnetwork" "spoke1" {
  name          =  format("%s-spoke1", var.project_prefix)
  project       = var.gcp_project_id
  ip_cidr_range = "10.105.0.0/24"
  network       = google_compute_network.spoke1.self_link
  region        = "europe-west6"
}

resource "google_compute_network_peering" "spoke1a" {
  depends_on            = [module.gcp1]
  name                  = format("%s-hub-spoke1-a", var.project_prefix)
  network               = google_compute_network.spoke1.self_link
  peer_network          = data.google_compute_network.inside.self_link
  import_custom_routes  = true
  export_custom_routes  = true
}

resource "google_compute_network_peering" "spoke1b" {
  depends_on            = [module.gcp1]
  name                  = format("%s-hub-spoke1-b", var.project_prefix)
  peer_network          = google_compute_network.spoke1.self_link
  network               = data.google_compute_network.inside.self_link
  import_custom_routes  = true
  export_custom_routes  = true
}
