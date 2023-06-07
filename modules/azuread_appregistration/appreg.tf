data "azuread_client_config" "current" {}

resource "random_uuid" "appuser_role_id" {}

resource "random_uuid" "orgadmin_role_id" {}

resource "azuread_application" "spn_ui_test" {
  
  display_name     = var.display_name
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = var.sign_in_audience
# api {
#     mapped_claims_enabled          = true
#     requested_access_token_version = 2

#     oauth2_permission_scope {
#       admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
#       admin_consent_display_name = "ui-access"
#       enabled                    = true
#       id                         = "96183846-204b-4b43-82e1-5d2222eb4b9b"
#       type                       = "User"
#       user_consent_description   = "Allow the application to access example on your behalf."
#       user_consent_display_name  = "ui-access"
#       value                      = "ui-access"
#     }
#   }

  app_role {
    allowed_member_types = ["User"]
    description          = "Application User Access"
    display_name         = "App User Role"
    enabled              = true
    id                   = random_uuid.appuser_role_id.result
    value                = "app.user"
  }

  app_role {
    allowed_member_types = ["User"]
    description          = "Organization Admin Access"
    display_name         = "Org Admin Role"
    enabled              = true
    id                   = random_uuid.orgadmin_role_id.result
    value                = "org.admin"
  }

  optional_claims {
   
    id_token {
      name                  = var.claimname
      source                = "user"
      essential             = true
      additional_properties = ["emit_as_roles"]
    }

    
  }

  single_page_application {
    
    redirect_uris = var.redirect_uris

  }

  web {
    
    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

  required_resource_access {

    resource_app_id = "00000003-0000-0000-c000-000000000000"  # MS Graph app id.

    resource_access {
      id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All id.
      type = "Role"
    }
  }
}

resource "azuread_service_principal" "example" {
  application_id               = azuread_application.spn_ui_test.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]

    feature_tags {
    enterprise = true
    gallery    = false
  }
}
# resource "azuread_application_password" "example" {
#   application_object_id = azuread_application.spn_ui_test.object_id
#   display_name          = "client secret"
#   end_date_relative     = "4320h" # expire in 6 months
# }
