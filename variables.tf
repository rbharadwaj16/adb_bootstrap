variable "owner" {
    description = "Owner name of the resource"
}

variable "purpose" {
    description = "Purpose of the resource"
}

variable "location" {
    description = "Location in which resource needs to be spinned up"
}

variable "org" {
    description = "Org name / Client name"
  
}
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
    address_space = list(string)
    subnet_delegation = bool
  })) 
}

variable "nsg" {
  description = "A map of NSGs"
  type = map(object({
    name = string
  }))
  
}