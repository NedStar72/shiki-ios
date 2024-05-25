#!/bin/bash

set -euo pipefail

ROOT_DIR=$(git rev-parse --show-toplevel)

swiftformat $ROOT_DIR
swiftlint lint --fix --quiet --config $ROOT_DIR/.swiftlint.yml