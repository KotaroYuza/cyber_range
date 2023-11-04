resource "aws_security_group" "security_group_ec2" {
  name        = "${var.app_name}-sg-${var.env_name}-ec2-vpc"
  description = "vpc"
  vpc_id      = aws_vpc.vpc.id # 対象のVPC IDを指定

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # すべてのプロトコル
    cidr_blocks = ["172.16.0.0/16"] # すべてのIPアドレスからのトラフィックを許可
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # すべてのプロトコル
    cidr_blocks = ["0.0.0.0/0"] # すべてのIPアドレスへのトラフィックを許可
  }
  tags = {
    Name = "${var.app_name}-sg-${var.env_name}-ec2-vpc"
  }
}
