# 1.1. Create a VPC
variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "public_source_cidr" {
  type = list(string)
}
variable "public_source_cidr_v6" {
  type = list(string)
}


# 2. Create a Internet Gateway
variable "ig_name" {
  type = string
}

# 1.3. Create 2 Route tables
variable "public_rt" {
  type = string
}
variable "private_rt" {
  type = string
}

# 1.4. Create 3 Public Subnets
variable "public_sn_count" {
  type = number
}
variable "public_subnets" {
  type = list(string)
}

# 1.5. Create 3 Private Subnets
variable "private_sn_count" {
  type = number
}
variable "private_subnets" {
  type = list(string)
}

# 1.6. Create Public access Security Group
variable "public_access_sg_ingress_rules" {
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
  }))
  default = [

  ]
}

### EC2 Nodes Parameter
# 1. EC2 AMI
variable "ami_id" {
  type = string
}
# 2. Number of EC2s
variable "ec2_node_cnt" {
  type = number
}
# 3. SSH Key Name
variable "ssh_key_name" {
  type = string
}

# 4. Instance type
variable "instance_type" {
  type = string
}

# 5. Role Name
variable "role_name" {
  type = string
}
# 7. Userdata file
variable "user_data_file" {
  type = string
}
######################### Database Creation related Variables