variable "ami_id" {
  default = "ami-0ed961fa828560210"
}

variable "snapshot_id" {
  default = "ami-0b3f070a579f165bd"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "public_cidr" {
  default = "10.0.1.0/24"
}

variable "public_cidr_one" {
  default = "10.0.3.0/24"
}

variable "task_name" {
  default = "ecs_demo"
}

variable "image_name" {
  default = "ktao329/showcase_flask_app" #  "ktao329/showcase_flask_app"
}

variable "container_port" {
  default = 5000
}

variable "container_count" {
  default = 1
}

variable "env" {
  type        = string
  default     = "development"
  description = "development environment"
}

variable "availability_zone" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

