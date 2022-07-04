#!/bin/bash

IDS_PORT="eth6"

tc filter add dev switch0.1 parent ffff: protocol all u32 match u32 0 0 action mirred egress mirror dev ${IDS_PORT}
tc -s -p filter ls dev switch0.1 parent ffff:

# EOF
