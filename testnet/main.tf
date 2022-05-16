variable "VALIDATOR_NAME" { type = string }
variable "AWS_REGION" { type = string }

provider "aws" {
  region = var.AWS_REGION
}

terraform {
  required_version = "~> 1.1.0"

  backend "s3" {}
}

module "aptos-node" {
  source         = "github.com/aptos-labs/aptos-core.git//terraform/aptos-node/aws?ref=main"
  region         = var.AWS_REGION
  era            = 1
  chain_id       = 23
  image_tag      = "testnet"
  validator_name = var.VALIDATOR_NAME
}
