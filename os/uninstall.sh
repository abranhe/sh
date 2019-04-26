#!/bin/bash

setup () {
  echo "  Uninstalling OS....."
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

  ## build
  {
    make_uninstall
    echo "  Done! We are going to miss you :/"
  } >&2
  return $?
}

## make targets
BIN="os"
[ -z "$PREFIX" ] && PREFIX="/usr/local"

make_uninstall () {
  # echo "  info: Uninstalling $PREFIX/bin/$BIN..."
  rm -f "$PREFIX/bin/$BIN"
  return $?
}

## go
[ $# -eq 0 ] && setup || make_$1
exit $?