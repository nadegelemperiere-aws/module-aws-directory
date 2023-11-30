# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Simple deployment for directory testing
# -------------------------------------------------------
# Nadège LEMPERIERE, @12 november 2021
# Latest revision: 12 november 2021
# -------------------------------------------------------

# -------------------------------------------------------
# Create a network
# -------------------------------------------------------
resource "aws_vpc" "test" {
	cidr_block  = "10.2.0.0/24"
   	tags 		= { Name = "test.vpc" }
}

# -------------------------------------------------------
# Create the subnets
# -------------------------------------------------------
resource "aws_subnet" "test1" {
	vpc_id 				= aws_vpc.test.id
	availability_zone	= "eu-west-1a"
	cidr_block  		= "10.2.0.0/26"
   	tags 				= { Name = "test.vpc.subnet1" }
}

# -------------------------------------------------------
# Create the subnets
# -------------------------------------------------------
resource "aws_subnet" "test2" {
	vpc_id 				= aws_vpc.test.id
	availability_zone	= "eu-west-1b"
	cidr_block  		= "10.2.0.64/26"
   	tags 				= { Name = "test.vpc.subnet2" }
}

# -------------------------------------------------------
# Create the s3 bucket
# -------------------------------------------------------
resource "random_string" "random" {
	length		= 32
	special		= false
	upper 		= false
}
# -------------------------------------------------------
# Create subnets using the current module
# -------------------------------------------------------
module "directory" {

	source 		= "../../../"
	email 		= "moi.moi@moi.fr"
	project 	= "test"
	environment = "test"
	module 		= "test"
	git_version = "test"
	enable_sso	= true
	alias 		= random_string.random.result
	vpc 		= {
		id 		= aws_vpc.test.id
	}
	subnets 	= [
		{ id = aws_subnet.test1.id } ,
		{ id = aws_subnet.test2.id }
	]
	directory = {
		domain 	= "test.com",
		secret 	= "Test123456",
		size 	= "Small",
		type 	= "SimpleAD"
	}
}

# -------------------------------------------------------
# Terraform configuration
# -------------------------------------------------------
provider "aws" {
	region		= var.region
	access_key 	= var.access_key
	secret_key	= var.secret_key
}

terraform {
	required_version = ">=1.0.8"
	backend "local"	{
		path="terraform.tfstate"
	}
}

# -------------------------------------------------------
# Region for this deployment
# -------------------------------------------------------
variable "region" {
	type    = string
}

# -------------------------------------------------------
# AWS credentials
# -------------------------------------------------------
variable "access_key" {
	type    	= string
	sensitive 	= true
}
variable "secret_key" {
	type    	= string
	sensitive 	= true
}

# -------------------------------------------------------
# Test outputs
# -------------------------------------------------------
output "vpc" {
	value = {
		id 		= aws_vpc.test.id
	}
}

output "subnets" {
    value = {
		test1 = {
			id = aws_subnet.test1.id
       	 	arn = aws_subnet.test1.arn
        	cidr = aws_subnet.test1.cidr_block
        	account = aws_subnet.test1.owner_id
    	}
		test2 = {
			id = aws_subnet.test2.id
       	 	arn = aws_subnet.test2.arn
        	cidr = aws_subnet.test2.cidr_block
        	account = aws_subnet.test2.owner_id
    	}
	}
}
output "directory" {
	value = {
    	id 				= module.directory.id
    	security_group 	= module.directory.security_group
    	dns 			= module.directory.dns
    	url 			= module.directory.url
    	connect 		= module.directory.connect
		alias			= random_string.random.result
  	}
}