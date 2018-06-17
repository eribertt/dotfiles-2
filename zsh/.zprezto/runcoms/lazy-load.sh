#!/usr/bin/env bash

# usage: lazyload <name> <path> [source ...] -- callback
lazyload() {
  local name="$1"; shift
  local spath="$1"; shift
  local sources=()

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --) shift; break ;;
      *) sources+=("$1"); shift ;;
    esac
  done

  local globals=()
  () {
    local IFS=$'\0'
    globals=($(find "$spath" -maxdepth 3 \( -type l -o -type f \) -path '*/bin/*' -print0 | xargs -0n1 basename -z | sort -zu ))
    globals[-1]=() # For some reason theres a blank entry at the end
    globals+=("$name")
  }
  eval "lazy_sources_$name"='(${sources[@]})'
  eval "lazy_globals_$name"='(${globals[@]})'
  eval "lazy_callback_$name"='($@)'


  eval "lazy_load_$name()" '{
      for source in "${lazy_sources_'"$name"'[@]}"; do
        . "$source"
      done

      if [[ ${#lazy_callback_'"$name"'} -gt 0 ]]; then
         "${lazy_callback_'"$name"'[@]}"
      fi
      lazy_loaded_'"$name"'=1
    }'


  if [[ -o interactive ]]; then
    for cmd in "${globals[@]}"; do
      eval "${cmd}() { unset -f ${cmd} &>/dev/null; [ -z \${lazy_loaded_$name+x} ] && lazy_load_$name; ${cmd} \$@; }"
    done
  else
    "lazy_load_$name"
  fi
}

