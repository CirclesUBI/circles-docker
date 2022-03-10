#!/bin/bash

TMP_FOLDER=.tmp

# Check if subfolder exists and create it if not
check_tmp_folder() {
  repository=$1
  folder_name=$2

  # Create root temporary folder if it does not exist yet
  if ! [ -d "$TMP_FOLDER" ]; then
    mkdir $TMP_FOLDER
  fi

  # Clone repository into subfolder when it does not exist yet
  if ! [ -d "$TMP_FOLDER/$folder_name" ]; then
    git clone $repository $TMP_FOLDER/$folder_name
  fi

  # Goto subfolder
  cd $TMP_FOLDER/$folder_name
}
