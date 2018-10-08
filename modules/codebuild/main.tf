resource "aws_s3_bucket" "cache_bucket" {
  acl           = "private"
  force_destroy = true
  tags          = "${var.tags}"

  lifecycle_rule {
    id      = "codebuildcache"
    enabled = true

    prefix  = "/"
    tags    = "${var.tags}"

    expiration {
      days = "${var.cache_expiration_days}"
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild" {
  role   = "${aws_iam_role.codebuild.name}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.cache_bucket.arn}",
        "${aws_s3_bucket.cache_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_codebuild_project" "codebuild" {
  name              = "${var.project_name}"
  description       = "Lambda requirements bundler for ${var.project_name}"
  build_timeout     = "5"
  service_role      = "${aws_iam_role.codebuild.arn}"
  tags              = "${var.tags}"

  artifacts {
    type            = "S3"
    location        = "${var.artifact_bucket}"
  }

  cache {
    type            = "S3"
    location        = "${aws_s3_bucket.cache_bucket.bucket}"
  }

  environment {
    compute_type    = "${var.compute_type}"
    image           = "${var.build_image}"
    type            = "LINUX_CONTAINER"

    environment_variable = [
      "${var.environment_variables}"
    ]
  }

  source {
    type            = "S3"
    location        = "${var.artifact_bucket}"
  }
}
