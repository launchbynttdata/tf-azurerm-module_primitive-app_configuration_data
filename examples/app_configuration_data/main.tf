// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "resource_names" {
  source = "git::https://github.com/launchbynttdata/tf-launch-module_library-resource_name.git?ref=1.0.1"

  for_each = var.resource_names_map

  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
  region                  = var.location
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  maximum_length          = each.value.max_length
}

module "resource_group" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-resource_group.git?ref=1.0.0"

  name     = module.resource_names["resource_group"].minimal_random_suffix
  location = var.location

  tags = merge(var.tags, { resource_name = module.resource_names["resource_group"].standard })
}

module "app_configuration" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-app_configuration.git?ref=feature!/initial-implementation"

  name                = module.resource_names["app_configuration"].minimal_random_suffix
  resource_group_name = module.resource_group.name
  location            = var.location

  tags = merge(var.tags, { resource_name = module.resource_names["app_configuration"].standard })

  depends_on = [module.resource_group]
}

module "app_configuration_data" {
  source = "../../"

  configuration_store_id = module.app_configuration.app_configuration_id

  keys     = var.keys
  features = var.features
}
