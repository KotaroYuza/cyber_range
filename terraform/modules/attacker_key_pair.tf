resource "aws_key_pair" "attacker_key_pair" {
  key_name   = "${var.app_name}-${var.env_name}-attacker"
  public_key = var.attacker_public_key
}
