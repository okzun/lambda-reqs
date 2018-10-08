variable "project_name" {
  type        = "string"
  default     = "test"
  description = "Name of the project"
}

variable "cache_expiration_days" {
  type        = "string"
  default     = "3"
  description = "Number of days to keep the cache"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags to add to resources"
}

variable "compute_type" {
  type        = "string"
  default     = "BUILD_GENERAL1_SMALL"
  description = "Compute type for the build container"
}

variable "build_image" {
  type        = "string"
  default     = "aws/codebuild/eb-python-3.4-amazonlinux-64:2.1.6"
  description = "String containing the image to use for the build container"
}

variable "environment_variables" {
  type        = "list"
  default     = [{
    "name"  = "NONE"
    "value" = "TRUE"
  }]
  description = "A list of maps(key-value pairs) to be added as environment variables"
}

variable "artifact_bucket" {
  type        = "string"
  default     = ""
  description = "Name of the S3 bucket to store artifacts in"
}
