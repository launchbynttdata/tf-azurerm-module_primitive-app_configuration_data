resource_names_map = {
  resource_group = {
    name       = "rg"
    max_length = 80
  }
  app_configuration = {
    name       = "appcs"
    max_length = 80
  }
}
instance_env            = 0
instance_resource       = 0
logical_product_family  = "launch"
logical_product_service = "appcs"
class_env               = "gotest"
location                = "eastus"

keys = {
  test-config-key = {
    value = "Hello, World!"
  }
  test-json-config-key = {
    value        = "{\"message\": \"Hello, World!\"}"
    content_type = "application/json"
  }
  test-vault-config-key = {
    type                = "vault"
    vault_key_reference = "https://testvault.vault.azure.net/secrets/testsecret"
  }
}

features = {
  test-feature-flag = {
    name    = "test-feature-flag"
    enabled = true
  }
  test-feature-flag-with-targeting = {
    name = "test-feature-flag-with-targeting"
    targeting_filter = {
      default_rollout_percentage = 50
      groups = {
        group1 = 50
        group2 = 50
      }
      users = ["user1", "user2"]
    }
  }
  test-feature-flag-with-timewindow = {
    name = "test-feature-flag-with-timewindow"
    timewindow_filter = {
      start = "2024-06-13T09:27:48-04:00"
      end   = "2038-06-13T09:27:48-04:00"
    }
  }
}
