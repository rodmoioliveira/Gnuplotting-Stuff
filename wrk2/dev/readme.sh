#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

readme() {
  cat <<EOF >|./wrk2/README.md
# gpwrk2

\`\`\`txt
$(./wrk2/gpwrk2 2>&1 --help)
\`\`\`

Result:

<p align="center">
  <img src="https://raw.githubusercontent.com/rodmoioliveira/Gnuplotting-Stuff/main/wrk2/data/plot/gpwrk2.png">
</p>

EOF

  sd '(make\[1\]:.+\n)' '' README.md
}

trap readme EXIT