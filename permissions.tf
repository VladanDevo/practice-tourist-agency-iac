# grants the terraform service account permission to trigger cloud builds
resource "google_project_iam_member" "cloudbuild_trigger_permission" {
  project = "sara-sandbox-interns"
  role    = "roles/cloudbuild.editor"
  member  = "serviceAccount:vladan-iac-terraform-deployer@sara-sandbox-interns.iam.gserviceaccount.com"
}