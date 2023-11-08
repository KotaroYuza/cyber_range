# cr1
module "cr1" {
  count               = var.cr1_enabled ? 1 : 0
  perform_attack      = var.cr1_perform_attack
  source              = "./modules_cr1/"
  app_name            = var.cr1_app_name
  env_name            = var.cr1_env_name
  public_key          = var.cr1_public_key
  attacker_public_key = var.cr1_attacker_public_key
}
