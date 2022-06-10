variable "owner_custom" {
    description = "Short name of owner"
}

variable "purpose_custom" {
    description = "Custom purpose"
}
variable "location" {
  description = "Location where resource is to be created"
  
}
variable "address_space" {
  type = list
  description = "VNET CIDR Range"
}

variable "subnets" {
  description = "A map to create multiple subnets"
  type = map(object({
    name = string
    address_space = list(string)
    subnet_delegation = string
  })) 
}

variable "nsg" {
  description = "A map of NSGs"
  type = map(object({
    name = string
  }))
  
}