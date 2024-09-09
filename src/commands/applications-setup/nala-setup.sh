#!/bin/sh -e

. ../common-script.sh

setupNala() {
  echo "Install Nala if not already installed..."
  if ! command_exists nala; then
    case ${PACKAGER} in
    pacman)
      $ESCALATION_TOOL "${PACKAGER}" -S --needed --noconfirm nala
      ;;
    *)
      $ESCALATION_TOOL "${PACKAGER}" install -y nala
      ;;
    esac
  else
    echo "Nala is already installed."
  fi
  /etc/nala/nala.conf
  echo "Copy Nala config files"
  if [ -d "/etc/nala" ]; then
    cp -r "/etc/nala" "/etc/nala-bak"
  fi
  mkdir -p "/etc/nala/"
  wget -O "/etc/nala/nala.conf" https://https://github.com/iller7/linutil/raw/main/config/nala/nala.conf
}

checkEnv
checkEscalationTool
setupNala
