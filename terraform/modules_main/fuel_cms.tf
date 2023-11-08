resource "aws_instance" "fuel_cms" {
  ami                                  = "ami-0d90332cfd66e1ff0"
  associate_public_ip_address          = true
  availability_zone                    = "ap-northeast-1d"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = false
  get_password_data                    = false
  hibernation                          = false
  host_id                              = ""
  host_resource_group_arn              = null
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.key_pair.key_name
  monitoring                           = false
  placement_group                      = ""
  placement_partition_number           = 0
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = "true"
  subnet_id                            = aws_subnet.ap_northeast_1d.id
  tags = {
    "Name" = "${var.app_name}-ec2-${var.env_name}-fuelcms"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
  }
  volume_tags = {
    "Name" = "${var.app_name}-ebs-${var.env_name}-fuelcms"
  }
  vpc_security_group_ids = [
    aws_security_group.security_group_fuelcms.id
  ]
}
