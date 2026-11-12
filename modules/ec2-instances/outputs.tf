
output "instance_id" {
  value = var.environment_name == "prod" ? aws_instance.prod_instances[0].id : aws_instance.non_prod_instances[0].id
}

output "instance_name" {
  value = var.environment_name == "prod" ? aws_instance.prod_instances[0].tags["Name"] : aws_instance.non_prod_instances[0].tags["Name"]
}

output "private_ip" {
  value = var.environment_name == "prod" ? aws_instance.prod_instances[0].private_ip : aws_instance.non_prod_instances[0].private_ip
}


