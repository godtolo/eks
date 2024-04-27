terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws        = ">= 4.0.0"
    local      = ">= 1.4"
    kubernetes = ">= 1.11.1"
    http = {
      source  = "terraform-aws-modules/http"
      version = ">= 2.4.1"
    }
  }

  backend "s3" {
    profile = "acloudguru"
    bucket  = "fferreira-eks-demo-terraform-state"
    region  = "us-east-1"
    key     = "eks-demo-tf.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region  = var.aws-region
  profile = var.aws-profile
}
