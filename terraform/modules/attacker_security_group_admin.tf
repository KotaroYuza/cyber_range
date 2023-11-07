resource "aws_security_group" "attacker_security_group_ec2_admin" {
  name        = "${var.app_name}-sg-${var.env_name}-attacker-ec2-admin"
  description = "${var.env_name}-attacker-admin"
  vpc_id      = aws_vpc.attacker_vpc.id # 対象のVPC IDを指定

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                                   # すべてのプロトコル
    cidr_blocks = ["133.20.58.25/32", "133.20.58.28/32"] # すべてのIPアドレスからのトラフィックを許可
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # すべてのプロトコル
    cidr_blocks = ["0.0.0.0/0"] # すべてのIPアドレスへのトラフィックを許可
  }
  tags = {
    Name = "${var.app_name}-sg-${var.env_name}-attacker-ec2-admin"
  }
}
