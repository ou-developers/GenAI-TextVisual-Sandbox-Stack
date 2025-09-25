output "compartment_ocid" {
  description = "OCID of the created compartment"
  value       = oci_identity_compartment.genai_compartment.id
}

output "compartment_name" {
  description = "Name of the created compartment"
  value       = oci_identity_compartment.genai_compartment.name
}

output "genai_admin_group_ocid" {
  description = "OCID of the Gen-AI admin group"
  value       = var.create_groups ? oci_identity_group.genai_admin_group[0].id : null
}

output "genai_user_group_ocid" {
  description = "OCID of the Gen-AI user group"
  value       = var.create_groups ? oci_identity_group.genai_user_group[0].id : null
}

output "genai_admin_policy_ocid" {
  description = "OCID of the Gen-AI admin policy"
  value       = var.create_groups ? oci_identity_policy.genai_admin_policy[0].id : null
}

output "genai_user_policy_ocid" {
  description = "OCID of the Gen-AI user policy"
  value       = var.create_groups ? oci_identity_policy.genai_user_policy[0].id : null
}

output "deployment_summary" {
  description = "Summary of deployed resources"
  value = {
    compartment_name = oci_identity_compartment.genai_compartment.name
    compartment_ocid = oci_identity_compartment.genai_compartment.id
    groups_created   = var.create_groups
    admin_group      = var.create_groups ? var.genai_admin_group_name : "not created"
    user_group       = var.create_groups ? var.genai_user_group_name : "not created"
    region           = var.region
  }
}
