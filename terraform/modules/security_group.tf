resource "aws_security_group" "security_group_fuelcms" {
  name        = "${var.app_name}-sg-${var.env_name}-ec2-fuelcms"
  description = "${var.env_name}-fuelcms"
  vpc_id      = aws_vpc.vpc.id # 対象のVPC IDを指定

  ingress {
    description = "Allow HTTP from any"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
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
    Name = "${var.app_name}-sg-${var.env_name}-ec2-fuelcms"
  }
}
