variable "es_key" {
  type = string
}

variable "space_config" {
  type        = map(any)
  description = "Example of space config"
  default = {
    "id"          = "<client_name>",
    "name"        = "CLEINTNAME",
    "description" = "This is a <client> Space",
    "color"       = "#aabbcc",
    "initials"    = "<cl>"
  }
}
