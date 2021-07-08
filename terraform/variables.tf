variable "prefix" {
  type = string
}

variable "environment" {
  type = string
  default = "dev"
}

variable "omop_rg_location" {
  type = string
  default = "westus2"
}

variable "omop_password" {
  type = string
}

variable "omop_db_size" {
  type = string
  default = 20 # max size gb
}

variable "omop_db_sku" {
  type = string
  default = "BC_Gen5_10"
}

variable log_file {
  description = "Log file name to create with the seeding results."
  default     = "db-init.log"
}
