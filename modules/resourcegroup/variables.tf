variable "rg_name"{
    description = "Resource Group name"
    type        = string
}
variable "rg_location"{
    description = "Location name"
    type        = string
}
variable "rg_tags" {
   type = map(string)
}