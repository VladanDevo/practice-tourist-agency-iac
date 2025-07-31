
resource "google_cloud_run_v2_service" "frontend_service" {
  name     = "vladan-tourist-agency-frontend"
  location = var.gcp_project_region
  ingress  = "INGRESS_TRAFFIC_ALL"

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  # The template describes the container to be deployed.
  template {
    containers {
      # The full path to your container image in Artifact Registry.
      image = var.frontend_image_path

      # Define the container port here
      ports {
        container_port = 80
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image,
    ]
  }
}

# This resource is the equivalent of '--allow-unauthenticated'
resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_v2_service.frontend_service.location
  project  = google_cloud_run_v2_service.frontend_service.project
  service  = google_cloud_run_v2_service.frontend_service.name
  
  role   = "roles/run.invoker"
  member = "allUsers"
}