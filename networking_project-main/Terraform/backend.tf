terraform {
  backend "s3" {
    bucket         = "faraz.terra.bucket"    
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terratable"                   
    encrypt        = true
  }
}
