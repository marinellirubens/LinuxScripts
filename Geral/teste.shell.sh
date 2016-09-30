#!/usr/bin/expect -f
spawn ssh rubens@192.168.0.191
expect "Password:"
send "rubens\r"
interact
