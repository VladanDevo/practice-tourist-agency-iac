# --- Artifact registry configuration (back and front Docker Images)

resource "google_project_service" "artifactregistry" {
  project                    = var.gcp_project_id
  service                    = "artifactregistry.googleapis.com"
  disable_on_destroy         = false
}

resource "google_artifact_registry_repository" "vladan_backend_repo" {
  depends_on = [google_project_service.artifactregistry]

  repository_id = var.artifact_backend_repo_id
  format        = "DOCKER"
  location      = var.gcp_project_region
  description   = "Repository for backend container images"
}

