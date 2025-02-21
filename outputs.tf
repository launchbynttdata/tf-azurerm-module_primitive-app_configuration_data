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

output "configuration_store_id" {
  value = var.configuration_store_id
}

output "app_configuration_keys" {
  value = [for key, object in azurerm_app_configuration_key.key : {
    key                 = key
    label               = object.label
    value               = object.value
    type                = object.type
    vault_key_reference = object.vault_key_reference
    content_type        = object.content_type
  }]
}

output "app_configuration_features" {
  value = [for key, object in azurerm_app_configuration_feature.feature : {
    key     = key
    name    = object.name
    label   = object.label
    enabled = object.enabled
  }]
}
