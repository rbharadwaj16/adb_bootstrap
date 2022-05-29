variable "owner_custom" {
    description = "Short name of owner"
}

variable "purpose_custom" {
    description = "Custom purpose"
}

variable "address_space" {
  type = list(string)
  description = "VNET CIDR Range"
}