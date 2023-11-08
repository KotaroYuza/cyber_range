# main
module "main" {
  count      = 0  # mainを立てる場合はここをコメントアウトする
  source     = "./modules_main/"
  app_name   = var.app_name
  env_name   = var.env_name
  public_key = var.public_key
}
