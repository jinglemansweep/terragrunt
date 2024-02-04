# Home Terragrunt Setup

This repository is home to Terragrunt configurations and resources required for provisioning both internal and external home lab resources.

## Requirements

* [Terraform Cloud](https://app.terraform.io/) or similar Terraform backend
* [Infisical](https://infisical.com/) secrets management

## Configuration

The following environment variables need to be set:

* `TF_VAR_tf_cloud_project`: Project Name on Terraform Cloud
* `TF_VAR_infisical_service_token`: API Service Token for Infisical Cloud (*Project* > *Access Control* > *Service Tokens*)

## Quickstart

Login to Terraform Cloud:

    terraform login

Set required configuration environment variables:

    export TF_VAR_tf_cloud_project="homelab"
    export TF_VAR_infisical_service_token="st...."

Navigate to the environment and plans you want to apply, initialise Terragrunt and perform a test plan:

    cd ./envs/prod/infra/dns
    terragrunt init
    terragrunt plan

## Development

### Services / Resources

Create a new service or resource in a specific environment:

    mkdir -p ./envs/prod/services/my-service

Add a `terragrunt.hcl` configuration file:

    include "root" {
      path = find_in_parent_folders()
    }

    terraform {
      source = "../../../../modules//path/to/module"
    }

### Modules

Create a new module:

    mkdir -p ./modules/infra/my-module

Create a test `output.tf` resource that outputs a value from the secrets manager:

    output "cloudflare_api_token" {
      value = data.infisical_secrets.secrets.secrets["MY_SECRET_KEY"]
    }
