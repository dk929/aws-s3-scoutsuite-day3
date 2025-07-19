provider "aws" {
    region = "ap-south-1"
}

#uniq id for avoid duplicate names

resource "random_id" "bucket_id" {
    byte_length = 4
}

# create secure s3 bucket 
resource "aws_s3_bucket" "secure_bucket" {
    bucket = "day3-secure-s3-${random_id.bucket_id.hex}"
    force_destroy = true
}

# Block public access to bucket

resource "aws_s3_bucket_public_access_block" "public_access" {
    bucket = aws_s3_bucket.secure_bucket.id

    block_public_acls     = true
    block_public_policy   = true
    ignore_public_acls    = true
    restrict_public_buckets = true

}
# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.secure_bucket.id

    versioning_configuration{
        status = "Enabled"
    }
}

# Enable server-side encryption(AES256)

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
    bucket = aws_s3_bucket.secure_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# create logging bucket

resource "aws_s3_bucket" "log_bucket" {
    bucket = "day3-log-bucket-${random_id.bucket_id.hex}"
    force_destroy = true
}

# Enable server access logging
resource "aws_s3_bucket_logging" "logging" {
    bucket         = aws_s3_bucket.secure_bucket.id
    target_bucket  = aws_s3_bucket.log_bucket.id
    target_prefix  = "access-log/"
}