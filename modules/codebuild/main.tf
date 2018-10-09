data "template_file" "buildspec" {
  template      = "${file("${path.module}/${var.buildspec_file}")}"

  vars {
    app_name    = "${var.project_name}"
  }
}

resource "aws_iam_role" "codebuild" {
  name = "codebuild"

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
        "arn:aws:s3:::${var.artifact_bucket}",
        "arn:aws:s3:::${var.artifact_bucket}/*"
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
    path            = "${var.artifact_path}"
    name            = "output.zip"
    packaging       = "ZIP"
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
    location        = "arn:aws:s3:::${var.artifact_bucket}/${var.artifact_path}/requirements.zip"
    buildspec       = "${data.template_file.buildspec.rendered}"
  }
}
