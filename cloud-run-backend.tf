# --- Cloud Run Backend Service ---

# Should be run from a principal that has the Set Iam Policy role to grant the Cloud SQL Client role to the service account
# 
# resource "google_project_iam_member" "sql_client_binding" {
#   project = var.gcp_project_id
#   role    = "roles/cloudsql.client"
#   member  = "serviceAccount:${var.default_sa_email}"
# }

resource "google_cloud_run_v2_service" "backend_service" {
  name     = "vladan-tourist-agency-backend"
  location = var.gcp_project_region
  ingress  = "INGRESS_TRAFFIC_ALL"

  
  deletion_protection=false

  template {
    service_account = var.default_sa_email

    containers {
      image = var.backend_image_path
      
      ports {
        container_port = 8080
      }
      
      env {
        name  = "DB_PASS"
        value_source {
          secret_key_ref {
            secret  = data.google_secret_manager_secret_version.db_password_secret_version.secret
            version = "latest"
          }
        }
      }

      env {
        name  = "SPRING_PROFILES_ACTIVE"
        value = "gcp"
      }
    }

    annotations = {
      "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.sql_instance.connection_name
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image,
    ]
  }
  
  # Same as above, should be run from a principal that has the Set Iam Policy role to grant the Cloud SQL Client role to the service account 
  # 
  # depends_on = [google_project_iam_member.sql_client_binding]
}