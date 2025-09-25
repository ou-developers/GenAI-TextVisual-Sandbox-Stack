variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
}

variable "compartment_name" {
  description = "Name for the Gen-AI compartment"
  type        = string
  default     = "genai-experiments"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_-]*$", var.compartment_name))
    error_message = "Compartment name must start with a letter and contain only letters, numbers, underscores, and hyphens."
  }
}

variable "compartment_description" {
  description = "Description for the Gen-AI compartment"
  type        = string
  default     = "Compartment for Gen-AI text generation experiments and resources"
}

variable "create_groups" {
  description = "Whether to create IAM groups for Gen-AI access"
  type        = bool
  default     = true
}

variable "genai_admin_group_name" {
  description = "Name for the Gen-AI administrators group"
  type        = string
  default     = "genai-admins"
}

variable "genai_user_group_name" {
  description = "Name for the Gen-AI users group"
  type        = string
  default     = "genai-users"
}

variable "enable_tagging" {
  description = "Whether to apply tags to created resources"
  type        = bool
  default     = true
}

variable "project_tag" {
  description = "Project tag to apply to resources"
  type        = string
  default     = "genai-platform"
}
