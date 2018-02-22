#!/bin/bash -e

function checkDrain {
  clever drain | grep "${SYSLOG_UDP_SERVER}"
}

function setDrain {
  clever drain create UDPSyslog "udp://${SYSLOG_UDP_SERVER}"
}

checkDrain || setDrain
