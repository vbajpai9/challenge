locals {
  if_threat_detection_policy_enabled = var.enable_threat_detection_policy ? [{}] : []
  #if_extended_auditing_policy_enabled = var.enable_extended_auditing_policy ? [{}] : []
}


resource "azurerm_mssql_server" "sqlserver" {
  name                = var.server_name
  resource_group_name = var.rg_name
  location            = var.location
  version             = var.sql_version

  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  public_network_access_enabled = false
  tags = merge(var.default_tags, { "Env" = var.env })
}

resource "azurerm_sql_database" "sql_database" {
  name                = var.database_name
  resource_group_name = var.rg_name
  location            = var.location

  server_name                      = azurerm_mssql_server.sqlserver.name
  //requested_service_objective_name = var.requested_service_objective_name
  collation                        = var.database_collation
  edition                          = var.database_edition

  tags = merge({"MRP" = var.mrp}, { "Env" = var.env })

  dynamic "threat_detection_policy" {
    for_each = local.if_threat_detection_policy_enabled
    content {
      state                      = "Disabled"
      storage_endpoint           = var.primary_blob_endpoint
      storage_account_access_key = var.primary_access_key
      retention_days             = var.retention_days
      email_addresses            = var.email_addresses
    }
  }
}
/*
resource "azurerm_mssql_elasticpool" "sql_mssql_elasticpool" {
  name                = var.elasticpool_name
  resource_group_name = var.rg_name
  location            = var.location
  server_name         = azurerm_sql_server.sqlserver.name
  max_size_gb         = var.max_size_gb

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    family   = var.sku_family
    capacity = var.sku_capacity
  }

  per_database_settings {
    min_capacity = var.db_min_capacity
    max_capacity = var.db_max_capacity
  }

  tags = merge(var.default_tags, { "Env" = var.env })
}
*/
