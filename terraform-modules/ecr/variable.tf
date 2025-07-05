variable "microservices" {
  type = map(string)
  default = {
    user    = "user-service"
    billing = "billing-service"
    orders  = "order-service"
    license = "license-service"
  }
}
