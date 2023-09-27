data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                       = var.key_vault
  location                   = azurerm_resource_group.rg1.location
  resource_group_name        = azurerm_resource_group.rg1.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7
  tags                       = var.tgs  
  purge_protection_enabled    = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = ["Get","List","Update","Create","Import","Delete", "Recover","Backup","Restore"]

    secret_permissions = ["Get","List","Set","Delete","Recover","Backup","Restore"]
  }
}

#Create KeyVault VM password
resource "random_password" "vmpassword" {
  length = 10
  special = true
  lower   = true
  numeric = true
  upper   = true
}

#Create Key Vault Secret
resource "azurerm_key_vault_secret" "vmpassword" {
  name         = var.vmpassword
  value        = random_password.vmpassword.result
  key_vault_id = azurerm_key_vault.key_vault.id
}