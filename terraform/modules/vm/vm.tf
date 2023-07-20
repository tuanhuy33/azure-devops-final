resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}-ni"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCo+5nV268KfMcwq4wxrvz78uQsNolLeWeUZB2zWVpUDL4KMJFzoyfQVnOrNhGSUgfw456po2S1KqUg8LEG+598/C9gbTf/s/UxSCEqwcaPg27CqYxp51euGOwoEYNnH2OACGWkuYU4HJianXXnXy4JIIJiutNYczHzgrR8BKRqYTUeA287x6OeCZSfSMNwD5V6a0T7gPi3L+yvLrp2dAseBZd3qxF7CT5klqIffXt9prRLQnv3btrzI04FNH8DUPEaBVH95qSo7CRMRGwM/VNjFMsVhFhDQgQuq3hAR0eH5jQSFl3sU2Ziot6ZzyNJ2n7shBxDq7wumDdGgFa6cuerOZXA0qB/dDQmrKPjutb6I9NUdvtGXy4KapQEBGyV7+zDIkxHbqPAvYnsY2/PPUXhXyOVmVTnHeMsKFmoAaDF3CBdNQIVZOr9lO0DmrVP0pzAryF+zWLCwLvJi51Wfp/ML2wglWlrhZSwJVLPgdpRYOZ/TXnXbrNzteitiZK1h9s= devopsagent@huylinuxVM"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
