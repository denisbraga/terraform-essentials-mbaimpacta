resource "azurerm_resource_group" "firstresourcegroup" {
    name     = "LabMultiCloud"
    location = var.rg_location

    tags = {
	environment = "Terraform Multi Cloud"
    }
}
