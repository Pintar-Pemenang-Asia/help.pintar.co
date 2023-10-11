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

if [ -d "contents/blog/en/" ]; then
    echo "Folder content/blog/en/ Exist, Copy Files to $EN_BLOG_DESTINATION"
    cp -r contents/blog/en/*.md $EN_BLOG_DESTINATION
    cp -r contents/blog/en/*.md blog
else
    echo "Folder Blog English Not Exist"
fi

if [ -d "contents/blog/id/" ]; then
    echo "Folder content/blog/id/ Exist, Copy Files to $EN_BLOG_DESTINATION"
    cp -r contents/blog/id/*.md $EN_BLOG_DESTINATION
    cp -r contents/blog/id/*.md blog
else
    echo "Folder Blog Indonesia Not Exist"
fi

# Copy Blog Eng
migrateFiles en blog $EN_BLOG_DESTINATION
migrateFiles id blog $ID_BLOG_DESTINATION

migrateFiles en docs $EN_DOCS_DESTINATION
migrateFiles id docs $ID_DOCS_DESTINATION

migrateFiles en docs/degrees $EN_DOCS_DESTINATION
migrateFiles id docs/degrees $ID_DOCS_DESTINATION

migrateFiles en docs/enterprise $EN_DOCS_DESTINATION
migrateFiles id docs/enterprise $ID_DOCS_DESTINATION

migrateFiles en docs/faq $EN_DOCS_DESTINATION
migrateFiles id docs/faq $ID_DOCS_DESTINATION

migrateFiles en docs/prakerja $EN_DOCS_DESTINATION
migrateFiles id docs/prakerja $ID_DOCS_DESTINATION

migrateFiles en docs/skills $EN_DOCS_DESTINATION
migrateFiles id docs/skills $ID_DOCS_DESTINATION