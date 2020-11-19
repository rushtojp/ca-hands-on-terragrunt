terraform {
  # Deploy version v0.0.1 in prod
  source = "git::github.com/cloudacademy/terraform-aws-calabmodules.git//network?ref=v0.0.1"
}

# Define dependencies on other states
dependency "vpc" {
  config_path = "../vpc"
}

# Pass data in from another dependency
inputs = {
  cidr_block = local.env_vars.subnet_cidr
  availability_zone = local.env_vars.availability_zone
  vpc_id = dependency.vpc.outputs.vpc_id
  tags = {
      Environment = local.env_vars.environment
  }
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

locals {
  env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}