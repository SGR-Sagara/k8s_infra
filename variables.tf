# 1.1. Create a VPC
variable "vpc_name" {
  type = string
  default = "NEW_VPC"
}
variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "public_source_cidr" {
  type = list(string)
  default = ["10.0.0.0/16"]
}
variable "public_source_cidr_v6" {
  type = list(string)
  default = ["::/0"]
}


# 2. Create a Internet Gateway
variable "ig_name" {
  type = string
  default = "NEW_IG"
}

# 1.3. Create 2 Route tables
variable "public_rt" {
  type = string
  default = "Public_RT"
}
variable "private_rt" {
  type = string
  default = "Private_RT"
}

# 1.4. Create 3 Public Subnets
variable "public_sn_count" {
  type = number
  default = 1
}
variable "public_subnets" {
  type = list(string)
  default = ["10.0.1.0/24"]
}

# 1.5. Create 3 Private Subnets
variable "private_sn_count" {
  type = number
  default = 1
}
variable "private_subnets" {
  type = list(string)
  default = ["10.0.2.0/24"]
}

# 1.6. Create Public access Security Group
variable "public_access_sg_ingress_rules" {
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
  }))
  default = [
    {
      protocol = "tcp"
      from_port = 80
      to_port = 80
    },
    {
      protocol = "tcp"
      from_port = 443
      to_port = 443
    },
    {
      protocol = "tcp"
      from_port = 22
      to_port = 22
    },
    {
      protocol = "-1"
      from_port = 0
      to_port = 0
    }
  ]
}

### EC2 Nodes Parameter
# 1. EC2 AMI
variable "ami_id" {
  type = string
  default = "ami-0e6329e222e662a52"
}
# 2. Number of EC2s
variable "ec2_node_cnt" {
  type = number
  default = 1
}
# 3. SSH Key Name
variable "ssh_key_name" {
  type = string
  default = "Euroleague_Dev"
}

# 4. Instance type
variable "instance_type" {
  type = string
  default = "t2.micro"
}

# 5. Role Name
variable "role_name" {
  type = string
  default = "no_role"
}
## EC2 vpc_security_group_ids
variable "vpc_security_group_ids" {
    type = list(string)
    default = [ "value" ]
}
# 7. Userdata file
variable "user_data_file" {
  type = string
  default = "yum_node_setup.sh"
}
######################### Database Creation related Variables
## DB Identifier
variable "db_identifier" {
    type = string
    default = "new-db"
}
## Alocated storage
variable "db_storage" {
    type = number
    default = 10 
}
## MaX alocate
variable "max_allocated_storage_value" {
    type = number
    default = 100  
}
## DB engine
variable "db_engine" {
    type = string
    default = "postgres"
}

## DB engine version
variable "db_engine_version" {
    type = string
    default = "12.9"
}

## Instance Class
variable "db_class" {
    type = string
    default = "db.t3.micro"
}

## DB name
variable "db_name" {
    type = string
    default = "mydb"
}

## DB username
variable "db_username" {
    type = string
    default = "myuser"
}
## DB Password
variable "db_pass" {
    type = string
    default = "myDbPass"
}
## DB Parameter group
variable "db_para_group_name" {
    type = string
    default = "default.postgres12"
}

## DB storeage type
variable "db_storage_type" {
    type = string
    default = "gp2"
}
## Backup retention period
variable "db_backup_retention_period" {
    type = number
    default = 7
}
## Multi AZ ?
variable "muli_az_enable" {
    type = string
    default = "true"
}
## storage_encrypted ?
variable "is_storage_encrypted" {
    type = string
    default = "true"
}
## Database subnet group name
variable "db_subnet_group_name" {
    type = string
    default = "default_sg"
}
## DB deletion protection
variable "db_delete_protect" {
    type = string
    default = "true"
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
    default = "euroleague-db-proxy" 
}
## Proxy debug_logging
variable "proxy_debug_login" {
    type = string
    default = "false"
}
## Engine Family
variable "db_engin_family" {
    type = string
    default = "POSTGRESQL"
}
## Idel Timeout
variable "db_proxy_idle_timeout" {
    type = number
    default = 1800
}
## proxy tls enable
variable "tls_require" {
    type = string
    default = "false"  
}
## proxy security group
variable "db_proxy_secret_arn" {
    type = string
    default = "arn:aws:secretsmanager:ca-central-1:285308278095:secret:euroleague/db/cred-JWAyzF"
  
}
## Proxy IAM role ARV
variable "db_proxy_role" {
    type = string
    default = "arn:aws:iam::285308278095:role/rds-proxy-role"
}

################### Cognito ############
## Pool Name
variable "pool_name" {
    type = string
    default = "nft_pool" 
}

## Client Name
variable "client_name" {
    type = string
    default = "nft_client" 
}

## Domain Prefix
variable "d_prefix" {
    type = string
    default = "2nskdyn9890fjyou"
}

########### RDS Prody direct module #################
## KMS KEY ID
variable "kms_key_id" {
  type = string
  default = "44e856ea-5258-47a0-80f9-44c4ec486cf4"
}
## Environemnt
variable "env_id" {
  type = string
  default = "Dev"
}
