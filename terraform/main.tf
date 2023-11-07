# main
module "main" {
  count      = 0  # mainを立てる場合はここをコメントアウトする
  source     = "./modules/"
  app_name   = var.app_name
  env_name   = var.env_name
  public_key = var.public_key
}

# cr1
module "cr1" {
  count               = var.cr1_enabled ? 1 : 0
  perform_attack      = var.cr1_perform_attack
  source              = "./modules/"
  app_name            = var.cr1_app_name
  env_name            = var.cr1_env_name
  public_key          = var.cr1_public_key
  attacker_public_key = var.cr1_attacker_public_key
}
