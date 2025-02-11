provider "google" {
  project = var.project
  region  = var.region
}

# Compute Engine Instance running the Excalidraw container
resource "google_compute_instance" "excalidraw_instance" {
  name                      = "excalidraw-instance"
  machine_type              = var.machine_type
  zone                      = var.zone
  allow_stopping_for_update = true

  # Boot disk using Container-Optimized OS (COS)
  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  metadata_startup_script = <<EOT
#!/bin/bash
echo "Starting Excalidraw container"
docker run -d -p 80:80 excalidraw/excalidraw:latest
EOT

  metadata = {
    google-logging-enabled = "true"
  }

  # Networking: attach to the default network with an external IP.
  network_interface {
    network = "default"

    access_config {
      # By leaving this block empty, an ephemeral external IP is automatically allocated.
    }
  }

  # Apply a network tag to target the firewall rule
  tags = ["http-server"]
}

# Firewall rule to allow inbound HTTP traffic (port 80) from anywhere
resource "google_compute_firewall" "default_allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["http-server"]
}

# Variables
variable "project" {
  description = "The GCP project ID"
  type        = string
  default     = "excalidraw-450217"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1" # Change if desired
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a" # Change if desired
}

variable "machine_type" {
  description = "The machine type to use for the VM"
  type        = string
  default     = "e2-micro" # Change to e2-medium, n2-standard-2, etc., if needed
}
