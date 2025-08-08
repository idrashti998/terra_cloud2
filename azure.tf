terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.38.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}


resource "azurerm_resource_group" "terra_example" {
  name     = "azure_resourcesg"
  location = "West Europe"
}

resource "azurerm_public_ip" "terra_pubip" {
  name                = "my_pip"
  resource_group_name = azurerm_resource_group.terra_example.name
  location            = azurerm_resource_group.terra_example.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }

  provisioner "local-exec" {
    command = "echo ${self.ip_address} > public_ips.txt"
  }
}
