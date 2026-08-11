spaceship_container() {
  [[ $SPACESHIP_CONTAINER_SHOW == false ]] && return

  if ! [[ -z "$CONTAINER_ID" ]]; then
    local container_name="($CONTAINER_ID)"
  elif [[ -f "/run/.containerenv" ]]; then
    source "/run/.containerenv"
    local container_name="(󰏗 $name)"
  fi

  spaceship::section::v4 \
    --color "yellow" \
    "$container_name "
}
