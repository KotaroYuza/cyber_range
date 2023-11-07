resource "aws_security_group" "attacker_security_group_attacker" {
  name        = "${var.app_name}-sg-${var.env_name}-attacker-ec2-attacker"
  description = "${var.env_name}-attacker"
  vpc_id      = aws_vpc.attacker_vpc.id # 対象のVPC IDを指定

  ingress {
    from_port = 9001
    to_port   = 9001
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # すべてのプロトコル
    cidr_blocks = ["0.0.0.0/0"] # すべてのIPアドレスへのトラフィックを許可
  }
  tags = {
    Name = "${var.app_name}-sg-${var.env_name}-attacker-ec2-attacker"
  }
}
