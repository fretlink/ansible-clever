#!/usr/bin/env bash

set -e

function checkDomain {
  clever domain | grep "${DOMAIN}"
}

function setDomain {
  clever domain add "${DOMAIN}"
}

checkDomain || setDomain
