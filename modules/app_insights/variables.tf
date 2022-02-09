variable "app_insights_name" {
  
}

variable "app_insights_tags" {
  
type= map(string)

}

variable "rg_name"{
    description = "Resource Group name"
    type        = string
}
variable "rg_location"{
    description = "Location name"
    type        = string
}

variable "log_analytics_workspace_id" {
  
}

 variable "application_type" {
  
}