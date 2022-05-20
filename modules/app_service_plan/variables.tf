variable "rg_name"{
    description = "Resource Group name"
    type        = string
}
variable "rg_location"{
    description = "Location name"
    type        = string
}
variable "app_service_plan_name"{
    description = "App Service Plan name"
    type        = string
}

variable "app_service_plan_tags" {

    type = map(string)
  
}

variable "os_type" {
  
}

variable "sku_name" {
  
}

