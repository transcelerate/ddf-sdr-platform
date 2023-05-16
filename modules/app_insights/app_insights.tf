resource "azurerm_application_insights" "app_insights" {

    name = var.app_insights_name
    resource_group_name = var.rg_name
    location = var.rg_location
    workspace_id = var.log_analytics_workspace_id
    application_type = var.application_type
    tags = var.app_insights_tags
    disable_ip_masking = false
}
resource "azurerm_application_insights_api_key" "read_telemetry" {
  name                    = "logs access"
  application_insights_id = azurerm_application_insights.app_insights.id
  read_permissions        = ["aggregate", "api", "draft", "extendqueries", "search"]
}

