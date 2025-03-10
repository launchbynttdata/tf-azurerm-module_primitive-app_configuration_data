# app_configuration_data

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.117 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.2 |
| <a name="module_app_configuration"></a> [app\_configuration](#module\_app\_configuration) | terraform.registry.launch.nttdata.com/module_primitive/app_configuration/azurerm | ~> 1.1 |
| <a name="module_app_configuration_data"></a> [app\_configuration\_data](#module\_app\_configuration\_data) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br/>    name       = string<br/>    max_length = optional(number, 60)<br/>  }))</pre> | <pre>{<br/>  "app_configuration": {<br/>    "max_length": 80,<br/>    "name": "appcs"<br/>  },<br/>  "resource_group": {<br/>    "max_length": 80,<br/>    "name": "rg"<br/>  }<br/>}</pre> | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br/>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br/>    For example, backend, frontend, middleware etc. | `string` | `"appcs"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | target resource group resource mask | `string` | `"eastus"` | no |
| <a name="input_keys"></a> [keys](#input\_keys) | map(object({<br/>      content\_type        = content type of the configuration key<br/>      label               = label (partition) of the app configuration store<br/>      value               = value of the configuration key<br/>      locked              = whether the key is locked to prevent changes<br/>      type                = type of the configuration key, `kv` or `vault` (key vault reference)<br/>      vault\_key\_reference = id of the vault secret this key refers to<br/>      tags                = custom tags to assign<br/>    })) | <pre>map(object({<br/>    content_type        = optional(string)<br/>    label               = optional(string)<br/>    value               = optional(string)<br/>    locked              = optional(bool)<br/>    type                = optional(string)<br/>    vault_key_reference = optional(string)<br/>    tags                = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_features"></a> [features](#input\_features) | map(object({<br/>      name        = name of the feature flag<br/>      description = description of the feature<br/>      enabled     = status of the feature, defaults to false<br/>      label       = label (partition) of the app configuration store<br/>      locked      = whether the feature is locked to prevent changes<br/><br/>      targeting\_filter = optional(object({<br/>        default\_rollout\_percentage = default percentage of the user base for which to enable the feature<br/>        groups                     = map of groups and their rollout percentages (groups defined in the application logic)<br/>        users                      = list of users to target (users defined in the application logic)<br/>      }))<br/><br/>      timewindow\_filter = optional(object({<br/>        start = the earliest timestamp the feature is enabled, RFC3339 format<br/>        end   = the latest timestamp the feature is enabled, RFC3339 format<br/>      }))<br/>    })) | <pre>map(object({<br/>    name        = string<br/>    description = optional(string)<br/>    enabled     = optional(bool)<br/>    label       = optional(string)<br/>    locked      = optional(bool)<br/><br/>    targeting_filter = optional(object({<br/>      default_rollout_percentage = number<br/>      groups                     = optional(map(number))<br/>      users                      = optional(list(string))<br/>    }))<br/><br/>    timewindow_filter = optional(object({<br/>      start = optional(string)<br/>      end   = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the App Configuration store | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
