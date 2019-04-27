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

REMOTE=${REMOTE:-https://github.com/abranhe/os.git}
TMPDIR=${TMPDIR:-/tmp}
INSTALLER_NAME="os"
DEST=${DEST:-${TMPDIR}/os}

# Colors
RESET="\033[0m"
GREEN="\033[1;32m"
YELLOW="\033[0;33m"
RED='\033[0;31m'

#-----------------------------------------------------------------------------------

## Test if command exists
ftest () {
  echo -ne " info: Checking for ${1}...\r"
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
      echo -ne >&2 "${RED}  error: Missing \`${f}'! Make sure it exists and try again.${RESET}"
      sleep 1
      return 1
    }
  done
  return 0
}

#-----------------------------------------------------------------------------------

progress() {
  echo -ne " Installing.\r" 
  sleep 1
  echo -ne " Installing..\r" 
  sleep 1
  echo -ne " Installing...\r"
  sleep 1
  echo -ne " Installing....\r"
  sleep 1
  echo -ne " Installing....\r"
  sleep 1
  echo -ne " Installing.....\r"
  clean_line
}

#-----------------------------------------------------------------------------------

clean_line() {
  echo -ne "                                                                                                                                          \r"
}

#-----------------------------------------------------------------------------------

## main setup
setup () {
  echo
  echo "   ______    ______"
  echo "  /      \  /      \\"
  echo " /\$\$\$\$\$\$  |/\$\$\$\$\$\$  |"
  echo " \$\$ |  \$\$ |\$\$ \\__\$\$/"
  echo " \$\$ |  \$\$ |\$\$      \\"
  echo " \$\$ |  \$\$ | \$\$\$\$\$\$  |"
  echo " \$\$ \\__\$\$ |/  \\__\$\$ |"
  echo " \$\$    \$\$/ \$\$    \$\$/"
  echo "  \$\$\$\$\$\$/   \$\$\$\$\$\$/  "
  echo
  echo " For more information visit https://p.abranhe.com/os"
  sleep 1

  ## test for require features
  features git || return $?

  ## build
  {
    cd "${TMPDIR}"
    test -d "${DEST}" && { echo -ne "${YELLOW} warn: Already exists: '${DEST}'${RESET}\r"; }
    clean_line
    rm -rf "${DEST}"
    echo -ne " Fetching latest 'os'...\r"
    sleep 1
    git clone --depth=1 "${REMOTE}" "${DEST}" > /dev/null 2>&1
    cd "${DEST}"
    make_install
    progress
    echo -e "${GREEN} Done! ✨${RESET}"
  } >&2
  return $?
}

#-----------------------------------------------------------------------------------

## make targets
BIN=$INSTALLER_NAME
[ -z "$PREFIX" ] && PREFIX="/usr/local"

#-----------------------------------------------------------------------------------

make_install () {
  make_uninstall
  echo -ne " Installing $BIN to $PREFIX/bin/$BIN..."
  sleep 1
  clean_line
  cd $DEST
  make install > /dev/null 2>&1
  cp -f $DEST/$BIN /usr/local/bin/$BIN
  local source=$(<$BIN)
  return $?
}

#-----------------------------------------------------------------------------------

make_uninstall () {
  echo -ne " Uninstalling $PREFIX/bin/$BIN...\r"
  sleep 1
  clean_line
  rm -f "$PREFIX/bin/$BIN"
  return $?
}

#-----------------------------------------------------------------------------------

## go
[ $# -eq 0 ] && setup || make_$1
exit $?
