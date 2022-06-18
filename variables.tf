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
    subnet_delegation = string
  })) 
}

variable "nsg" {
  description = "A map of NSGs"
  type = map(object({
    name = string
  }))
  
}

variable "private_link_subnet" {
    description = "ID of Private link Subnet"
  
}

variable "fw_subnet_id" {
  description = "ID of firewall Subnet"
}

variable "rt_public_subnet" {
  description = "ID of public ADB subnet"
}

variable "rt_private_subnet" {
  description = "ID of private ADB subnet"
}