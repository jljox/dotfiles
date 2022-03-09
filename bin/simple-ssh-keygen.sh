#!/bin/bash

THIS_SCRIPT_NAME="$(basename $0)"

NC='\033[0m'
LIGHT_BLUE='\033[1;34m'
LIGHT_GREEN='\033[1;32m'
RED="\033[0;31m"

found_in() {
  IS_FOUND="NO"
  for item in $2
  do
    if [[ $item == "$1" ]]
    then
      IS_FOUND="YES"
      break
    fi
  done
  echo $IS_FOUND
}

ask_and_take_answer() {
  echo ""
  echo -e "$1"
  echo ""
  read ANSWER
  while [[ `found_in "$ANSWER" "$2"` == "NO" ]]
  do
    echo ""
    echo -e "$1"
    read ANSWER
  done
}


DEFAULT_KEY_TYPE="ed25519"

if [[ -n "$1" ]]
  then

  KEY_TYPE_ED="ed25519"
  KEY_TYPE_RSA="rsa"

  ask_and_take_answer "Please select the key type.\n[0] $KEY_TYPE_ED\n[1] $KEY_TYPE_RSA\n[x] Exit" "0 1 x"

  if [[ $ANSWER == "0" ]]
    then
    KEY_TYPE=$KEY_TYPE_ED
    KEY_TYPE_OPTION="-t $KEY_TYPE_ED -a 128"
  elif [[ $ANSWER == "1" ]]
    then
    KEY_TYPE=$KEY_TYPE_RSA
    KEY_TYPE_OPTION="-t $KEY_TYPE_RSA -b 4096"
  else
    echo ""
    exit
  fi

  FILE_NAME="id_$KEY_TYPE"
  if [[ -n "$2" ]]
    then
    FILE_NAME="$2_${KEY_TYPE}"
  else
    printf "\n${RED}No key file name is given so the filename will be '${LIGHT_GREEN}$FILE_NAME${RED}'.${NC}\n"
  fi

  SSH_HOME="$HOME/.ssh"
  if [ ! -d "$SSH_HOME" ]; then
    printf "\n${LIGHT_GREEN}$SSH_HOME directory does not exist so it will be created.${NC}\n"
    mkdir "$SSH_HOME"
    chmod 700 "$SSH_HOME"
  fi

  EMAIL_ADDRESS="$1"
  KEY_FILE="$SSH_HOME/$FILE_NAME"
  printf "\n${LIGHT_GREEN}Generating SSH Key!${NC}\n"
  printf "key type: ${LIGHT_BLUE}${KEY_TYPE}${NC}\n"
  printf "   email: ${LIGHT_BLUE}$EMAIL_ADDRESS${NC}\n"
  printf "    file: ${LIGHT_BLUE}$KEY_FILE${NC}\n"
  echo ""

  ssh-keygen $KEY_TYPE_OPTION -C "$EMAIL_ADDRESS" -f "${KEY_FILE}" || { printf "\n\n${RED}Key generation failed.${NC}\n\n"; exit; }

  echo ""
  echo "Copying the public key..."
  printf "${LIGHT_GREEN}pbcopy${NC} < ${LIGHT_BLUE}${KEY_FILE}.pub${NC}\n"
  echo ""
  pbcopy < "${KEY_FILE}.pub"
  echo "Done: Your public key has been copied to the clipboard so now you can just Cmd+V!"
  echo ""

else
  printf "\n${RED}Please enter your email address and the file name (optional).${NC}\n"
  echo "e.g.)"
  echo "$THIS_SCRIPT_NAME your.email@address.com your_key_file_name "
  echo ""
  echo "Or"
  echo ""
  echo "$THIS_SCRIPT_NAME your.email@address.com "
  echo ""
fi
