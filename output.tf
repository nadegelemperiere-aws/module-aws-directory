# -------------------------------------------------------
# Copyright (c) [2021] Technogix.io
# All rights reserved
# -------------------------------------------------------
# Module to deploy an aws directory into a vpc
# -------------------------------------------------------
# Nadège LEMPERIERE, @07 january 2022
# Latest revision: 07 january 2022
# -------------------------------------------------------

output "id" {
    value = aws_directory_service_directory.directory.id
}

output "security_group" {
    value  = aws_directory_service_directory.directory.security_group_id
}

output "dns" {
    value = aws_directory_service_directory.directory.dns_ip_addresses
}
    
output "url" {
    value = aws_directory_service_directory.directory.access_url
}

output "connect" {
    value = aws_directory_service_directory.directory.connect_settings
}