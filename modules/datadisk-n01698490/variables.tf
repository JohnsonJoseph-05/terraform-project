
variable "humber_id" {
  default        = "n01698490"
}

variable "resource_group_name" {
  default        = "n01698490-RG"
}

variable "location" {
  default        =  "canadacentral"
}

variable "disk_size_gb" {
  default     = 10
}

variable "disk_storage_account_type" {
  default     = "Standard_LRS"
}

variable "vm_ids" {
  type        = map(string)
}
