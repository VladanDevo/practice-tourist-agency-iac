# --- Cloud SQL ---

resource "google_project_service" "sqladmin" {
  project            = var.gcp_project_id
  service            = "sqladmin.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "secretmanager" {
  project            = var.gcp_project_id
  service            = "secretmanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_sql_database_instance" "sql_instance" {
  depends_on = [google_project_service.sqladmin]

  name             = "vladan-database"
  database_version = "POSTGRES_17"
  region           = "europe-west3"
  
  settings {
    tier = "db-custom-1-3840"
    edition = "ENTERPRISE"
    disk_size = 10
    disk_type = "PD_SSD"
    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "Vladan's Network"
        value = "89.216.45.218/32"
      }
    }

    maintenance_window {
      day = 7
      hour = 0
      update_track = "stable"
    }

    deletion_protection_enabled  = true
    retain_backups_on_delete     = true
  }
}

resource "google_sql_database" "db_instance" {
  instance = google_sql_database_instance.sql_instance.name
  name     = "tourist-agency-db"
}

data "google_secret_manager_secret_version" "db_password_secret_version" {
  secret = "vladan-tourist-agency-db-password"
}

resource "google_sql_user" "db_user" {
  instance = google_sql_database_instance.sql_instance.name
  name     = "postgres"
  password = data.google_secret_manager_secret_version.db_password_secret_version.secret_data
}

