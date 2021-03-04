resource "azurerm_resource_group" "myresourcegroup" {
    name     = "LabMultiCloud2"
    location = var.rg_location

    tags = {
	environment = "Terraform Multi Cloud"
    }
}

##### Azure Network

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "MultiCloudVnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.rg_location 
    resource_group_name = azurerm_resource_group.myresourcegroup.name

    tags = {
        environment = "Terraform Multi Cloud"
    }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    name                   = "MultiCLoudSubnet"
    resource_group_name    = azurerm_resource_group.myresourcegroup.name
    virtual_network_name   = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes       = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "MultiCloudPublicIP"
    location                     = var.rg_location
    resource_group_name      = azurerm_resource_group.myresourcegroup.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Multi Cloud"
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "MultiCloudNetworkSecurityGroup"
    location            = var.rg_location
    resource_group_name = azurerm_resource_group.myresourcegroup.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "AllowHTTP"
        description                = "Allow HTTP"
        priority                   = 1000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
  }

    tags = {
        environment = "Terraform Multi Cloud"
    }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
    name                      = "MultiCloudNIC"
    location                  = var.rg_location
    resource_group_name       = azurerm_resource_group.myresourcegroup.name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.myterraformsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
    }

    tags = {
        environment = "Terraform Multi Cloud"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.myterraformnic.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

##### End Azure Network


##### Máquina Virtual Linux 
resource "azurerm_linux_virtual_machine" "firstvm" {
  name                = "Website"
  location                  = var.rg_location
  resource_group_name       = azurerm_resource_group.myresourcegroup.name
  size                = "Standard_B1s"

  disable_password_authentication = "false"
  admin_username                  = "adminuser"
  admin_password                  = var.azurevm_admin_pass

  network_interface_ids = [
    azurerm_network_interface.myterraformnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = "Terraform Multi Cloud"
  }
}
##### End Máquina Virtual Linux