resource "auth0_user_attribute_profile" "user_attribute_profiles" {
  for_each = var.user_attribute_profiles

  name = each.value.name

  dynamic "user_attributes" {
    for_each = each.value.user_attributes
    content {
      auth0_mapping = user_attributes.value.auth0_mapping
      description   = user_attributes.value.description
      label         = user_attributes.value.label
      name          = user_attributes.value.name
      dynamic "oidc_mapping" {
        for_each = user_attributes.value.oidc_mapping != null ? [user_attributes.value.oidc_mapping] : []
        content {
          display_name = oidc_mapping.value.display_name
          mapping      = oidc_mapping.value.mapping
        }
      }
      profile_required = user_attributes.value.profile_required
      saml_mapping     = user_attributes.value.saml_mapping
      scim_mapping     = user_attributes.value.scim_mapping
      dynamic "strategy_overrides" {
        for_each = user_attributes.value.strategy_overrides != null ? user_attributes.value.strategy_overrides : []
        content {
          dynamic "oidc_mapping" {
            for_each = strategy_overrides.value.oidc_mapping != null ? [strategy_overrides.value.oidc_mapping] : []
            content {
              display_name = oidc_mapping.value.display_name
              mapping      = oidc_mapping.value.mapping
            }
          }
          saml_mapping = strategy_overrides.value.saml_mapping
          scim_mapping = strategy_overrides.value.scim_mapping
          strategy     = strategy_overrides.value.strategy
        }
      }
    }
  }

  dynamic "user_id" {
    for_each = each.value.user_id != null ? [each.value.user_id] : []
    content {
      oidc_mapping = user_id.value.oidc_mapping
      saml_mapping = user_id.value.saml_mapping
      scim_mapping = user_id.value.scim_mapping
      dynamic "strategy_overrides" {
        for_each = user_id.value.strategy_overrides != null ? user_id.value.strategy_overrides : []
        content {
          oidc_mapping = strategy_overrides.value.oidc_mapping
          saml_mapping = strategy_overrides.value.saml_mapping
          scim_mapping = strategy_overrides.value.scim_mapping
          strategy     = strategy_overrides.value.strategy
        }
      }
    }
  }
}

