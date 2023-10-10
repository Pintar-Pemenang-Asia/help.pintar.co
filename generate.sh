#!/bin/bash

echo "Copy Files Translations English to Destination Folder"

i18n="i18n"
BLOG_PATH_DESTINATION="docusaurus-plugin-content-blog"

EN_BLOG_DESTINATION="$i18n/en/$BLOG_PATH_DESTINATION"
ID_BLOG_DESTINATION="$i18n/id/$BLOG_PATH_DESTINATION"

find contents/blog -type f -name '*.en.md' > list-en.txt
find contents/blog -type f -name '*.id.md' > list-id.txt

echo "Copy Files Blog English to $EN_BLOG_DESTINATION"

while read line; do
    echo "Copy $line to $EN_BLOG_DESTINATION"

    FILENAME=$(basename $line)
    cp $line "$EN_BLOG_DESTINATION/${FILENAME%.en.md}.md"

done < list-en.txt

echo "Copy Files Blog Indonesia to $ID_BLOG_DESTINATION"

while read line; do
    echo "Copy $line to $ID_BLOG_DESTINATION"

    FILENAME=$(basename $line)
    cp $line "$ID_BLOG_DESTINATION/${FILENAME%.id.md}.md"

done < list-id.txt
