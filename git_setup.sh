echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
read full_name

echo "Type in your email address (the one used for your GitHub account): "
read email

echo "To list GPG KEYS  do ::   gpg --list-secret-keys --keyid-format LONG "
echo "Type in your GPG KEY ID (the one used for your GitHub account): "
read keyid

git config --global user.email $email
git config --global user.name $full_name
git config --global user.signingkey $keyid