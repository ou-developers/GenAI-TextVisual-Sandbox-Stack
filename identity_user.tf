#############################################
# Identity: Create a console user + one-time
# Console password and add to stack group.
#############################################

resource "random_string" "user_suffix" {
  length  = 4
  upper   = false
  lower   = true
  numeric = true
  special = false
}

locals {
  resolved_user_name = coalesce(var.user_name, "stackuser-${random_string.user_suffix.result}")
}

resource "oci_identity_user" "stack_user" {
  compartment_id = var.tenancy_ocid
  name           = local.resolved_user_name
  description    = var.user_description
  email          = var.user_email
  freeform_tags  = merge(
    var.common_freeform_tags,
    { "created-by" = "orm-stack" }
  )
}

# Create a one-time Console password (OCI generates and returns it).
resource "oci_identity_ui_password" "stack_user_pw" {
  user_id = oci_identity_user.stack_user.id
}

# Add the user to the stack-created group (counted resource -> [0]).
resource "oci_identity_user_group_membership" "membership" {
  user_id  = oci_identity_user.stack_user.id
  group_id = oci_identity_group.genai_admin_group[0].id
}
