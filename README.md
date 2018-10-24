# Lambda CI/CD and deployment

A Terraform-based, one-stop shop for building and deployment AWS Lambda functions and their required infrastructure. 

## Getting Started

To get started using this project, do the following:

* clone this repo
* do a `terraform init` in that directory
* create your `terraform.tfvars` file to fill out your configuration
* upload Lambda zip to your artifact bucket
* `terraform apply` to begin blasting out infrastructure!

### Vars

Here are the variables you'll probably need to fill out:
**aws_region**: The region in which to deploy the infrastructure
**aws_profile**: The profile of credentials to use in deployment
**project_name**: The name of the project(acts as a prefix to infrastructure naming)
**artifact_bucket**: Name of the S3 bucket where Lambda artifacts are stored
**artifact_path**: Path in the artifact bucket where the zip file is stored.
**lambda_handler**: String for the handler in the format "filename.handler_method", i.e. "main.handler" for filename "main.py", method "handler()"

### Prerequisites

You'll need the following installed:
* terraform
* aws command-line tools

## Running the tests

Coming soon!

## Authors

* **James Carignan**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
