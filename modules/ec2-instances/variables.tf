variable "ami" {
  description = "The AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
}

variable "environment_name" {
  description = "environment name for the instance"
  type        = string
}

variable "owner_name" {
  description = "owner name"
  type        = string
}

variable "key_name" {
  description = "EC2 key name"
  type        = string
}

variable "volume_type" {
  description = "EC2 volume type"
  type        = string
}

variable "volume_size" {
  description = "EC2 Volume size"
  type        = number
}

variable "iops" {
  description = "EC2 Volume input and outputs per second"
  type        = number
}


