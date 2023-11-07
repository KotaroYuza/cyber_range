# cr1
module "cr1" {
  source              = "./modules/"
  app_name            = var.app_name
  env_name            = var.env_name_cr1
  public_key          = var.public_key_cr1
  attacker_public_key = var.attacker_public_key_cr1
}

#module "main" {
#  source = "./modules/"
#  env_name = var.env_name
#  app_name = var.app_name
#}
