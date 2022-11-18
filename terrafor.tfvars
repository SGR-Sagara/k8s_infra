# 1. Create a VPC
vpc_name = "K8S_VPC"
vpc_cidr = "10.0.0.0/16"
public_source_cidr = ["0.0.0.0/0"]
public_source_cidr_v6 = ["::/0"]
#azs = ["ap-south-1a","ap-south-1b","ap-south-1c"]

# 2. Create a Internet Gateway
ig_name = "K8S_IG"

# 1.3. Create 2 Route tables
public_rt = "PUBLIC_RT"
private_rt = "PRIVATE_RT"

# 1.4. Create 3 Public Subnets
public_subnets = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
# 1.5. Create 3 Private Subnets
private_subnets = ["10.0.5.0/24","10.0.6.0/24","10.0.7.0/24"]

# 1.6. Create Public access Security Group
public_access_sg_ingress_rules = [
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

### ----------- EC2 nodes
ami_id = "ami-0e6329e222e662a52"
ec2_node_cnt = 2
ssh_key_name = "Project_DevTest"
instance_type = "t2.micro"
role_name = "EC2_Role"
user_data_file = << EOF
#!/bin/bash
# Install Docker
sudo yum update
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user

#Make docker auto-start
sudo chkconfig docker on

#Because you always need it....
sudo yum install -y git

#Install Python 3.8
sudo yum install -y amazon-linux-extras
sudo amazon-linux-extras enable python3.8
sudo yum install python3.8 -y
sudo alias python=python3

# Install pip3
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user

#Reboot to verify it all loads fine on its own.
sudo reboot

#docker-compose install
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Configure Git
git config --global user.name "amsagara"
git config --global user.email amsagara@gmail.com

## Install 
EOF
### ------------- Database related Variables
db_identifier = "eurolegue-db"
db_backup_retention_period = 7
db_class = "db.m6g.large"
db_delete_protect = "false"
db_engine = "postgres"
db_engine_version = "12.9"
db_name = "Project_db"
db_para_group_name = "default.postgres12"
db_pass = "Test-NotHere"
db_storage = 100
db_storage_type = "gp2"
db_username = "Project"
is_storage_encrypted = "true"
max_allocated_storage_value = 500
muli_az_enable = "true"
## Proxy name
db_proxy_name = "Project-db-proxy" 
## Proxy debug_logging
proxy_debug_login = "true"
## Engine Family
db_engin_family = "POSTGRESQL"
## Idel Timeout
db_proxy_idle_timeout = 1800
## proxy tls enable
tls_require = "false"  
## proxy security group
db_proxy_secret_arn = "arn:aws:secretsmanager:ca-central-1:123456789:secret:Project/db/cred-JWAyzF"
## Proxy IAM role ARV
db_proxy_role = "arn:aws:iam::285308278095:role/rds-proxy-role"

################### Cognito ############
pool_name = "Project"
client_name = "Project_client"
d_prefix = "Project_123456789"
################# DB Proxy with Proxy module ###############
kms_key_id = "44e856ea-5258-47a0-80f9-44c4ec486cf4"
env_id = "Dev"