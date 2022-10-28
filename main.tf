## Add the provide section.
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.65.0"  ## was 3.64.2
    }
  }
}

terraform {
  backend "remote" {
    organization = "home_org_sagara"
    hostname = "app.terraform.io"
    workspaces {
      name = "k8s_infra"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


# 1. Call the main network module
module "main_network" {
  source = "./module/main_network"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  public_source_cidr = var.public_source_cidr
  public_source_cidr_v6 = var.public_source_cidr_v6
  ig_name = var.ig_name

  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  public_access_sg_ingress_rules = var.public_access_sg_ingress_rules
  public_rt = var.public_rt
  private_rt = var.private_rt
}



# Create EC2 utility node
module "ec2_instances" {
  source = "./module/ec2_instance"
  vpc_id = module.main_network.vpc_id
  ec2_node_cnt = var.ec2_node_cnt
  instance_type = var.instance_type
  ami_id = var.ami_id
  #iam_instance_profile = var.role_name
  vpc_security_group_ids = [module.main_network.public_security_group]
  user_data = file(var.user_data_file)
  depends_on = [module.main_network] 
}

