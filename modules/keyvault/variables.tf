variable "owner_custom" {
  description = "Short name of owner"
}

variable "purpose_custom" {
  description = "Custom purpose"
}
variable "location" {
  description = "Location in which resource needs to be spinned up"
}


variable "private_link_subnet" {
    description = "ID of Private link Subnet"
  
}

variable "vnet_id" {
  description = "Vnet ID for DNS integration"
}