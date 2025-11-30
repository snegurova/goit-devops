terraform {
  backend "s3" {
    bucket       = "terraform-state-bucket-goitis"
    key          = "final-project/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
