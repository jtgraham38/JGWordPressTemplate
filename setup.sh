#!/bin/bash

# read in the plugin data
echo "Enter the plugin name (default 'My Plugin'):"
read PLUGIN_NAME
PLUGIN_NAME=${PLUGIN_NAME:-"My Plugin"}

echo "Enter a brief plugin description (default 'This is my plugin description.'):"
read PLUGIN_DESCRIPTION
PLUGIN_DESCRIPTION=${PLUGIN_DESCRIPTION:-"This is my plugin description."}

echo "Enter the plugin uri (default 'https://jacob-t-graham.com'):"
read PLUGIN_URI
PLUGIN_URI=${PLUGIN_URI:-"https://jacob-t-graham.com"}

echo "Enter the plugin author (default 'JG Web Development'):"
read PLUGIN_AUTHOR
PLUGIN_AUTHOR=${PLUGIN_AUTHOR:-"JG Web Development"}

echo "Enter the author uri (default 'https://jacob-t-graham.com'):"
read PLUGIN_AUTHOR_URI
PLUGIN_AUTHOR_URI=${PLUGIN_AUTHOR_URI:-"https://jacob-t-graham.com"}

echo "Enter the plugin version (default '1.0.0'):"
read PLUGIN_VERSION
PLUGIN_VERSION=${PLUGIN_VERSION:-"1.0.0"}

echo "Enter the plugin license (default 'GPLv3 or later'):"
read PLUGIN_LICENSE
PLUGIN_LICENSE=${PLUGIN_LICENSE:-"GPLv3 or later"}

echo "Enter the plugin license uri (default 'https://www.gnu.org/licenses/gpl-3.0.html'):"
read PLUGIN_LICENSE_URI
PLUGIN_LICENSE_URI=${PLUGIN_LICENSE_URI:-"https://www.gnu.org/licenses/gpl-3.0.html"}

echo "Enter the plugin text domain (default 'my-plugin'):"
read PLUGIN_TEXT_DOMAIN
PLUGIN_TEXT_DOMAIN=${PLUGIN_TEXT_DOMAIN:-"my-plugin"}

#get plugin composer name
while true; do
    echo "Enter the plugin composer name (default 'jtgraham38/my-plugin'):"
    read PLUGIN_COMPOSER_NAME
    PLUGIN_COMPOSER_NAME=${PLUGIN_COMPOSER_NAME:-"jtgraham38/my-plugin"}

    #ensure composer name is in the correct format
    if [[ $PLUGIN_COMPOSER_NAME =~ ^[a-z0-9-]+/[a-z0-9-]+$ ]]; then
        break
    fi

    echo "Composer name must be in the format 'vendor/package'."
done

#get plugin main file name
while true; do
    echo "Enter your main plugin file name (default 'plugin.php'):"
    read MAIN_FILE
    MAIN_FILE=${MAIN_FILE:-"plugin.php"}

    #ensure main file name ends in .php
    if [ ${MAIN_FILE: -4} == ".php" ]; then
        break
    fi

    echo "File name must end in '.php'."
done



