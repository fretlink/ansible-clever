#!/usr/bin/env bash

set -e

function checkDomain {
  # DNS domain names are case insensitive
  clever domain | grep -i "${DOMAIN}"
}

function setDomain {
  clever domain add "${DOMAIN}"
}

checkDomain || setDomain
