#!/bin/bash

# MIT License

# Copyright (c) 2019 Abraham Hernandez <abraham@abranhe.com> (abranhe.com)

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#      ______    ______
#     /      \  /      \
#    /$$$$$$  |/$$$$$$  |
#    $$ |  $$ |$$ \__$$/
#    $$ |  $$ |$$      \
#    $$ |  $$ | $$$$$$  |
#    $$ \__$$ |/  \__$$ |
#    $$    $$/ $$    $$/
#     $$$$$$/   $$$$$$/ 
#
# For more information visit 
#
#  - https://github.com/abranhe/os
#  - https://p.abranhe.com/os
#
#-----------------------------------------------------------------------------------

# Colors
RESET="\033[0m"
GREEN="\033[1;32m"
YELLOW="\033[0;33m"
RED='\033[0;31m'
BIN="os"

#-----------------------------------------------------------------------------------

## Test if command exists
ftest () {
  echo -ne " info: Checking for ${1}...\r"
  sleep 1
  if ! type -f "${1}" > /dev/null 2>&1; then
    return 1
  else
    return 0
  fi
}

#-----------------------------------------------------------------------------------

## Feature Tests
features () {
  for f in "${@}"; do
    ftest "${f}" || {
      echo -ne >&2 "${RED} Sorry \`${f}' is not installed on your machine.${RESET}"
      return 1
    }
  done
  return 0
}

#-----------------------------------------------------------------------------------

setup () {
  echo "   ______    ______"
  echo "  /      \  /      \\"
  echo " /\$\$\$\$\$\$  |/\$\$\$\$\$\$  |"
  echo " \$\$ |  \$\$ |\$\$ \\__\$\$/"
  echo " \$\$ |  \$\$ |\$\$      \\"
  echo " \$\$ |  \$\$ | \$\$\$\$\$\$  |"
  echo " \$\$ \\__\$\$ |/  \\__\$\$ |"
  echo " \$\$    \$\$/ \$\$    \$\$/"
  echo "  \$\$\$\$\$\$/   \$\$\$\$\$\$/"
  echo

  ## test for require features
  features $BIN || return $?

  ## build
  {
    make_uninstall
  } >&2
  return $?
}

#-----------------------------------------------------------------------------------

progress() {
  clean_line
  echo -ne " Uninstalling.\r" 
  sleep 1
  echo -ne " Uninstalling..\r" 
  sleep 1
  echo -ne " Uninstalling...\r"
  sleep 1
  echo -ne " Uninstalling....\r"
  sleep 1
  echo -ne " Uninstalling....\r"
  sleep 1
  echo -ne " Uninstalling.....\r"
  clean_line
}

#-----------------------------------------------------------------------------------

clean_line() {
  echo -ne "                                                                                                                                          \r"
}

#-----------------------------------------------------------------------------------

[ -z "$PREFIX" ] && PREFIX="/usr/local"

make_uninstall () {
  progress
  rm -f "$PREFIX/bin/$BIN"
  echo -e "${GREEN} Done! ✨${RESET}"
  return $?
}

## go
[ $# -eq 0 ] && setup
exit $?