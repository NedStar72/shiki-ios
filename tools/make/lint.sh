#!/bin/bash

set -euo pipefail

ROOT_DIR=$(git rev-parse --show-toplevel)

swiftformat $ROOT_DIR --lint
swiftlint lint --quiet --config $ROOT_DIR/.swiftlint.yml
