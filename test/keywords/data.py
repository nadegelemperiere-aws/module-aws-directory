# -------------------------------------------------------
# TECHNOGIX
# -------------------------------------------------------
# Copyright (c) [2022] Technogix SARL
# All rights reserved
# -------------------------------------------------------
# Keywords to create data for module test
# -------------------------------------------------------
# Nadège LEMPERIERE, @13 november 2021
# Latest revision: 13 november 2021
# -------------------------------------------------------

# System includes
from json import load, dumps

# Robotframework includes
from robot.libraries.BuiltIn import BuiltIn, _Misc
from robot.api import logger as logger
from robot.api.deco import keyword
ROBOT = False

# ip address manipulation
from ipaddress import IPv4Network

@keyword('Load Small AD Test Data')
def load_small_ad_test_data(vpc, subnets, directory) :

    result = {}
    result['directory'] = []
    result['directory'].append({})

    result['directory'][0]['name'] = 'standard'
    result['directory'][0]['data'] = {}
    result['directory'][0]['data']['DirectoryId'] = directory['id']
    result['directory'][0]['data']['Name'] = 'test.com'
    result['directory'][0]['data']['Alias'] = directory['alias']
    result['directory'][0]['data']['ShortName'] = 'test'
    result['directory'][0]['data']['Size'] = 'Small'
    result['directory'][0]['data']['AccessUrl'] = directory['url']
    result['directory'][0]['data']['DnsIpAddrs'] = directory['dns']
    result['directory'][0]['data']['Stage'] = 'Active'
    result['directory'][0]['data']['Type'] = 'SimpleAD'
    result['directory'][0]['data']['VpcSettings'] = {}
    result['directory'][0]['data']['VpcSettings']['VpcId'] = vpc['id']
    result['directory'][0]['data']['VpcSettings']['SubnetIds'] = [ subnets['test1']['id'],  subnets['test2']['id'] ]
    result['directory'][0]['data']['VpcSettings']['SecurityGroupId'] = directory['security_group']
    result['directory'][0]['data']['VpcSettings']['AvailabilityZones'] = ['eu-west-1a', 'eu-west-1b']
    result['directory'][0]['data']['SsoEnabled'] = True

    logger.debug(dumps(result))

    return result
