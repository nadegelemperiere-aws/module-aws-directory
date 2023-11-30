# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Module to deploy an aws directory into a vpc
# -------------------------------------------------------
# Nadège LEMPERIERE, @07 january 2022
# Latest revision: 30 november 2023
# -------------------------------------------------------

# -------------------------------------------------------
# Contact e-mail for this deployment
# -------------------------------------------------------
variable "email" {
	type 	 = string
	nullable = false
}

# -------------------------------------------------------
# Environment for this deployment (prod, preprod, ...)
# -------------------------------------------------------
variable "environment" {
	type 	 = string
	nullable = false
}

# -------------------------------------------------------
# Topic context for this deployment
# -------------------------------------------------------
variable "project" {
	type     = string
	nullable = false
}
variable "module" {
	type 	 = string
	nullable = false
}

# -------------------------------------------------------
# Solution version
# -------------------------------------------------------
variable "git_version" {
	type     = string
	default  = "unmanaged"
	nullable = false
}

# -------------------------------------------------------
# VPC in which the subnet shall be created
# -------------------------------------------------------
variable "vpc" {
	type = object({
		id 		= string
    })
	nullable = false
}

#  -------------------------------------------------------
# Subnet description
# --------------------------------------------------------
variable "subnets" {
	type = list(object({
        id 	= string
    }))
	nullable = false
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
	nullable = false
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
	type 	 = bool
	default  = false
	nullable = false
}

variable "alias" {
	type    = string
	default = null
}