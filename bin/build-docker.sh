#!/bin/bash

#
#   Copyright 2020 Amir Kantor
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

# ___File name:___ build-docker.sh

# ___File purpose:___ Utility script for developers (to be used in the host
# machine) for building a Docker image.

echo "Building mai..."

if [ -z "$1" ]; then
    echo "ERROR! Missing CLI argument: path to mai's root directory
          (Dockerfile's location) is missing."
    exit 1
fi

MAI_ROOT="$1"

docker image build --no-cache -t mai "$MAI_ROOT"
