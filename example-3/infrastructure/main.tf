variable "resource_prefix" {
    type = string
}

variable "subscription_id" {
    type = string
}
module "test" {
  source = "./modules/environment"

  resource_prefix = var.resource_prefix
  subscription_id = var.subscription_id
  environment = "test"
}

module "prod" {
  source = "./modules/environment"

  resource_prefix = var.resource_prefix
  subscription_id = var.subscription_id
  environment = "prod"
}