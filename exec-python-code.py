#!/usr/bin/env python
import sys
import os
import subprocess
import json

# Copyright (c) 2021 Open Technologies for Integration
# Licensed under the MIT license (see LICENSE for details)

server_call = subprocess.run(["/home/aceuser/run-server.sh"], stdout=subprocess.PIPE, shell=True, text=True, input="{}")
#     server_dict = json.loads(server_call.stdout)
print server_call.stdout;
