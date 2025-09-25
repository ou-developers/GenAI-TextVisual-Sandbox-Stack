# Gen-AI Administrators Group
resource "oci_identity_group" "genai_admin_group" {
  count          = var.create_groups ? 1 : 0
  compartment_id = var.tenancy_ocid
  description    = "Group for Gen-AI platform administrators with full access to Gen-AI services and resources"
  name           = var.genai_admin_group_name

  freeform_tags = var.enable_tagging ? {
    Project = var.project_tag
    Role    = "admin"
  } : {}
}

# Gen-AI Users Group
resource "oci_identity_group" "genai_user_group" {
  count          = var.create_groups ? 1 : 0
  compartment_id = var.tenancy_ocid
  description    = "Group for Gen-AI users with access to use Gen-AI services for text generation experiments"
  name           = var.genai_user_group_name

  freeform_tags = var.enable_tagging ? {
    Project = var.project_tag
    Role    = "user"
  } : {}
}
