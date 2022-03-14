# -------------------------------------------------------
# TECHNOGIX
# -------------------------------------------------------
# Copyright (c) [2021] Technogix.io
# All rights reserved
# -------------------------------------------------------
# Robotframework test suite for module
# -------------------------------------------------------
# Nadège LEMPERIERE, @12 november 2021
# Latest revision: 12 november 2021
# -------------------------------------------------------


*** Settings ***
Documentation   A test case to check directory creation using module
Library         technogix_iac_keywords.terraform
Library         technogix_iac_keywords.keepass
Library         technogix_iac_keywords.directory
Library         ../keywords/data.py

*** Variables ***
${KEEPASS_DATABASE}                 ${vault_database}
${KEEPASS_KEY}                      ${vault_key}
${KEEPASS_GOD_KEY_ENTRY}            /engineering-environment/aws/aws-god-access-key
${REGION}                           eu-west-1

*** Test Cases ***
Prepare environment
    [Documentation]         Retrieve god credential from database and initialize python tests keywords
    ${god_access}           Load Keepass Database Secret            ${KEEPASS_DATABASE}     ${KEEPASS_KEY}  ${KEEPASS_GOD_KEY_ENTRY}            username
    ${god_secret}           Load Keepass Database Secret            ${KEEPASS_DATABASE}     ${KEEPASS_KEY}  ${KEEPASS_GOD_KEY_ENTRY}            password
    Initialize Terraform    ${REGION}   ${god_access}   ${god_secret}
    Initialize Directory    None        ${god_access}   ${god_secret}    ${REGION}

Create SmallAD Directory
    [Documentation]         Create Small AD Directory And Check That The AWS Infrastructure Match Specifications
    Launch Terraform Deployment                 ${CURDIR}/../data/small-ad
    ${states}   Load Terraform States           ${CURDIR}/../data/small-ad
    ${specs}    Load Small AD Test Data         ${states['test']['outputs']['vpc']['value']}  ${states['test']['outputs']['subnets']['value']}  ${states['test']['outputs']['directory']['value']}
    Directory Shall Exist And Match             ${specs['directory']}
    [Teardown]  Destroy Terraform Deployment    ${CURDIR}/../data/small-ad
