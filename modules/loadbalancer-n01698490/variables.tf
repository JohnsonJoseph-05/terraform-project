variable "humber_id" {
  default        = "n01698490"
}

variable "resource_group_name" {
  default        = "n01698490-RG"
}

variable "location" {
  default        =  "canadacentral"
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "backend_nic_ids" {
  type        = map(string)
}

variable "backend_ip_config_name" {
  default     = "internal"
}

