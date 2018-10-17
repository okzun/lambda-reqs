module "codebuild" {
    source                  = "modules/codebuild"
    project_name            = "testing"
    aws_region              = "${var.aws_region}"

    # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    build_image             = "${var.build_image}"
    compute_type            = "${var.compute_type}"
    artifact_bucket         = "${var.artifact_bucket}"
    artifact_path           = "${var.artifact_path}"
    artifact_bucket_region  = "${var.artifact_bucket_region}"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket = "okzun-remote-state"
    region = "us-west-2"
    key = "okzun/terraform.tfstate"
  }
}
