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
variable "app_service_plan_os"{
    description = "App Service Plan Operating System"
    type        = string
}

variable "app_service_plan_tags" {

    type = map(string)
  
}

variable "app_service_tier" {
  
}

variable "app_service_size" {
  
}

