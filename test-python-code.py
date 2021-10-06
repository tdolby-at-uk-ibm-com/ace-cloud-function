#!/usr/bin/env python
import sys
import os
import subprocess
import json

# Copyright (c) 2021 Open Technologies for Integration
# Licensed under the MIT license (see LICENSE for details)

server_dict = json.load(sys.stdin)
print server_dict

