variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "alb_subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_target_port" {
  description = "Port for the target group"
  type        = number
}
