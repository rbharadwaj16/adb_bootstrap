variable "owner_custom" {
  description = "Short name of owner"
}

variable "purpose_custom" {
  description = "Custom purpose"
}
variable "location" {
  description = "Location in which resource needs to be spinned up"
}

variable "key_vault_id" {
    description = "Key vault ID to store generate and store secrets"
  
}

variable "private_link_subnet" {
    description = "ID of Private link Subnet"
  
}

variable "vnet_id" {
  description = "Vnet ID for DNS integration"
}