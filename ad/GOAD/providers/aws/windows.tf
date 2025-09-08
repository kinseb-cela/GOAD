# t2.medium = 2cpu / 4GB
# t2.large  = 2cpu / 8GB
# t2.xlarge = 4cpu / 16GB
"dc01" = {
  name               = "dc01"
  domain             = "pretera.local"
  windows_sku        = "2019-Datacenter"
  ami                = "ami-03440f0d88fea1060"
  instance_type      = "t2.medium"
  private_ip_address = "{{ip_range}}.10"
  password           = "8dCT-DJjgScp"
}
"dc02" = {
  name               = "dc02"
  domain             = "financa.pretera.local"
  windows_sku        = "2019-Datacenter"
  ami                = "ami-03440f0d88fea1060"
  instance_type      = "t2.medium"
  private_ip_address = "{{ip_range}}.11"
  password           = "NgtI75cKV+Pu"
}
"dc03" = {
  name               = "dc03"
  domain             = "siguria.local"
  windows_sku        = "2016-Datacenter"
  ami                = "ami-053492b4735046f1c"
  instance_type      = "t2.medium"
  private_ip_address = "{{ip_range}}.12"
  password           = "Ufe-bVXSx9rk"
}
"srv02" = {
  name               = "srv02"
  domain             = "financa.pretera.local"
  windows_sku        = "2019-Datacenter"
  ami                = "ami-03440f0d88fea1060"
  instance_type      = "t2.medium"
  private_ip_address = "{{ip_range}}.22"
  password           = "NgtI75cKV+Pu"
}
"srv03" = {
  name               = "srv03"
  domain             = "siguria.local"
  windows_sku        = "2016-Datacenter"
  ami                = "ami-053492b4735046f1c"
  instance_type      = "t2.medium"
  private_ip_address = "{{ip_range}}.23"
  password           = "978i2pF43UJ-"
}