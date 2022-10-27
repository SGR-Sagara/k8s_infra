terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.65.0"  ## was 3.64.2
    }
  }
}

terraform {
  backend "s3" {
    bucket = "sgr-it-lab-tf-states"
    key    = "k8s.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}