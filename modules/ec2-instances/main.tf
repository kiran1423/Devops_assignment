
resource "aws_instance" "non_prod_instances" {
  count = var.environment_name != "prod" ? 1 : 0

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    iops        = var.iops
    encrypted   = true
  }

  tags = {
    Name        = var.instance_name
    Environment = var.environment_name
    owner      = var.owner_name

  }

}

resource "aws_instance" "prod_instances" {
  count = var.environment_name == "prod" ? 1 : 0

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    iops        = var.iops
    encrypted   = true
  }

  tags = {
    Name        = var.instance_name
    Environment = var.environment_name
    owner      = var.owner_name

  }

  lifecycle {
    prevent_destroy = true
  }

}

