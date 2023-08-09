resource "aws_s3_bucket" "s3" {
    
    for_each = toset(var.bucket_names)
    bucket                      = each.key
    acl                         =  var.acl
    #tags                        = var.tags
    

    versioning {
        enabled    = var.versioning_enabled
        mfa_delete = var.mfa_delete
    }
}

  
