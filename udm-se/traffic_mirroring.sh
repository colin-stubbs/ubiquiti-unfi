#!/bin/bash

SWITCH_SUBINT=1
IDS_PORT="eth4"

# setup monitoring of the internal network via switch subinterface, e.g. switch0.1
tc -s qdisc ls dev switch0.${SWITCH_SUBINT} 1>/dev/null 2>&1 || tc qdisc add dev switch0.${SWITCH_SUBINT} handle ffff: ingress
# tc -s qdisc ls dev switch0.${SWITCH_SUBINT}

# direct traffic out the physical interface connected to the Corelight sensor
tc -s -p filter ls dev switch0.${SWITCH_SUBINT} parent ffff: 1>/dev/null 2>&1 || tc filter add dev switch0.${SWITCH_SUBINT} parent ffff: protocol all u32 match u32 0 0 action mirred egress mirror dev ${IDS_PORT}
# tc -s -p filter ls dev switch0.${SWITCH_SUBINT} parent ffff:

# EOF
