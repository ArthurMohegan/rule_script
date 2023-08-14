#!/bin/bash
echo -e "pid\tswap\tproc_name"
for pid in $(ls /proc | grep -E '^[0-9]+$'); do
    if [[ -f /proc/$pid/smaps ]]; then
        swap=$(awk '/Swap:/ { sum += $2 } END { print sum }' /proc/$pid/smaps)
        if [[ $swap -gt 0 ]]; then
            proc_name=$(ps -p $pid -o cmd=)
            echo -e "$pid\t${swap} KB\t$proc_name"
        fi
    fi
done | sort -k2 -n
