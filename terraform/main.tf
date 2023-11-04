# cr1
module "cr1" {
  source = "./modules/"
  env_name = var.env_name_cr1
  app_name = var.app_name
}

#module "main" {
#  source = "./modules/"
#  env_name = var.env_name
#  app_name = var.app_name
#}
