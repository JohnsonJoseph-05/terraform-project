variable "humber_id" {
  default        = "n01698490"
}

variable "resource_group_name" {
  default        = "n01698490-RG"
}

variable "subnet_id" {
  type        = string
}

variable "location" {
  default        =  "canadacentral"
}

variable "boot_diagnostics_storage_uri" {
  type        = string
}

variable "admin_username" {
  default        = "azureuser"
}

variable "admin_password" {
  default        = "Johnson@12345"
}

variable "tags" {
  type        = map(string)
}

variable "public_key" {
  default        = "/home/n01698490/john/my_rsa_key.pub"
}

