# terraform.tfvars
name_prefix                 = "development-server"
instance_type               = "t3.micro"
subnet_id                   = "subnet-xxxxxxxxxxxxxxxxx"
vpc_security_group_ids      = ["sg-yyyyyyyyyyyyyyyyy"]
key_name                    = "your-key-pair-name"
associate_public_ip_address = true
user_data                   = ""

tags = {
  Environment = "develop"
  Owner       = "github-terraform-module"
  CostCenter  = "Dev"
}
