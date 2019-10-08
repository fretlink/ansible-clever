#!/usr/bin/env bash

set -e

function setBuildFlavor {
  clever scale --build-flavor "${BUILD_FLAVOR}"
}

setBuildFlavor
