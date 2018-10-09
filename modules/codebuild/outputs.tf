output "codebuild_name" {
  description = "Name of the CodeBuild resource"
  value       = "${aws_codebuild_project.codebuild.name}"
}
