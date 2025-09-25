# Get the root compartment (tenancy)
data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_ocid
}

# Create the Gen-AI compartment
resource "oci_identity_compartment" "genai_compartment" {
  compartment_id = var.tenancy_ocid
  description    = var.compartment_description
  name           = var.compartment_name
  enable_delete  = true

  freeform_tags = var.enable_tagging ? {
    Project     = var.project_tag
    Environment = "development"
    Purpose     = "genai-experiments"
  } : {}
}
