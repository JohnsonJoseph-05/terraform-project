variable "humber_id" {	
  default     = "n01698490"
}

variable "location" {
  default     = "canadacentral"
}

variable "resource_group" {
  default     = "n01698490-RG"
}

variable "vnet_address_space" {
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_space" {
  default     = ["10.0.1.0/24"]
}

variable "tags" {
  type        = map(string)
  default     = {}
}

