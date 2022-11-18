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
## EC2 vpc_security_group_ids
variable "vpc_security_group_ids" {
    type = list(string)
}
# 7. Userdata file
variable "user_data_file" {
  type = string
}
######################### Database Creation related Variables
## DB Identifier
variable "db_identifier" {
    type = string
}
## Alocated storage
variable "db_storage" {
    type = number
}
## MaX alocate
variable "max_allocated_storage_value" {
    type = number
}
## DB engine
variable "db_engine" {
    type = string
}

## DB engine version
variable "db_engine_version" {
    type = string
}

## Instance Class
variable "db_class" {
    type = string
}

## DB name
variable "db_name" {
    type = string
}

## DB username
variable "db_username" {
    type = string
}
## DB Password
variable "db_pass" {
    type = string
}
## DB Parameter group
variable "db_para_group_name" {
    type = string
}

## DB storeage type
variable "db_storage_type" {
    type = string
}
## Backup retention period
variable "db_backup_retention_period" {
    type = number
}
## Multi AZ ?
variable "muli_az_enable" {
    type = string
}
## storage_encrypted ?
variable "is_storage_encrypted" {
    type = string
}
## Database subnet group name
variable "db_subnet_group_name" {
    type = string
}
## DB deletion protection
variable "db_delete_protect" {
    type = string
}
## DB Security Grpup IDs
/*
variable "vpc_sg_ids" {
    type = list(string) 
}
*/
##################### DB Proxy
## Proxy name
variable "db_proxy_name" {
    type = string
}
## Proxy debug_logging
variable "proxy_debug_login" {
    type = string
}
## Engine Family
variable "db_engin_family" {
    type = string
}
## Idel Timeout
variable "db_proxy_idle_timeout" {
    type = number
}
## proxy tls enable
variable "tls_require" {
    type = string
}
## proxy security group
variable "db_proxy_secret_arn" {
    type = string
  
}
## Proxy IAM role ARV
variable "db_proxy_role" {
    type = string
}

################### Cognito ############
## Pool Name
variable "pool_name" {
    type = string
}

## Client Name
variable "client_name" {
    type = string
}

## Domain Prefix
variable "d_prefix" {
    type = string
}

########### RDS Prody direct module #################
## KMS KEY ID
variable "kms_key_id" {
  type = string
}
## Environemnt
variable "env_id" {
  type = string
}
