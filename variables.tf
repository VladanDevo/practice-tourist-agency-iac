variable "gcp_project_id" {
  description = "The GCP project"
  type        = string
  default     = "sara-sandbox-interns" 
}

variable "gcp_project_region" {
  description = "The GCP region"
  type        = string
  default     = "europe-west3" 
}

variable "artifact_backend_repo_id" {
  description = "Repo in the artifact registry for the backend"
  type        = string
  default     = "vladan-backend-repo" 
}

variable "default_sa_email" {
  description = "Email of the service account for the backend to run as."
  type        = string
  default     = "53494160780-compute@developer.gserviceaccount.com"
}

variable "backend_image_path" {
  description = "The full path to the backend Docker image."
  type        = string
  default     = "europe-west3-docker.pkg.dev/sara-sandbox-interns/vladan-backend-repo/vladan-tourist-agency-backend@sha256:786a8b98a2d7e7af46ba8615cf6729be3d6cc98d0ce5b40da30cd242e84bf5d8"
}