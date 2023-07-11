variable "es_key" {
  type = string
}

variable "space_config" {
  type        = map(any)
  description = "Example of space configuration variable"
  default = {
    "id"          = "numerixde",
    "name"        = "NumerixDE",
    "description" = "This is Numerix DE test space",
    "color"       = "#aabbcc",
    "initials"    = "ND"
  }
}
