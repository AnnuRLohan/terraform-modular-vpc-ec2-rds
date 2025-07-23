terraform {
    backend "s3" {
        region = "us-east-1"
        bucket = "terraform-state-annu"
        key = "day8/terraform.tfstate"
        encrypt = true
        dynamodb_table = "terraform-locks"
    }
}
