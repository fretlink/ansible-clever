#!/bin/bash -e

function checkDomain {
  clever domain | grep "${DOMAIN}"
}

function setDomain {
  clever domain add "${DOMAIN}"
}

checkDomain || setDomain
