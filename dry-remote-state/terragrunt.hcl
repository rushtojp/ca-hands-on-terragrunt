remote_state {
  backend = "s3"
  config = {
    bucket         = "ca-tf-state-2342231"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}