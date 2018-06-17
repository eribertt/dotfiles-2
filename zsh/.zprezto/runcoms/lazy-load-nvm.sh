#!/usr/bin/env bash

NVM_DIR="$HOME/.nvm"

if [ -d $NVM_DIR/versions/node ]; then
  NODE_GLOBALS=($(find $NVM_DIR/versions/node -maxdepth 3 \( -type l -o -type f \) -wholename '*/bin/*' | xargs -n1 basename | sort | uniq))
fi

NODE_GLOBALS+=("nvm")

load_nvm() {
  for cmd in "${NODE_GLOBALS[@]}"; do unset -f ${cmd} &>/dev/null; done

  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "/usr/share/nvm/nvm.sh" ] && . "/usr/share/nvm/nvm.sh"

  nvm use 2> /dev/null 1>&2 || true

  export NVM_LOADED=1
}

for cmd in "${NODE_GLOBALS[@]}"; do
  if ! which ${cmd} &>/dev/null; then
    eval "${cmd}() { unset -f ${cmd} &>/dev/null; [ -z \${NVM_LOADED+x} ] && load_nvm; ${cmd} \$@; }"
  fi
done
