# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Module to deploy an aws directory into a vpc
# -------------------------------------------------------
# Nadège LEMPERIERE, @07 january 2022
# Latest revision: 07 january 2022
# -------------------------------------------------------

# -------------------------------------------------------
# Create an active directory to use for mail service
# -------------------------------------------------------
resource "aws_directory_service_directory" "directory" {
    name        = var.directory.domain
    short_name  = var.project
    password    = var.directory.secret
    size        = var.directory.size
    type        = var.directory.type
    enable_sso  = var.enable_sso
	alias		= var.alias

    vpc_settings {
        vpc_id     = var.vpc.id
        subnet_ids = [for sub in var.subnets : sub.id]
    }

	tags = {
		Name           		= "${var.project}.${var.environment}.${var.module}.directory.${var.directory.domain}.nacl"
		Environment     	= var.environment
		Owner   			= var.email
		Project   			= var.project
		Version 			= var.git_version
		Module  			= var.module
	}
}

# Logging not available with SimpleAD  - Microsoft AD works but is too expensive

# -------------------------------------------------------
# Configure directory logging if possible
# -------------------------------------------------------
resource "aws_cloudwatch_log_resource_policy" "policy" {

	count = (var.directory.type == "SimpleAD") ? 0 : 1

  policy_name     = "${var.project}-${var.environment}-${var.module}-directory-monitoring"
    policy_document = jsonencode({
        Version     = "2012-10-17"
        Statement   = [
    		{
      			Sid 		= "AllowFlowToAssumeRole"
      			Effect 		= "Allow"
      			Principal 	= { Service = "ds.amazonaws.com" }
      			Action 		= ["logs:CreateLogStream","logs:PutLogEvents"]
                Resource 	= "${var.logging.arn}:*"
    		}
  		]
	})
}

resource "aws_directory_service_log_subscription" "directory" {

  count = (var.directory.type == "SimpleAD") ? 0 : 1

	directory_id   = aws_directory_service_directory.directory.id
    log_group_name = var.logging.name
}
