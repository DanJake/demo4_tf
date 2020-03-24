terraform {
  backend "gcs" {
    bucket      = "sxvova-bucket"
    prefix      = "demo4"
  }
}
