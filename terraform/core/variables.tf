variable "location" {
  description = "Location of resources"
  type        = string
  default = "West Europe"
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "gallery_name" {
  description = "Name of the shared image gallery"
  type        = string
  default = "CustomImageGallery"
}