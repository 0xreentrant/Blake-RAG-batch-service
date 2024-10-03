provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

# IAM Role
resource "aws_iam_role" "bbs_role" {
  name               = "BlakeBatchServiceRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

# IAM Policy Attachment
resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.bbs_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "sqs_access" {
  role       = aws_iam_role.bbs_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_role_policy_attachment" "rds_access" {
  role       = aws_iam_role.bbs_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

output "role_arn" {
  value = aws_iam_role.bbs_role.arn
}

resource "aws_instance" "app_server" {
  ami=""
}
