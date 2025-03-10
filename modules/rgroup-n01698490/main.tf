resource "azurerm_resource_group" "rg_name" {
<<<<<<< HEAD
  name = "${var.humber_id}-RG"
  location = var.location
}
=======
  name     = "${var.humber_id}RG"  
  location = var.location
  tags     = var.tags
}

>>>>>>> a3b7f22c179740bb3355f0819181fdcdf16fdae3
