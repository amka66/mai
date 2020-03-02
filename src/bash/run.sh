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

# ___File name:___ run.sh

# ___File purpose:___ Interface script executed first (top) when a Docker 
# container starts, and receiving its parameters from the command line.

echo "Running mai..."

FILENAME_PROLOG="${1:-/dev/null}"

# Note that the path to mai within the docker image is `/app/mai/`:
bash /app/mai/src/bash/create-temp-file-and-run-horc.sh "$FILENAME_PROLOG"
