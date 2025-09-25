######################
# User info outputs  #
######################

output "new_user_name" {
  description = "Username created by the stack"
  value       = oci_identity_user.stack_user.name
}

output "new_user_ocid" {
  description = "OCID of the created user"
  value       = oci_identity_user.stack_user.id
}

output "added_to_group_name" {
  description = "Group name the user was added to"
  value       = oci_identity_group.genai_admin_group[0].name
}

# One-time Console password returned by OCI; user must change at first login.
output "console_password" {
  description = "One-time Console UI password for the created user"
  value       = oci_identity_ui_password.stack_user_pw.password
}


