import sys
import requests
import os
import subprocess
import json

# Copyright (c) 2021 Open Technologies for Integration
# Licensed under the MIT license (see LICENSE for details)

# main() will be invoked when you invoke this action.
#
# When enabled as a web action, use the following URL to invoke this action:
# https://{APIHOST}/api/v1/web/{QUALIFIED ACTION NAME}?location=Austin
#
# For example:
# https://openwhisk.ng.bluemix.net/api/v1/web/myusername@us.ibm.com_myspace/get-http-resource/location?location=Austin
#
# In this case, the params variable will look like:
# { "location": "Austin" }

def main(params):
    if 'location' not in params:
        params.update({'location': 'Austin'})

    #ls_call = subprocess.run(["ls", "-l", "/"], stdout=subprocess.PIPE, text=True)
    server_call = subprocess.run(["/home/aceuser/run-server.sh"], stdout=subprocess.PIPE, shell=True, text=True, input="{}")
    server_dict = json.loads(server_call.stdout)
    return {
        'statusCode': 200,
        'headers': { 'Content-Type': 'application/json'},
        'body': server_dict
    }
