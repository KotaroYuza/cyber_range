resource "aws_key_pair" "key_pair" {
  key_name   = "${var.app_name}-${var.env_name}"
  public_key = var.public_key
}
