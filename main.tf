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

resource "azurerm_app_configuration_key" "key" {
  for_each = var.keys

  configuration_store_id = var.configuration_store_id

  key                 = each.key
  content_type        = each.value.content_type
  label               = each.value.label
  value               = each.value.value
  locked              = each.value.locked
  type                = each.value.type
  vault_key_reference = each.value.vault_key_reference

  tags = each.value.tags
}

resource "azurerm_app_configuration_feature" "feature" {
  for_each = var.features

  configuration_store_id = var.configuration_store_id

  key         = each.key
  name        = each.value.name
  description = each.value.description
  label       = each.value.label
  enabled     = each.value.enabled
  locked      = each.value.locked

  dynamic "targeting_filter" {
    for_each = each.value.targeting_filter != null ? [each.value.targeting_filter] : []
    content {
      default_rollout_percentage = targeting_filter.value.default_rollout_percentage
      users                      = targeting_filter.value.users

      dynamic "groups" {
        for_each = targeting_filter.value.groups != null ? targeting_filter.value.groups : {}
        content {
          name               = groups.key
          rollout_percentage = groups.value
        }
      }
    }
  }

  dynamic "timewindow_filter" {
    for_each = each.value.timewindow_filter != null ? [each.value.timewindow_filter] : []
    content {
      start = timewindow_filter.value.start
      end   = timewindow_filter.value.end
    }
  }

  lifecycle {
    ignore_changes = [enabled, targeting_filter, timewindow_filter]
  }
}