while true; do
    echo "Enter the plugin prefix:"
    read PLUGIN_PREFIX

    #ensure plugin prefix is at least 4 characters long
    if [ ${#PLUGIN_PREFIX} -gt 3 ]; then
        #if the plugin prefix does not end in _, add it
        if [ ${PLUGIN_PREFIX: -1} != "_" ]; then
            PLUGIN_PREFIX="${PLUGIN_PREFIX}_"
        fi
        break
    fi

    echo "Plugin prefix must be at least 4 characters long."
done

#get escaped versions of all entered values
PLUGIN_NAME=$(echo $PLUGIN_NAME | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
PLUGIN_DESCRIPTION=$(echo $PLUGIN_DESCRIPTION | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
PLUGIN_URI=$(echo $PLUGIN_URI | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
PLUGIN_AUTHOR=$(echo $PLUGIN_AUTHOR | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
PLUGIN_AUTHOR_URI=$(echo $PLUGIN_AUTHOR_URI | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
PLUGIN_VERSION=$(echo $PLUGIN_VERSION | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
PLUGIN_LICENSE=$(echo $PLUGIN_LICENSE | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
PLUGIN_LICENSE_URI=$(echo $PLUGIN_LICENSE_URI | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
PLUGIN_TEXT_DOMAIN=$(echo $PLUGIN_TEXT_DOMAIN | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
PLUGIN_COMPOSER_NAME=$(echo $PLUGIN_COMPOSER_NAME | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
MAIN_FILE=$(echo $MAIN_FILE | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')
PLUGIN_PREFIX=$(echo $PLUGIN_PREFIX | sed 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')

# echo the entered data, and get confirmation
echo "Plugin Name: $PLUGIN_NAME"
echo "Plugin URI: $PLUGIN_URI"
echo "Description: $PLUGIN_DESCRIPTION"
echo "Author: $PLUGIN_AUTHOR"
echo "Author URI: $PLUGIN_AUTHOR_URI"
echo "Version: $PLUGIN_VERSION"
echo "License: $PLUGIN_LICENSE"
echo "License URI: $PLUGIN_LICENSE_URI"
echo "Text Domain: $PLUGIN_TEXT_DOMAIN"
echo "Composer Name: $PLUGIN_COMPOSER_NAME"
echo "Main File: $MAIN_FILE"
echo "Prefix: $PLUGIN_PREFIX"
echo "Is this information correct? (y/n)"
read CONFIRM
if [ "$CONFIRM" != "y" ]; then
    echo "Exiting without making changes, please re-run the script to start over."
    exit 1
fi

#rename main file to specified value
echo "Setting main file name..."
mv ./plugin.php ./$MAIN_FILE
echo "Main file name set."

# fill in fields of plugin.php comment
echo "Filling in main file comment..."
sed -i "s/Plugin Name:.*/Plugin Name:\t$PLUGIN_NAME/" ./$MAIN_FILE
sed -i "s/Description:.*/Description:\t$PLUGIN_DESCRIPTION/" ./$MAIN_FILE
sed -i "s/Plugin URI:.*/Plugin URI:\t$PLUGIN_URI/" ./$MAIN_FILE
sed -i "s/Author:.*/Author:\t$PLUGIN_AUTHOR/" ./$MAIN_FILE
sed -i "s/Author URI:.*/Author URI:\t$PLUGIN_AUTHOR_URI/" ./$MAIN_FILE
sed -i "s/Version:.*/Version:\t$PLUGIN_VERSION/" ./$MAIN_FILE
sed -i "s/License:.*/License:\t$PLUGIN_LICENSE/" ./$MAIN_FILE
sed -i "s/License URI:.*/License URI:\t$PLUGIN_LICENSE_URI/" ./$MAIN_FILE
sed -i "s/Text Domain:.*/Text Domain:\t$PLUGIN_TEXT_DOMAIN/" ./$MAIN_FILE
echo "Main file comment filled in."

# fill in main fields of readme.txt
echo "Filling in readme.txt..."
sed -i "s/=== .* ===/=== $PLUGIN_NAME ===/" ./readme.txt
sed -i "s/Contributors:.*/Contributors: $PLUGIN_AUTHOR/" ./readme.txt
sed -i "s/License:.*$/License: $PLUGIN_LICENSE/" ./readme.txt
sed -i "s/License URI:.*$/License URI: $PLUGIN_LICENSE_URI/" ./readme.txt
sed -i "/== Description ==/{n;s/.*/$PLUGIN_DESCRIPTION/;}" ./readme.txt
echo "Readme.txt filled in.  Remember to finish filling in the rest of the readme.txt file."

# fill in header and description of README.md
echo "Filling in README.md..."
sed -i "s/# .*/# $PLUGIN_NAME/" ./README.md
echo -e "\n$PLUGIN_DESCRIPTION" >> ./README.md
echo "README.md filled in.  Remember to finish filling in the rest of the README.md file."

# fill in plugin prefix in main plugin file
echo "Filling in plugin prefix..."
sed -i "s/new Plugin(\".*\", plugin_dir_path( __FILE__ ), plugin_dir_url( __FILE__ ));/new Plugin(\"$PLUGIN_PREFIX\", plugin_dir_path( __FILE__ ), plugin_dir_url( __FILE__ ));/" ./$MAIN_FILE
echo "Plugin prefix filled in."

# fill in the composer fields in composer.json
echo "Filling in composer.json..."
sed -i "0,/\"name\": \".*\",/\"name\": \"$PLUGIN_COMPOSER_NAME\",/" ./composer.json #matches only the first instance
sed -i "s/\"description\": \".*\",/\"description\": \"$PLUGIN_DESCRIPTION\",/" ./composer.json
sed -i "s/\"version\": \".*\",/\"version\": \"$PLUGIN_VERSION\",/" ./composer.json

# run composer install to install plugin kit
echo "Installing plugin kit..."
composer install
echo "Plugin kit installed."

#add setup.sh to the gitignore, if it is not already there
echo "Adding setup.sh to .gitignore..."
if ! grep -q "setup.sh" ./.gitignore; then
    echo "setup.sh" >> ./.gitignore
    echo "setup.sh added to .gitignore."
else
    echo "setup.sh already in .gitignore."
fi

#check if the user wants to clear out the template git repo
echo "Would you like to clear out the template git repo? (y/n)"
read CLEAR_GIT
if [ "$CLEAR_GIT" == "y" ]; then
    echo "Clearing out the template git repo..."
    rm -rf ./.git
    echo "Template git repo cleared out."
fi

#ALL DONE!
echo "Plugin set up!"