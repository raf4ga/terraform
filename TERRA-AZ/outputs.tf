output "vmip" {
  description = "Azure VM Public IP"
  value       = azurerm_windows_virtual_machine.terravmaz.public_ip_address
}