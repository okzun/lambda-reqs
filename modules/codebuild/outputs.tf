output "cache_bucket_name" {
  description = "Cache S3 bucket name"
  value       = "${aws_s3_bucket.cache_bucket.bucket}"
}
output "codebuild_name" {
  description = "Name of the CodeBuild resource"
  value       = "${aws_codebuild_project.codebuild.name}"
}
