variable "owner_custom" {
  description = "Short name of owner"
}

variable "purpose_custom" {
  description = "Custom purpose"
}
variable "location" {
  description = "Location in which resource needs to be spinned up"
}

variable "fw_subnet_id" {
  description = "ID of firewall subnet"
}

variable "rt_public_subnet" {
  description = "ID of public ADB subnet"
}

variable "rt_private_subnet" {
  description = "ID of private ADB subnet"
}