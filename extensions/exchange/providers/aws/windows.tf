"srv01" = {
  name               = "srv01"
  domain             = "pretera.local"
  windows_sku        = "2019-Datacenter"
  ami                = "ami-03440f0d88fea1060"
  instance_type      = "t2.xlarge"   # t2.xlarge = 4cpu / 16GB
  private_ip_address = "{{ip_range}}.21"
  password           = "FP.xh5Fk9Z1c"
}
