#!/usr/bin/env bash
IFS=$'\n'

while getopts "u:e:k:" opt; do
  case $opt in
    u) full_name="$OPTARG"
    ;;
    e) email="$OPTARG"
    ;;
    k) keyid="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done  

if [ -z "$full_name" ]
then
  echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
  read full_name
fi

if  [ -z "$email" ]
then
  echo "Type in your email address (the one used for your GitHub account): "
  read email
fi

if [ -z "$keyid" ]
then
  echo "To list GPG KEYS  do ::   gpg --list-secret-keys --keyid-format LONG "
  echo "Type in your GPG KEY ID (the one used for your GitHub account): "
  read keyid
fi

echo "Github Username   : ${full_name}" 
echo "Github Email      : ${email}"
echo "Github GPG key ID : ${keyid}"

git config --global user.email $email
git config --global user.name $full_name
git config --global user.signingkey $keyid