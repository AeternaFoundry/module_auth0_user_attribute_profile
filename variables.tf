variable "user_attribute_profiles" {
  description = <<EOT
Map of user_attribute_profiles, attributes below
Required:
    - name
    - user_attributes (block):
        - auth0_mapping (required)
        - description (required)
        - label (required)
        - name (required)
        - oidc_mapping (optional, block):
            - display_name (optional)
            - mapping (required)
        - profile_required (required)
        - saml_mapping (optional)
        - scim_mapping (optional)
        - strategy_overrides (optional, block):
            - oidc_mapping (optional, block):
                - display_name (optional)
                - mapping (required)
            - saml_mapping (optional)
            - scim_mapping (optional)
            - strategy (required)
Optional:
    - user_id (block):
        - oidc_mapping (optional)
        - saml_mapping (optional)
        - scim_mapping (optional)
        - strategy_overrides (optional, block):
            - oidc_mapping (optional)
            - saml_mapping (optional)
            - scim_mapping (optional)
            - strategy (required)
EOT

  type = map(object({
    name = string
    user_attributes = list(object({
      auth0_mapping = string
      description   = string
      label         = string
      name          = string
      oidc_mapping = optional(object({
        display_name = optional(string)
        mapping      = string
      }))
      profile_required = bool
      saml_mapping     = optional(list(string))
      scim_mapping     = optional(string)
      strategy_overrides = optional(list(object({
        oidc_mapping = optional(object({
          display_name = optional(string)
          mapping      = string
        }))
        saml_mapping = optional(list(string))
        scim_mapping = optional(string)
        strategy     = string
      })))
    }))
    user_id = optional(object({
      oidc_mapping = optional(string)
      saml_mapping = optional(list(string))
      scim_mapping = optional(string)
      strategy_overrides = optional(list(object({
        oidc_mapping = optional(string)
        saml_mapping = optional(list(string))
        scim_mapping = optional(string)
        strategy     = string
      })))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        length(v.user_attributes) >= 1 && length(v.user_attributes) <= 64
      )
    ])
    error_message = "Each user_attributes list must contain between 1 and 64 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        v.user_id == null || (v.user_id.oidc_mapping == null || (contains(["sub"], v.user_id.oidc_mapping)))
      )
    ])
    error_message = "must be one of: \"sub\""
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        v.user_id == null || (v.user_id.saml_mapping == null || (alltrue([for x in v.user_id.saml_mapping : length(x) >= 1 && length(x) <= 128])))
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        v.user_id == null || (v.user_id.scim_mapping == null || (length(v.user_id.scim_mapping) >= 1 && length(v.user_id.scim_mapping) <= 128))
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        v.user_id == null || (v.user_id.strategy_overrides == null || alltrue([for item in v.user_id.strategy_overrides : (item.oidc_mapping == null || (contains(["email", "sub", "oid"], item.oidc_mapping)))]))
      )
    ])
    error_message = "must be one of: \"email\", \"sub\", \"oid\""
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        v.user_id == null || (v.user_id.strategy_overrides == null || alltrue([for item in v.user_id.strategy_overrides : (item.saml_mapping == null || (alltrue([for x in item.saml_mapping : length(x) >= 1 && length(x) <= 128])))]))
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        v.user_id == null || (v.user_id.strategy_overrides == null || alltrue([for item in v.user_id.strategy_overrides : (item.scim_mapping == null || (length(item.scim_mapping) >= 1 && length(item.scim_mapping) <= 128))]))
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (length(item.name) >= 1 && length(item.name) <= 50)])
      )
    ])
    error_message = "must be between 1 and 50 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (length(item.description) >= 1 && length(item.description) <= 128)])
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (length(item.label) >= 1 && length(item.label) <= 128)])
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (length(item.auth0_mapping) >= 1 && length(item.auth0_mapping) <= 50)])
      )
    ])
    error_message = "must be between 1 and 50 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (item.oidc_mapping == null || (length(item.oidc_mapping.mapping) >= 1 && length(item.oidc_mapping.mapping) <= 50))])
      )
    ])
    error_message = "must be between 1 and 50 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (item.oidc_mapping == null || (item.oidc_mapping.display_name == null || (length(item.oidc_mapping.display_name) >= 1 && length(item.oidc_mapping.display_name) <= 50)))])
      )
    ])
    error_message = "must be between 1 and 50 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (item.saml_mapping == null || (alltrue([for x in item.saml_mapping : length(x) >= 1 && length(x) <= 128])))])
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (item.scim_mapping == null || (length(item.scim_mapping) >= 1 && length(item.scim_mapping) <= 128))])
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (item.strategy_overrides == null || alltrue([for item in item.strategy_overrides : (contains(["ad", "adfs", "google-apps", "oidc", "okta", "pingfederate", "samlp", "waad"], item.strategy))]))])
      )
    ])
    error_message = "must be one of: \"ad\", \"adfs\", \"google-apps\", \"oidc\", \"okta\", \"pingfederate\", \"samlp\", \"waad\""
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (item.strategy_overrides == null || alltrue([for item in item.strategy_overrides : (item.oidc_mapping == null || (length(item.oidc_mapping.mapping) >= 1 && length(item.oidc_mapping.mapping) <= 50))]))])
      )
    ])
    error_message = "must be between 1 and 50 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (item.strategy_overrides == null || alltrue([for item in item.strategy_overrides : (item.oidc_mapping == null || (item.oidc_mapping.display_name == null || (length(item.oidc_mapping.display_name) >= 1 && length(item.oidc_mapping.display_name) <= 50)))]))])
      )
    ])
    error_message = "must be between 1 and 50 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (item.strategy_overrides == null || alltrue([for item in item.strategy_overrides : (item.saml_mapping == null || (alltrue([for x in item.saml_mapping : length(x) >= 1 && length(x) <= 128])))]))])
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.user_attribute_profiles : (
        alltrue([for item in v.user_attributes : (item.strategy_overrides == null || alltrue([for item in item.strategy_overrides : (item.scim_mapping == null || (length(item.scim_mapping) >= 1 && length(item.scim_mapping) <= 128))]))])
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
}

