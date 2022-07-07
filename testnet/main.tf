variable "VALIDATOR_NAME" { type = string }
variable "AWS_REGION" { type = string }

provider "aws" {
  region = var.AWS_REGION
}

terraform {
  required_version = "~> 1.2.0"

  backend "s3" {}
}

module "aptos-node" {
  source         = "github.com/aptos-labs/aptos-core.git//terraform/aptos-node/aws?ref=main"
  region         = var.AWS_REGION
  era            = 2
  chain_id       = 40
  image_tag      = "testnet_898fdc4f4ae7eb2a7dad0b4da9b293d7510b5732"
  validator_name = var.VALIDATOR_NAME
}
