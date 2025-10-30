#main.tf
# Configura el proveedor de Terraform
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Configura el proveedor de Google Cloud
provider "google" {
  # Usará la misma autenticación que ya tienes de 'gcloud'
  project = var.gcp_project_id
}

# Define el recurso que queremos crear
resource "google_storage_bucket" "dbt_docs" {
  # ¡¡IMPORTANTE!! CAMBIA ESTE NOMBRE
  # Los nombres de bucket deben ser únicos a nivel mundial.
  # Usa algo como: "bucket-dbt-docs-javierjeldres"
  name                        = "bucket-dbt-docs-jjeldres"
  location                    = "us-central1" # Puedes cambiar la región si quieres

  # Hace que el bucket sea uniforme (recomendado)
  uniform_bucket_level_access = true

  # Configuración para alojar un sitio web estático (nuestros docs)
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

}

# Hace que los archivos del sitio web sean públicos para leer
resource "google_storage_bucket_iam_member" "public_viewer" {
  # Apunta al bucket que creamos arriba usando su nombre
  bucket = google_storage_bucket.dbt_docs.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}