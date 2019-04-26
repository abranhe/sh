#!/bin/bash
#      ______    ______
#     /      \  /      \
#    /$$$$$$  |/$$$$$$  |
#    $$ |  $$ |$$ \__$$/
#    $$ |  $$ |$$      \
#    $$ |  $$ | $$$$$$  |
#    $$ \__$$ |/  \__$$ |
#    $$    $$/ $$    $$/
#     $$$$$$/   $$$$$$/  https://p.abranhe.com/os
#

REMOTE=${REMOTE:-https://github.com/abranhe/os.git}
TMPDIR=${TMPDIR:-/tmp}
DEST=${DEST:-${TMPDIR}/os}

## test if command exists
ftest () {
  echo "  info: Checking for ${1}..."
  if ! type -f "${1}" > /dev/null 2>&1; then
    return 1
  else
    return 0
  fi
}

## feature tests
features () {
  for f in "${@}"; do
    ftest "${f}" || {
      echo >&2 "  error: Missing \`${f}'! Make sure it exists and try again."
      return 1
    }
  done
  return 0
}

## main setup
setup () {
  echo "  Welcome to the 'os' installer!"
  echo
  echo "   ______    ______"
  echo "  /      \  /      \\"
  echo " /\$\$\$\$\$\$  |/\$\$\$\$\$\$  |"
  echo " \$\$ |  \$\$ |\$\$ \\__\$\$/"
  echo " \$\$ |  \$\$ |\$\$      \\"
  echo " \$\$ |  \$\$ | \$\$\$\$\$\$  |"
  echo " \$\$ \\__\$\$ |/  \\__\$\$ |"
  echo " \$\$    \$\$/ \$\$    \$\$/"
  echo "  \$\$\$\$\$\$/   \$\$\$\$\$\$/  https://p.abranhe.com/os"
  echo

  ## test for require features
  features git || return $?

  ## build
  {
    echo
    cd "${TMPDIR}"
    echo "  info: Creating temporary files..."
    test -d "${DEST}" && { echo "  warn: Already exists: '${DEST}'"; }
    rm -rf "${DEST}"
    echo "  info: Fetching latest 'os'..."
    git clone --depth=1 "${REMOTE}" "${DEST}" > /dev/null 2>&1
    cd "${DEST}"
    echo "  info: Installing..."
    make_install
    echo "  info: Done!"
  } >&2
  return $?
}

## make targets
BIN="os"
[ -z "$PREFIX" ] && PREFIX="/usr/local"

# All 'bpkg' supported commands
CMDS="json install package term suggest init utils update list show getdeps"

make_install () {
  make_uninstall
  echo "  info: Installing $PREFIX/bin/$BIN..."
  cd $DEST && make install
  cp -f $DEST/$BIN /usr/local/bin/$BIN
  local source=$(<$BIN)
  return $?
}

make_uninstall () {
  echo "  info: Uninstalling $PREFIX/bin/$BIN..."
  rm -f "$PREFIX/bin/$BIN"
  for cmd in $CMDS; do
    rm -f "$PREFIX/bin/$BIN-$cmd"
  done
  return $?
}

## go
[ $# -eq 0 ] && setup || make_$1
exit $?
