resource "azurerm_recovery_services_vault" "rsv1" {
  name                = var.rsv1
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  sku                 = "Standard"
  tags                = var.tgs
}

resource "azurerm_site_recovery_fabric" "primary" {
  name                = var.primary
  resource_group_name = azurerm_resource_group.rg2.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv1.name
  location            = azurerm_resource_group.rg1.location
}

resource "azurerm_site_recovery_fabric" "secondary" {
  name                = var.secondary
  resource_group_name = azurerm_resource_group.rg2.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv1.name
  location            = azurerm_resource_group.rg2.location
}

resource "azurerm_site_recovery_protection_container" "asrpc_prim" {
  name                 = var.asrpc_prim
  resource_group_name  = azurerm_resource_group.rg2.name
  recovery_vault_name  = azurerm_recovery_services_vault.rsv1.name
  recovery_fabric_name = azurerm_site_recovery_fabric.primary.name
}

resource "azurerm_site_recovery_protection_container" "asrpc_secon" {
  name                 = var.asrpc_secon
  resource_group_name  = azurerm_resource_group.rg2.name
  recovery_vault_name  = azurerm_recovery_services_vault.rsv1.name
  recovery_fabric_name = azurerm_site_recovery_fabric.secondary.name
}

resource "azurerm_site_recovery_replication_policy" "asrp_pol" {
  name                                                 = var.asrp_pol
  resource_group_name                                  = azurerm_resource_group.rg2.name
  recovery_vault_name                                  = azurerm_recovery_services_vault.rsv1.name
  recovery_point_retention_in_minutes                  = 24 * 60
  application_consistent_snapshot_frequency_in_minutes = 4 * 60
}

resource "azurerm_site_recovery_protection_container_mapping" "asrpcm" {
  name                                      = var.asrpcm
  resource_group_name                       = azurerm_resource_group.rg2.name
  recovery_vault_name                       = azurerm_recovery_services_vault.rsv1.name
  recovery_fabric_name                      = azurerm_site_recovery_fabric.primary.name
  recovery_source_protection_container_name = azurerm_site_recovery_protection_container.asrpc_prim.name
  recovery_target_protection_container_id   = azurerm_site_recovery_protection_container.asrpc_secon.id
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.asrp_pol.id
}

resource "azurerm_site_recovery_network_mapping" "asrnm" {
  name                        = var.asrnm
  resource_group_name         = azurerm_resource_group.rg2.name
  recovery_vault_name         = azurerm_recovery_services_vault.rsv1.name
  source_recovery_fabric_name = azurerm_site_recovery_fabric.primary.name
  target_recovery_fabric_name = azurerm_site_recovery_fabric.secondary.name
  source_network_id           = azurerm_virtual_network.vnet1.id
  target_network_id           = azurerm_virtual_network.vnet2.id
}

resource "azurerm_storage_account" "stacacheasr" {
  name                     = var.stacacheasr
  location                 = azurerm_resource_group.rg1.location
  resource_group_name      = azurerm_resource_group.rg1.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_site_recovery_replicated_vm" "asreplvm" {
  name                                      = var.asreplvm
  resource_group_name                       = azurerm_resource_group.rg2.name
  recovery_vault_name                       = azurerm_recovery_services_vault.rsv1.name
  source_recovery_fabric_name               = azurerm_site_recovery_fabric.primary.name
  source_vm_id                              = azurerm_virtual_machine.vmwin.id
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.asrp_pol.id
  source_recovery_protection_container_name = azurerm_site_recovery_protection_container.asrpc_prim.name

  target_resource_group_id                = azurerm_resource_group.rg2.id
  target_recovery_fabric_id               = azurerm_site_recovery_fabric.secondary.id
  target_recovery_protection_container_id = azurerm_site_recovery_protection_container.asrpc_secon.id

  managed_disk {
    disk_id                    = azurerm_virtual_machine.vmwin.storage_os_disk[0].managed_disk_id
    staging_storage_account_id = azurerm_storage_account.stacacheasr.id
    target_resource_group_id   = azurerm_resource_group.rg2.id
    target_disk_type           = "Premium_LRS"
    target_replica_disk_type   = "Premium_LRS"
  }

  network_interface {
    source_network_interface_id   = azurerm_network_interface.nic_win1.id
    target_subnet_name            = azurerm_subnet.snet03B.name
    recovery_public_ip_address_id = azurerm_public_ip.pipvm.id
  }

  depends_on = [
    azurerm_site_recovery_protection_container_mapping.asrpcm,
    azurerm_site_recovery_network_mapping.asrnm,
  ]
}