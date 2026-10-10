output "user_attribute_profiles_id" {
  description = "Map of id values across all user_attribute_profiles, keyed the same as var.user_attribute_profiles except keys with no id are omitted"
  value       = { for k, v in auth0_user_attribute_profile.user_attribute_profiles : k => v.id if v.id != null && length(v.id) > 0 }
}
output "user_attribute_profiles_name" {
  description = "Map of name values across all user_attribute_profiles, keyed the same as var.user_attribute_profiles except keys with no name are omitted"
  value       = { for k, v in auth0_user_attribute_profile.user_attribute_profiles : k => v.name if v.name != null && length(v.name) > 0 }
}
output "user_attribute_profiles_user_attributes" {
  description = "Map of user_attributes values across all user_attribute_profiles, keyed the same as var.user_attribute_profiles except keys with no user_attributes are omitted"
  value       = { for k, v in auth0_user_attribute_profile.user_attribute_profiles : k => v.user_attributes if v.user_attributes != null && length(v.user_attributes) > 0 }
}
output "user_attribute_profiles_user_id" {
  description = "Map of user_id values across all user_attribute_profiles, keyed the same as var.user_attribute_profiles except keys with no user_id are omitted"
  value       = { for k, v in auth0_user_attribute_profile.user_attribute_profiles : k => one(v.user_id) if v.user_id != null && length(v.user_id) > 0 }
}

