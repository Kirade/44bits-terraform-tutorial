provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  required_version = "0.13.3"

  required_providers {
    aws = ">= 3.8.0"
  }
}

