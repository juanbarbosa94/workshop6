variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "images" {
  description = "choose image for any region"
  type = map
  default = {
    us-east-1 = "ami-02e136e904f3da870"
    us-east-2 = "ami-074cce78125f09d61"
    us-west-2 = "ami-013a129d325529d4d"
    }
}

variable "region" {
  description = "Select the region from the following list us-east-1 - us-east-2 - us-west-2"
  type = string
}
variable "instance_name" {
  description = "Instance name"
  type = string
  default = "workshop6-instance"
}
variable "owner" {
  description = "suffix to assign the resource to the owner (as in Firstname-Lastname)"
}