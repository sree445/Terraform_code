resource "google_dataproc_cluster" "mycluster" {
 project      = "myproject-45-389614" 
  name                          = "terraform-dataproc"
  region                        ="us-central1" 

  cluster_config {
    staging_bucket = google_storage_bucket.dataproc-bucket.name

    master_config {
      num_instances = 1
      machine_type  = var.dataproc_master_machine_type
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = var.dataproc_master_bootdisk
      }
    }

    worker_config {
      num_instances = var.dataproc_workers_count
      machine_type  = var.dataproc_worker_machine_type
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = var.dataproc_worker_bootdisk
        num_local_ssds    = var.worker_local_ssd
      }
    }

    preemptible_worker_config {
      num_instances = var.preemptible_worker
    }

    software_config {
      image_version = "2.0.66-debian10"
    }

    gce_cluster_config {
      zone = "us-central1-b"
      service_account        = google_service_account.dataproc-svc.email
      service_account_scopes = ["cloud-platform"]
    }
  }
}
