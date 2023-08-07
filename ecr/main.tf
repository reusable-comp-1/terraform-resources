resource "aws_ecr_repository" "ecr_repository" {

     for_each = toset(var.ecr_repository_names)
     name = each.key
     image_tag_mutability = var.image_tag_mutability
     image_scanning_configuration {
         scan_on_push = var.scan_on_push
     }

      dynamic "encryption_configuration" {
    for_each = var.encryption_configuration == null ? [] : [var.encryption_configuration]
    content {
      encryption_type = encryption_configuration.value.encryption_type
      kms_key         = encryption_configuration.value.kms_key
    }
  }
    

}      
     #count = var.enable_ecr_repository ? 1 : 0
     #name = var.ecr_repository_name
     