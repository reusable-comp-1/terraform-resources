variable "subnet_name" {
    type = list(string)
    #default = ["public", "private"]  
}

variable "auto_create_subnetworks" {
    type = bool
    default = false
}
variable "ip_cidr_range" {
    type = list(string)
    #default = [ "10.0.0.0/24", "10.0.1.0/24" ]
}

variable "delete_default_routes_on_create" {
  description = "(Optional) If set to true, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted."
  type        = bool
  default     = false
}

variable "mtu" {
  description = "(Optional) Maximum Transmission Unit in bytes. The minimum value for this field is 1460 and the maximum value is 1500 bytes. Default is '1460'."
  type        = string
  default     = 1460

  validation {
    condition     = var.mtu >= 1460 && var.mtu <= 1500
    error_message = "The mtu expects a value between '1460' and '1500'."
  }
}

variable "routing_mode" {
  description = "(Optional) The network-wide routing mode to use. If set to 'REGIONAL', this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to 'GLOBAL', this network's cloud routers will advertise routes with all subnetworks of this network, across regions. Possible values are 'REGIONAL' and 'GLOBAL'. Default is 'REGIONAL'."
  type        = string
  default     = "REGIONAL"
}
variable "enable_ula_internal_ipv6" {
  description = "(Optional) Enable ULA internal ipv6 on this network. Enabling this feature will assign a /48 from google defined ULA prefix fd20::/20."
  type        = bool
  default     = false
}

variable "internal_ipv6_range" {
  description = "(Optional) When enabling ula internal ipv6, caller optionally can specify the /48 range they want from the google defined ULA prefix fd20::/20. The input must be a valid /48 ULA IPv6 address and must be within the fd20::/20. Operation will fail if the speficied /48 is already in used by another resource. If the field is not speficied, then a /48 range will be randomly allocated from fd20::/20 and returned via this field."
  type        = string
  default     = null
}



variable "name" {
    type = string
    #default = "gcp-network"
  
}

variable "region" {
    type = string
    #default = "us-central1"
  
}
