#!/bin/bash

function cleanup() {
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

        if [ -d "$DESTINATION" ]; then
            echo "Folder $DESTINATION Exist, Cleanup Folder"
            rm -rf "$DESTINATION"
        fi
        
        echo "Folder $SOURCE Exist, Cleanup Folder"
        rm -rf "$SOURCE"
    else
        rm -rf "$DESTINATION/*"
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
cleanup en blog $EN_BLOG_DESTINATION
cleanup id blog $ID_BLOG_DESTINATION

# migrateFiles en docs $EN_DOCS_DESTINATION
# migrateFiles id docs $ID_DOCS_DESTINATION

cleanup en docs/degrees $EN_DOCS_DESTINATION
cleanup id docs/degrees $ID_DOCS_DESTINATION

cleanup en docs/enterprise $EN_DOCS_DESTINATION
cleanup id docs/enterprise $ID_DOCS_DESTINATION

cleanup en docs/faq $EN_DOCS_DESTINATION
cleanup id docs/faq $ID_DOCS_DESTINATION

cleanup en docs/prakerja $EN_DOCS_DESTINATION
cleanup id docs/prakerja $ID_DOCS_DESTINATION

cleanup en docs/skills $EN_DOCS_DESTINATION
cleanup id docs/skills $ID_DOCS_DESTINATION

rm -rf list-*.txt