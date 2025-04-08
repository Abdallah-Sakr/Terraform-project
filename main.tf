module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"

  vpc = "vpc"
}


module "subnets" {
  source               = "./modules/subnet"
  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
  name                 = "subnet"
}



module "internet_gateway" {
  source            = "./modules/internet_gateway"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
  name              = "internet_gateway"
}

module "nat_gateway" {
  source             = "./modules/nat_gateway"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
  name               = "nat-gateway"
}

module "security_groups" {
  source              = "./modules/security_group"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidrs = module.subnets.public_subnet_cidrs
  name                = "security-groups"
}
module "web_server" {
  source            = "./modules/instance"
  ami_id            = "ami-00a929b66ed6e0de6"
  instance_type     = "t2.micro"
  key_name          = "sakr"
  subnet_ids        = module.subnets.public_subnet_ids
  security_group_id = module.security_groups.public_security_group_id
  ssh_user          = "ec2-user"
  private_key_path  = "~/.ssh/sakr.pem"
  name              = "public-web-server"
}

#-----------------------------------
module "web_server1" {
  source            = "./modules/instance1"
  ami_id            = "ami-00a929b66ed6e0de6"
  instance_type     = "t2.micro"
  key_name          = "sakr"
  subnet_ids        = module.subnets.private_subnet_ids
  security_group_id = module.security_groups.private_security_group_id
  ssh_user          = "ec2-user"
  private_key_path  = "~/.ssh/sakr.pem"
  name              = "private-web-server1"
}
#-------------------------------------
module "s3_bucket" {
  source    = "./modules/s3"
  bucket_s3 = "sbucketsakr"

}
module "application_load_balancer" {
  source                    = "./modules/app_loadblancer"
  name                      = "my-alb"
  vpc_id                    = module.vpc.vpc_id
  public_subnet_ids         = module.subnets.public_subnet_ids
  private_subnet_ids        = module.subnets.private_subnet_ids
  public_security_group_id  = module.security_groups.public_security_group_id
  private_security_group_id = module.security_groups.private_security_group_id
}
# must terraform apply for s3 before create backend
# must terraform init -migrate-state  
# create dynamodb in aws by name = Sohag-ITI and prtitition key = LockID  and type = string
terraform {
 backend "s3" {
  bucket         = "sbucketsakr"
 key            = "terraform/state"
region         = "us-east-1"
encrypt        = true
 dynamodb_table = "Sohag-ITI"
 }
}


