variable "owner_custom" {
    description = "Short name of owner"
}

variable "purpose_custom" {
    description = "Custom purpose"
}

variable "address_space" {
  type = list
  description = "VNET CIDR Range"
}

variable "subnets" {
  description = "A map to create multiple subnets"
  type = map(object({
    name = string
    address_prefixes = list(string)
  })) 
}