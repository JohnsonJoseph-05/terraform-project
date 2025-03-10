
variable "humber_id" {
  default        = "n01698490"
}

variable "resource_group_name" {
  default        = "n01698490-RG"
}

variable "location" {
  default        =  "canadacentral"
}

variable "admin_login" {
  default        = "dbadmin"
}

variable "admin_password" {
  default        = "Johnson@12345"
}

variable "sku_name" {
  default     = "B_Gen5_1"
}

variable "db_version" {
  default     = "11"
}

variable "storage_mb" {
  default     = 5120  
}

variable "backup_retention_days" {
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  default     = false
}

variable "tags" {
  type        = map(string)
  default     = {}
}


