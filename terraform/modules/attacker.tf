resource "aws_instance" "attacker_attacker" {
  ami                                  = "ami-019e138eea00aec05"
  associate_public_ip_address          = true
  availability_zone                    = "ap-northeast-1d"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = false
  get_password_data                    = false
  hibernation                          = false
  host_id                              = ""
  host_resource_group_arn              = null
  iam_instance_profile                 = ""
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.medium"
  key_name                             = aws_key_pair.attacker_key_pair.key_name
  monitoring                           = false
  placement_group                      = ""
  placement_partition_number           = 0
  #private_ip                           = "172.16.1.176"
  secondary_private_ips = []
  security_groups       = []
  source_dest_check     = "true"
  subnet_id             = aws_subnet.attacker_ap_northeast_1d.id
  tags = {
    "Name" = "${var.app_name}-ec2-${var.env_name}-attacker-kali"
  }
  tenancy                     = "default"
  user_data                   = data.template_file.user_data.rendered
  user_data_base64            = null
  user_data_replace_on_change = null

  root_block_device {
    volume_size           = 12
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
  }


  volume_tags = {
    "Name" = "${var.app_name}-ebs-${var.env_name}-attacker-kali"
  }
  vpc_security_group_ids = [
    aws_security_group.attacker_security_group_attacker.id
  ]
}

# テンプレートファイルを読み込む
data "template_file" "user_data" {
  template = file("./files/user_data_${var.env_name}.sh.tpl")

  vars = {
    FUEL_CMS_IP = aws_instance.fuel_cms.public_ip
  }
}
