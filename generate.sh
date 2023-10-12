#!/bin/bash

function migrateFiles() {
    # en or id
    LANG=$1
    # directory in contents
    SOURCE=$2
    # destination folder in i18n
    DESTINATION=$3
    # Source Folder Base
    SOURCE_BASE=$(basename $SOURCE)
    # Destination Folder Base
    DESTINATION_BASE=$DESTINATION

    find "contents/$SOURCE" -maxdepth 1 -type f -name "*.$LANG.md" > "list-$SOURCE_BASE-$LANG.txt"
    COUNT=$(awk 'END {print NR}' "list-$SOURCE_BASE-$LANG.txt")

    if [[ $COUNT -gt 0 ]]; then

        # Check if destination folder have name with prefix "docs"
        if [[ $DESTINATION_BASE == *"docs"* ]]; then
            SUB_DOCS=false

            # if prefix is degree, enterprise, faq, prakerja, skills
            if [[ $SOURCE_BASE == *"degrees"* ]] || [[ $SOURCE_BASE == *"enterprise"* ]] || [[ $SOURCE_BASE == *"faq"* ]] || [[ $SOURCE_BASE == *"prakerja"* ]] || [[ $SOURCE_BASE == *"skills"* ]]; then
                DESTINATION_BASE="$DESTINATION/current/$SOURCE_BASE"
                SUB_DOCS=true
            else
                DESTINATION_BASE="$DESTINATION/current"
            fi

            if [ ! -d "$DESTINATION_BASE" ]; then
                mkdir -p "$DESTINATION_BASE"
            fi

            if [ ! -d "$SOURCE" ]; then
                mkdir -p "$SOURCE"
            fi

            # Copy category.json
            if [[ $SUB_DOCS == true ]]; then
                cp "contents/$SOURCE/_category_.json" "$DESTINATION_BASE"
                cp "contents/$SOURCE/_category_.json" "$SOURCE"
            fi
        fi

        echo "Copy Files $SOURCE $LANG From contents/$SOURCE to $DESTINATION_BASE"

        while read line; do

            echo "Copy $line to $DESTINATION_BASE"

            FILENAME=$(basename $line)
            cp $line "$DESTINATION_BASE/${FILENAME%.$LANG.md}.md"
            cp $line "$SOURCE/${FILENAME%.$LANG.md}.md"

        done < "list-$SOURCE_BASE-$LANG.txt"
    fi
}

function multiple_folders() {
    # en or id
    LANG=$1
    # directory in contents
    SOURCE=$2
    # destination folder in i18n
    DESTINATION=$3
    # Source Folder Base
    SOURCE_BASE=$(basename $SOURCE)
    # Sub Docs
    SUB_DOCS=false

    if [[ $DESTINATION == *"docs"* ]]; then
        SUB_DOCS=true
        DESTINATION="$DESTINATION/current/$SOURCE_BASE"
    fi

    if [ ! -d "$DESTINATION" ]; then
        echo "Folder $DESTINATION Not Exist, Create Folder"
        mkdir -p "$DESTINATION"
    fi

    if [ -d "contents/$SOURCE/$LANG" ]; then
        echo "Folder content/$SOURCE/$LANG Exist, Copy Files to $DESTINATION"
        cp -r contents/$SOURCE/$LANG/*.md $DESTINATION

        if [[ $LANG ==  "en" ]]; then
            cp -r contents/$SOURCE/$LANG/*.md $SOURCE
        fi

        if [[ $SUB_DOCS == true ]]; then
            cp "contents/$SOURCE/_category_.json" "$DESTINATION"
            cp "contents/$SOURCE/_category_.json" "$SOURCE"
        fi
    else
        echo "Folder $SOURCE $LANG Not Exist"
    fi
}

i18n="i18n"
blog="blog"

##### Blog Posts #####

echo "Cleanup Blog Posts"

rm -rf "$blog/*.md"

echo "Copy Files Translations English to Destination Folder"

BLOG_PATH_DESTINATION="docusaurus-plugin-content-blog"
EN_BLOG_DESTINATION="$i18n/en/$BLOG_PATH_DESTINATION"
ID_BLOG_DESTINATION="$i18n/id/$BLOG_PATH_DESTINATION"

DOCS_PATH_DESTINATION="docusaurus-plugin-content-docs"
EN_DOCS_DESTINATION="$i18n/en/$DOCS_PATH_DESTINATION"
ID_DOCS_DESTINATION="$i18n/id/$DOCS_PATH_DESTINATION"

echo "Check Multiple Folder Blog Translations"

# Copy Blog Eng
multiple_folders en blog $EN_BLOG_DESTINATION
multiple_folders id blog $ID_BLOG_DESTINATION

migrateFiles en docs $EN_DOCS_DESTINATION
migrateFiles id docs $ID_DOCS_DESTINATION

multiple_folders en docs/degrees $EN_DOCS_DESTINATION
multiple_folders id docs/degrees $ID_DOCS_DESTINATION

multiple_folders en docs/enterprise $EN_DOCS_DESTINATION
multiple_folders id docs/enterprise $ID_DOCS_DESTINATION

multiple_folders en docs/faq $EN_DOCS_DESTINATION
multiple_folders id docs/faq $ID_DOCS_DESTINATION

multiple_folders en docs/prakerja $EN_DOCS_DESTINATION
multiple_folders id docs/prakerja $ID_DOCS_DESTINATION

multiple_folders en docs/skills $EN_DOCS_DESTINATION
multiple_folders id docs/skills $ID_DOCS_DESTINATION