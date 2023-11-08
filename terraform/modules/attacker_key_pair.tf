resource "aws_key_pair" "attacker_key_pair" {
  count      = var.perform_attack ? 1 : 0
  key_name   = "${var.app_name}-${var.env_name}-attacker"
  public_key = var.attacker_public_key
}
