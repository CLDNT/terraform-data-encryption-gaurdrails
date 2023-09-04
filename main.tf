# Create an S3 bucket with encryption enabled
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-bucket"  # Change to your desired bucket name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Create an IAM policy for access control
resource "aws_iam_policy" "secure_bucket_policy" {
  name = "secure_bucket_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "s3:DeleteObject",
      "Resource": "arn:aws:s3:::my-secure-bucket/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
EOF
}

# Create an IAM role and attach the policy
resource "aws_iam_role" "secure_bucket_role" {
  name = "secure_bucket_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "secure_bucket_policy_attachment" {
  name       = "secure_bucket_policy_attachment"
  policy_arn = aws_iam_policy.secure_bucket_policy.arn
  roles      = [aws_iam_role.secure_bucket_role.name]
}

# Create an S3 bucket policy to restrict access
resource "aws_s3_bucket_policy" "secure_bucket_access_policy" {
  bucket = aws_s3_bucket.secure_bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.secure_bucket.arn}/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "1.2.3.4/32"  # Replace with your trusted IP address
        }
      }
    }
  ]
}
EOF
}