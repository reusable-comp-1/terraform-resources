resource "aws_iam_user" "spacelift_user" {
 name = "spacelift-user"
}

resource "aws_iam_user_login_profile" "spacelift_user_login_profile" {
 user    = aws_iam_user.spacelift_user.name
}


resource "aws_iam_user_policy" "s3_list_only_policy" {
 name = "S3ListOnlyPolicy"
 user = aws_iam_user.spacelift_user.name

 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [{
   "Effect": "Allow",
   "Action": [
     "s3:ListAllMyBuckets"
   ],
   "Resource": "*"
 }]
}
 EOF
}

resource "aws_iam_policy" "s3_read_only_policy" {
 name = "S3ReadOnlyPolicy"

 policy = jsonencode({
   Version = "2012-10-17"
   Statement = [{
     Effect = "Allow"
     Action = [
       "s3:ListBucket",
       "s3:GetObject"
     ]
     Resource = "*"
   }]
 })
}


resource "aws_iam_user_policy_attachment" "spacelift_user_attach_s3_read_only_policy" {
 user       = aws_iam_user.spacelift_user.name
 policy_arn = aws_iam_policy.s3_read_only_policy.arn
}



output "password" {
 value = aws_iam_user_login_profile.spacelift_user_login_profile.password
}