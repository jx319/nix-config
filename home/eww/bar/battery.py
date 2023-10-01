#!/usr/bin/env python3

import sys

# get values from piped acpi
acpi = sys.stdin.read().split()
status = acpi[2].split(",")[0]
charge = int(acpi[3].split("%")[0])

# Choose the right icon
if status == "Full":
    batstr = "󰂄"
elif status == "Discharging":
    if charge >= 95:
        batstr = "󰁹"
    elif charge >= 85:
        batstr = "󰂂"
    elif charge >= 75:
        batstr = "󰂁"
    elif charge >= 65:
        batstr = "󰂀"
    elif charge >= 55:
        batstr = "󰁿"
    elif charge >= 45:
        batstr = "󰁾"
    elif charge >= 35:
        batstr = "󰁽"
    elif charge >= 25:
        batstr = "󰁼"
    elif charge >= 15:
        batstr = "󰁻"
    elif charge >= 5:
        batstr = "󰁺"
    else:
        batstr = "󱃍"
elif status == "Charging":
    if charge >= 95:
        batstr = "󰂅"
    elif charge >= 85:
        batstr = "󰂋"
    elif charge >= 75:
        batstr = "󰂊"
    elif charge >= 65:
        batstr = "󰢞"
    elif charge >= 55:
        batstr = "󰂉"
    elif charge >= 45:
        batstr = "󰢝"
    elif charge >= 35:
        batstr = "󰂈"
    elif charge >= 25:
        batstr = "󰂇"
    elif charge >= 15:
        batstr = "󰂆"
    elif charge >= 5:
        batstr = "󰢜"
    else:
        batstr = "󰢟"
else: 
    batstr = "󰂑"


batstr += " " + str(charge) + "%"

#print(status  + str(charge))
print(batstr)