# -------------------------------------------------------
# TECHNOGIX 
# -------------------------------------------------------
# Copyright (c) [2021] Technogix.io
# All rights reserved 
# -------------------------------------------------------
# Module to deploy an aws directory into a vpc
# -------------------------------------------------------
# Nadège LEMPERIERE, @07 january 2022
# Latest revision: 07 january 2022
# -------------------------------------------------------

# -------------------------------------------------------
# Contact e-mail for this deployment
# -------------------------------------------------------
variable "email" {
	type 	= string
}

# -------------------------------------------------------
# Environment for this deployment (prod, preprod, ...)
# -------------------------------------------------------
variable "environment" {
	type 	= string
}

# -------------------------------------------------------
# Topic context for this deployment
# -------------------------------------------------------
variable "project" {
	type    = string
}
variable "module" {
	type 	= string
}

# -------------------------------------------------------
# Solution version
# -------------------------------------------------------
variable "git_version" {
	type    = string
	default = "unmanaged"
}

# -------------------------------------------------------
# VPC in which the subnet shall be created
# -------------------------------------------------------
variable "vpc" {
	type = object({
		id 		= string
    })
}

#  -------------------------------------------------------
# Subnet description
# --------------------------------------------------------
variable "subnets" {
	type = list(object({
        id 	= string
    }))
}

# -------------------------------------------------------
# Directory parameters
# -------------------------------------------------------
variable "directory" {
	type = object({
		domain 	= string,
		secret 	= string,
		type 	= string,
		size 	= string
	})
}

# -------------------------------------------------------
# Logging parameters
# -------------------------------------------------------
variable "logging" {
	type = object({
		arn 	= string,
		name	= string
	})
	default = null
}

# -------------------------------------------------------
# SSO settings
# -------------------------------------------------------
variable "enable_sso" {
	type 	= bool
	default = false
}

variable "alias" {
	type = string
	default = null
}