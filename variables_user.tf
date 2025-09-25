############################
# Variables for stack user #
############################

variable "common_freeform_tags" {
  description = "Common freeform tags to apply to created resources"
  type        = map(string)
  default     = {}
}

variable "user_name" {
  description = "Exact username to create (if null, auto-generated as stackuser-xxxx)"
  type        = string
  default     = null
}

variable "user_description" {
  description = "Description for the created user"
  type        = string
  default     = "Auto-created by ORM stack"
}

variable "user_email" {
  description = "Optional email for the created user"
  type        = string
  default     = null
}
