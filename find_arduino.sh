#!/bin/bash

for sysdevpath in $(find /sys/bus/usb/devices/usb*/ -name dev); do
    (
        syspath="${sysdevpath%/dev}"
        devname="$(udevadm info -q name -p $syspath)"
        #[[ "$devname" == "bus/"* ]] || [[ "$devname" == "input/"* ]] && continue
        [[ "$devname" != "tty"* ]] && continue
        eval "$(udevadm info -q property --export -p $syspath)"
        [[ -z "$ID_MODEL_FROM_DATABASE" ]] && continue
        echo "/dev/$devname - $ID_MODEL_FROM_DATABASE"
    )
done