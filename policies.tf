# Policy for Gen-AI Administrators
resource "oci_identity_policy" "genai_admin_policy" {
  count          = var.create_groups ? 1 : 0
  compartment_id = var.tenancy_ocid
  description    = "Policy granting Gen-AI administrators full access to manage Gen-AI services and related resources"
  name           = "${var.compartment_name}-admin-policy"

  statements = [
    "Allow group ${var.genai_admin_group_name} to manage generative-ai-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_admin_group_name} to manage ai-service-language-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_admin_group_name} to manage ai-service-document-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_admin_group_name} to manage ai-service-speech-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_admin_group_name} to manage ai-service-vision-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_admin_group_name} to manage data-science-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_admin_group_name} to manage object-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_admin_group_name} to manage logging-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_admin_group_name} to manage metrics in compartment ${var.compartment_name}"
    , "Allow group ${var.genai_admin_group_name} to manage alarms in compartment ${var.compartment_name}",
    "Allow group ${var.genai_admin_group_name} to use cloud-shell in tenancy",
    "Allow group ${var.genai_admin_group_name} to inspect compartments in tenancy"
  ]

  depends_on = [
    oci_identity_compartment.genai_compartment,
    oci_identity_group.genai_admin_group
  ]

  freeform_tags = var.enable_tagging ? {
    Project = var.project_tag
    Type    = "admin-policy"
  } : {}
}

# Policy for Gen-AI Users
resource "oci_identity_policy" "genai_user_policy" {
  count          = var.create_groups ? 1 : 0
  compartment_id = var.tenancy_ocid
  description    = "Policy granting Gen-AI users access to use Gen-AI services for text generation experiments"
  name           = "${var.compartment_name}-user-policy"

  statements = [
    "Allow group ${var.genai_user_group_name} to use generative-ai-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_user_group_name} to use ai-service-language-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_user_group_name} to read ai-service-document-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_user_group_name} to read buckets in compartment ${var.compartment_name}",
    "Allow group ${var.genai_user_group_name} to read objects in compartment ${var.compartment_name}",
    "Allow group ${var.genai_user_group_name} to manage objects in compartment ${var.compartment_name} where target.bucket.name=/genai-.*/",
    "Allow group ${var.genai_user_group_name} to use data-science-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_user_group_name} to read logging-family in compartment ${var.compartment_name}",
    "Allow group ${var.genai_user_group_name} to read metrics in compartment ${var.compartment_name}",
    "Allow group ${var.genai_user_group_name} to use cloud-shell in tenancy",
    "Allow group ${var.genai_user_group_name} to inspect compartments in tenancy"
  ]

  depends_on = [
    oci_identity_compartment.genai_compartment,
    oci_identity_group.genai_user_group
  ]

  freeform_tags = var.enable_tagging ? {
    Project = var.project_tag
    Type    = "user-policy"
  } : {}
}
