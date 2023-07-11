## Generate EC2 nodes


## Get Public  SubnetList
data "aws_subnets" "public_subnets" {
  tags = {
    Access = "PUBLIC"
  }
}

## Get Public  Security Group
data "aws_security_groups" "public_sg" {
    tags = {
    Name = "PUBLIC_SG"
  }
}

## Pick single subnet
locals {
  ## Subnet
  #subnet_ids_list = tolist(data.aws_subnet_ids.public_subnets.ids) 
  #instance_subnet_id = local.subnet_ids_list[0]
  worker_names = ["Worker_1", "Worker_2"]
  ## Security Group
  #security_groups = tolist(var.vpc_security_group_ids)
  #instance_sec_grp_id = local.security_groups[0]
}

## EC2 Role
# Create IAM Role
resource "aws_iam_role" "k8s_ec2_role" {
  name = "k8s_ec2_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

## Creating policy for k8s_ec2_role
resource "aws_iam_role_policy" "k8s_ec2_role_policy" {
  name = aws_iam_role.k8s_ec2_role.name
  role = aws_iam_role.k8s_ec2_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
})
}

## Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.k8s_ec2_role.name
}

# 1. Create EC2 MAster
resource "aws_instance" "k8s_master_node" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = "${data.aws_subnets.public_subnets.ids[0]}"
  #subnet_id = (tolist(data.aws_subnet_ids.public_subnets.ids))[0]
  vpc_security_group_ids = ["${data.aws_security_groups.public_sg.ids[0]}"]
  #security_groups = [local.instance_sec_grp_id]
  key_name = var.ssh_key_name
  user_data = "${file(var.user_data_file)}" 
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  #iam_instance_profile = var.role_name
  tags = {
    Name = "K8S_Master_Node"
  }
}

# 2. Create EC2 Worker
resource "aws_instance" "k8s_worker_node" {
  count = length(local.worker_names)
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = "${data.aws_subnets.public_subnets.ids[0]}"
    #subnet_id = (tolist(data.aws_subnet_ids.public_subnets.ids))[0]
    vpc_security_group_ids = ["${data.aws_security_groups.public_sg.ids[0]}"]
    #security_groups = [local.instance_sec_grp_id]
    key_name = var.ssh_key_name
    user_data = "${file(var.user_data_file)}" 
    associate_public_ip_address = true
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    #iam_instance_profile = var.role_name
    tags = {
      Name = "K8S_Worker_Node_${count.index}"
    }
}

