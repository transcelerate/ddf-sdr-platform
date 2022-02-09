variable "app_service_name"{
    description = "App Service name"
    type        = string
}
variable "app_service_plan_id"{
    description = "App Service Plan ID"
    type        = string
}
# variable "dotnet_framework_version"{
#     description = "dotnet framework version"
#     type        = string
# }
# variable "scm_type"{
#     description = "scm type"
#     type        = string
# }
variable "rg_name"{
    description = "Resource Group name"
    type        = string
}
variable "rg_location"{
    description = "Location name"
    type        = string
}

variable "app_service_tags" {
  
  type = map(string)

}

variable "runtime_stack" {

  
}

variable "APPINSIGHTS_INSTRUMENTATIONKEY"{

}

variable "APPLICATIONINSIGHTS_CONNECTION_STRING" {
  
}

variable "https_only" {
  
}

variable "ftps_state" {
  
}

variable "use_32_bit_worker_process" {
  
}

variable "identity" {
  
}

variable "http2_enabled" {
  
} 

variable "subnet_id" {
  
}

variable "virtual_network_subnet_id" {
  
}

variable "ip_address" {
  

  
}

variable "apparname" {
  
}

variable "priority" {
  
}

variable "action" {
  
}

