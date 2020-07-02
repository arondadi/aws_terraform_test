variable "key_name" {
  type        = string
  description = "eu-west-1 key_name"
  default     = "terraform_test_key_name"
}
variable "sec_group" {
  type        = string
  description = "Security group for ssh access"
  default     = "terraform_test_sec_group"
}