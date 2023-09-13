variable "example_number" {
  description = ""
  type        = number
  default     = 42
}

variable "example_list1" {
  description = ""
  type        = list(string)
  default     = ["x", "y", "z"]
}

variable "example_list2" {
  description = ""
  type        = list(number)
  default     = [1, 4, 9]
}

variable "example_map" {
  description = ""
  type        = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
  }
}

variable "server_port" {
  description = "The port number the server will use to serve HTTP requests."
  type        = number
  default     = 8080
}
