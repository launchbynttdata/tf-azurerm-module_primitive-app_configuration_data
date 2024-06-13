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

variable "configuration_store_id" {
  description = "ID of the App Configuration store"
  type        = string
}

variable "keys" {
  description = <<EOF
    map(object({
      content_type        = content type of the configuration key
      label               = label (partition) of the app configuration store
      value               = value of the configuration key
      locked              = whether the key is locked to prevent changes
      type                = type of the configuration key, `kv` or `vault` (key vault reference)
      vault_key_reference = id of the vault secret this key refers to
      tags                = custom tags to assign
    }))
  EOF
  type = map(object({
    content_type        = optional(string)
    label               = optional(string)
    value               = optional(string)
    locked              = optional(bool)
    type                = optional(string)
    vault_key_reference = optional(string)
    tags                = optional(map(string))
  }))
}

variable "features" {
  description = <<EOF
    map(object({
      name        = name of the feature flag
      description = description of the feature
      enabled     = status of the feature, defaults to false
      label       = label (partition) of the app configuration store
      locked      = whether the feature is locked to prevent changes

      targeting_filter = optional(object({
        default_rollout_percentage = default percentage of the user base for which to enable the feature
        groups                     = map of groups and their rollout percentages (groups defined in the application logic)
        users                      = list of users to target (users defined in the application logic)
      }))

      timewindow_filter = optional(object({
        start = the earliest timestamp the feature is enabled, RFC3339 format
        end   = the latest timestamp the feature is enabled, RFC3339 format
      }))
    }))
  EOF
  type = map(object({
    name        = string
    description = optional(string)
    enabled     = optional(bool)
    label       = optional(string)
    locked      = optional(bool)

    targeting_filter = optional(object({
      default_rollout_percentage = number
      groups                     = optional(map(number))
      users                      = optional(list(string))
    }))

    timewindow_filter = optional(object({
      start = optional(string)
      end   = optional(string)
    }))
  }))
}
