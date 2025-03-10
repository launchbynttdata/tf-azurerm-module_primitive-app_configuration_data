#  tf-azurerm-module_primitive-app_configuration_data

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module is used to manage data (feature flags or key value pairs) within an Azure App Configuration store

NOTE: The user / principal applying this module should have the "App Configuration Data Reader" and "App Configuration Data Owner" roles on the store

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.0 |

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
| <a name="input_keys"></a> [keys](#input\_keys) | map(object({<br/>      content\_type        = content type of the configuration key<br/>      label               = label (partition) of the app configuration store<br/>      value               = value of the configuration key<br/>      locked              = whether the key is locked to prevent changes<br/>      type                = type of the configuration key, `kv` or `vault` (key vault reference)<br/>      vault\_key\_reference = id of the vault secret this key refers to<br/>      tags                = custom tags to assign<br/>    })) | <pre>map(object({<br/>    content_type        = optional(string)<br/>    label               = optional(string)<br/>    value               = optional(string)<br/>    locked              = optional(bool)<br/>    type                = optional(string)<br/>    vault_key_reference = optional(string)<br/>    tags                = optional(map(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_features"></a> [features](#input\_features) | map(object({<br/>      name        = name of the feature flag<br/>      description = description of the feature<br/>      enabled     = status of the feature, defaults to false<br/>      label       = label (partition) of the app configuration store<br/>      locked      = whether the feature is locked to prevent changes<br/><br/>      targeting\_filter = optional(object({<br/>        default\_rollout\_percentage = default percentage of the user base for which to enable the feature<br/>        groups                     = map of groups and their rollout percentages (groups defined in the application logic)<br/>        users                      = list of users to target (users defined in the application logic)<br/>      }))<br/><br/>      timewindow\_filter = optional(object({<br/>        start = the earliest timestamp the feature is enabled, RFC3339 format<br/>        end   = the latest timestamp the feature is enabled, RFC3339 format<br/>      }))<br/>    })) | <pre>map(object({<br/>    name        = string<br/>    description = optional(string)<br/>    enabled     = optional(bool)<br/>    label       = optional(string)<br/>    locked      = optional(bool)<br/><br/>    targeting_filter = optional(object({<br/>      default_rollout_percentage = number<br/>      groups                     = optional(map(number))<br/>      users                      = optional(list(string))<br/>    }))<br/><br/>    timewindow_filter = optional(object({<br/>      start = optional(string)<br/>      end   = optional(string)<br/>    }))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configuration_store_id"></a> [configuration\_store\_id](#output\_configuration\_store\_id) | n/a |
| <a name="output_app_configuration_keys"></a> [app\_configuration\_keys](#output\_app\_configuration\_keys) | n/a |
| <a name="output_app_configuration_features"></a> [app\_configuration\_features](#output\_app\_configuration\_features) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
