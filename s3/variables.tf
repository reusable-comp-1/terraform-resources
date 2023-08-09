variable "access_key" {
    type = string
    default = "AKIAR66BGEJ6SJ7CSZNQ"
}

variable "secret_key" {
    type = string
    default = "NpexkV01kuv2lSZ+Xs7xh7s2/bXXD6yDg9dj09MJ"
}

variable "region" {
    type = string
    default = "us-east-2"  
}

variable "bucket_names" {
    type = list(string)
    default = ["test-b1-indium","test-b2-indium"]
} 

variable "acl" {
  type = string
  default = "private"
}

variable "versioning_enabled" {
  type = bool 
  default = true
}


variable "mfa_delete" {
  type = bool 
  default = false
}

# variable "tags" {
#     type = map(string)

#     default = {
#           Environment = "test"
#           ManagedBy   = "terraform"
#     }    
# }  
  
