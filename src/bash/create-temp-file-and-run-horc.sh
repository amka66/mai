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

# ___File name:___ create-temp-file-and-run-horc.sh

# ___File purpose:___ Invoked by `run.sh` and assembles everything together.
# (1) Creating a temporary Prolog script that loads `zfc-shell.pl`,
# and an optional Prolog script `<prolog_file>`. (2) Invoking horc on
# the knowledge base `zfc.hn` (which loads the other knowledge bases),
# accompanied by the temporary Prolog script from (1).

FILENAME_PROLOG="$1"

# Note that the path to mai within the docker image is `/app/mai/`.
# Create a temporary Prolog script that is to be executed in horc.
cat > /app/mai/var/temp-loaded.pl << EOF
:- ensure_loaded('/app/mai/src/prolog/zfc-shell.pl').

:- ensure_loaded('$FILENAME_PROLOG').
EOF

# Execute horc:
bash /app/horc/src/bash/run.sh /app/mai/src/horn/zfc.hn /app/mai/var/temp-loaded.pl
