#  tf-azurerm-module_primitive-app_configuration_data

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module is used to manage data (feature flags or key value pairs) within an Azure App Configuration store

NOTE: The user / principal applying this module should have the "App Configuration Data Reader" and "App Configuration Data Owner" roles on the store

## Usage

See [examples/app_configuration_data](examples/app_configuration_data) for a full working example.

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines `pre-commit` hooks for Terraform formatting, validation, documentation generation, and detect-secrets. Hooks are installed when you run `make configure`. Go linting runs via `make lint` in local development and CI, not via pre-commit.

### Terratest examples

Post-deploy tests in `tests/post_deploy_functional/` and `tests/post_deploy_functional_readonly/` target `examples/app_configuration_data` via an explicit folder constant in each `main_test.go`. Adding another example requires a new test entry point or updating that constant; it is not picked up automatically.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.
2. Ensure you are signed into Microsoft Azure for the module under test in your current console session and are using an approved non-production subscription.
3. Run the Terraform and Golang linters:

```
make lint
```

4. Once linters pass, run integration tests (apply, test, destroy):

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, are performed in CI. Running them locally before opening a PR helps ensure a smooth review.

### Review & Merge Process

Open a Pull Request to the default (`main`) branch. The PR title must follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format to merge and to drive semantic versioning.

Ensure CI workflows pass, address review feedback, and obtain approvals required by `CODEOWNERS`.

### Automatic Updates

Shared configuration and workflow files are largely managed through [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton). Avoid one-off edits to copied skeleton files in this repository unless necessary (for example `.gitignore` entries for generated artifacts). Use `copier check-update` / `copier update` when refreshing from the skeleton.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.117 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_configuration_feature.feature](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_key.key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_configuration_store_id"></a> [configuration\_store\_id](#input\_configuration\_store\_id) | ID of the App Configuration store | `string` | n/a | yes |
| <a name="input_features"></a> [features](#input\_features) | map(object({<br/>      name        = name of the feature flag<br/>      description = description of the feature<br/>      enabled     = status of the feature, defaults to false<br/>      label       = label (partition) of the app configuration store<br/>      locked      = whether the feature is locked to prevent changes<br/><br/>      targeting\_filter = optional(object({<br/>        default\_rollout\_percentage = default percentage of the user base for which to enable the feature<br/>        groups                     = map of groups and their rollout percentages (groups defined in the application logic)<br/>        users                      = list of users to target (users defined in the application logic)<br/>      }))<br/><br/>      timewindow\_filter = optional(object({<br/>        start = the earliest timestamp the feature is enabled, RFC3339 format<br/>        end   = the latest timestamp the feature is enabled, RFC3339 format<br/>      }))<br/>    })) | <pre>map(object({<br/>    name        = string<br/>    description = optional(string)<br/>    enabled     = optional(bool)<br/>    label       = optional(string)<br/>    locked      = optional(bool)<br/><br/>    targeting_filter = optional(object({<br/>      default_rollout_percentage = number<br/>      groups                     = optional(map(number))<br/>      users                      = optional(list(string))<br/>    }))<br/><br/>    timewindow_filter = optional(object({<br/>      start = optional(string)<br/>      end   = optional(string)<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_keys"></a> [keys](#input\_keys) | map(object({<br/>      content\_type        = content type of the configuration key<br/>      label               = label (partition) of the app configuration store<br/>      value               = value of the configuration key<br/>      locked              = whether the key is locked to prevent changes<br/>      type                = type of the configuration key, `kv` or `vault` (key vault reference)<br/>      vault\_key\_reference = id of the vault secret this key refers to<br/>      tags                = custom tags to assign<br/>    })) | <pre>map(object({<br/>    content_type        = optional(string)<br/>    label               = optional(string)<br/>    value               = optional(string)<br/>    locked              = optional(bool)<br/>    type                = optional(string)<br/>    vault_key_reference = optional(string)<br/>    tags                = optional(map(string))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_configuration_features"></a> [app\_configuration\_features](#output\_app\_configuration\_features) | n/a |
| <a name="output_app_configuration_keys"></a> [app\_configuration\_keys](#output\_app\_configuration\_keys) | n/a |
| <a name="output_configuration_store_id"></a> [configuration\_store\_id](#output\_configuration\_store\_id) | n/a |
<!-- END_TF_DOCS -->
