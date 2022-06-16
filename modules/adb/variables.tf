variable "owner_custom" {
  description = "Short name of owner"
}

variable "purpose_custom" {
  description = "Custom purpose"
}
variable "location" {
  description = "Location in which resource needs to be spinned up"
}

variable "vnet_id" {
  description = "VNET ID to be passed for ADB"

}

variable "public_subnet_network_security_group_association_id" {
}

variable "private_subnet_network_security_group_association_id" {
}

variable "key_vault_id" {
  
}

variable "key_vault_uri" {
  
}