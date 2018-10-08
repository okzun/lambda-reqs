module "build" {
    source              = "modules/codebuild"
    namespace           = "general"
    name                = "ci"
    stage               = "staging"

    # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    build_image         = "aws/codebuild/eb-python-3.4-amazonlinux-64:2.1.6"
    build_compute_type  = "BUILD_GENERAL1_SMALL"

    # These attributes are optional, used as ENV variables when building Docker images and pushing them to ECR
    # For more info:
    # http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html
    # https://www.terraform.io/docs/providers/aws/r/codebuild_project.html

    # privileged_mode     = "false"
    # aws_region          = "us-east-1"
    # aws_account_id      = "076267409246"
    # image_tag           = "latest"

    # Optional extra environment variables
//    environment_variables = [{
//        name  = "JENKINS_URL"
//        value = "https://jenkins.example.com"
//      },
//      {
//        name  = "COMPANY_NAME"
//        value = "Amazon"
//      },
//      {
//        name = "TIME_ZONE"
//        value = "Pacific/Auckland"
//
//      }]
}
