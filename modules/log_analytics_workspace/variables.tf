variable "rg_name"{
    description = "Resource Group name"
    type        = string
}
variable "rg_location"{
    description = "Location name"
    type        = string
}

variable log_analytics_workspace_name {

  description = "Specifies the name of the Log Analytics Workspace."

}


variable sku {

  description = "specifies the Sku of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new Sku as of 2018-04-03). Defaults to PerGB2018"

}

variable retention_in_days {

  description = "The workspace data retention in days. Possible values are either 7 or range between 30 and 730."

}

variable "log_analytics_tags" {
  
}
