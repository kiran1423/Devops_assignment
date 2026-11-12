
locals {
  instances = {
    web1 = {
      instance_type    = "t3.micro"
      key_name         = "aws_key_1"
      volume_type      = "standard"
      volume_size      = 10
      environment_name = "dev"
      iops             = null
    }

    web2 = {
      instance_type    = "t3.small"
      key_name         = "aws_key_2"
      volume_type      = "gp2"
      volume_size      = 14
      environment_name = "test"
      iops             = null
    }

    web3 = {
      instance_type    = "t3.medium"
      key_name         = "aws_key_3"
      volume_type      = "io1"
      volume_size      = 18
      environment_name = "test2"
      iops             = 100
    }

    web4 = {
      instance_type    = "c7i-flex.large"
      key_name         = "aws_key_4"
      volume_type      = "io2"
      volume_size      = 22
      environment_name = "stage"
      iops             = 1000
    }

    web5 = {
      instance_type    = "m7i-flex.large"
      key_name         = "aws_key_5"
      volume_type      = "gp3"
      volume_size      = 26
      environment_name = "prod"
      iops             = 3000
    }
  }
}

# Create EC2 instance
module "ec2" {
  source           = "./modules/ec2-instances"
  ami              = "ami-04b938437b69a2c9c"
  for_each         = local.instances
  instance_type    = each.value.instance_type
  instance_name    = "${each.key}-Server"
  key_name         = each.value.key_name
  volume_type      = each.value.volume_type
  volume_size      = each.value.volume_size
  iops             = each.value.iops
  environment_name = each.value.environment_name
  owner_name       = "DevOps-Team"
}



