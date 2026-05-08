variable "environment" {
  description = "Environment name"
  type        = string
}

variable "name" {
  description = "Application name"
  type        = string
}

variable "memory_size" {
  description = "Lambda memory size"
  type        = number
  default     = 128
}

variable "architectures" {
  description = "Lambda architectures"
  type        = list(string)
  default     = ["arm64"]
}