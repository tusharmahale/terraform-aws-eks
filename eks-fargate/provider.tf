terraform {
  backend "s3" {
    bucket = "example-eks-fargate-cluster"
    key    = "eks.tf"
    region = "us-east-1"
  }
}
provider "aws" {
region = "us-east-1"
}
