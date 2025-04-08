resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_s3

  tags = {
    Name        = var.bucket_s3
   
  }
}


