## Generate EC2 nodes


## Get Public  SubnetList
data "aws_subnet_ids" "public_subnets" {
  vpc_id = var.vpc_id
  tags = {
    Access = "PUBLIC"
  }
}

## Get Public  Security Group
data "aws_security_group" "public_sg" {
  vpc_id = var.vpc_id
  tags = {
    Name = "PUBLIC_SG"
  }
}

## Pick single subnet
locals {
  ## Subnet
  subnet_ids_list = tolist(data.aws_subnet_ids.public_subnets.ids) 
  instance_subnet_id = local.subnet_ids_list[0]
  ## Security Group
  #security_groups = tolist(var.vpc_security_group_ids)
  #instance_sec_grp_id = local.security_groups[0]
}

# 1. Create EC2s
resource "aws_instance" "euroleague_utility_node" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = local.instance_subnet_id
  #subnet_id = (tolist(data.aws_subnet_ids.public_subnets.ids))[0]
  vpc_security_group_ids = var.vpc_security_group_ids
  #security_groups = [local.instance_sec_grp_id]
  key_name = "NewKey"
  user_data = var.user_data_file
  #iam_instance_profile = var.role_name
  tags = {
    Name = "K8S_MasterNode"
  }
}
