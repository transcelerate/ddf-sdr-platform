output "adgroup_id" {

    value = data.azuread_group.ADGroupName.object_id
  
}