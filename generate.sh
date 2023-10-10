#!/bin/bash

i18n="i18n"
blog="blog"

##### Blog Posts #####

echo "Cleanup Blog Posts"

rm -rf "$blog/*.md"

echo "Copy Files Translations English to Destination Folder"

BLOG_PATH_DESTINATION="docusaurus-plugin-content-blog"
EN_BLOG_DESTINATION="$i18n/en/$BLOG_PATH_DESTINATION"
ID_BLOG_DESTINATION="$i18n/id/$BLOG_PATH_DESTINATION"

find contents/blog -type f -name '*.en.md' > list-en.txt
find contents/blog -type f -name '*.id.md' > list-id.txt

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


# Count line in list-en.txt
COUNT_EN=$(awk 'END {print NR}' list-en.txt)


if [[ $COUNT_EN -gt 0 ]]; then

    echo "Copy Files Blog English From contents/blog to $EN_BLOG_DESTINATION"

    while read line; do
        echo "Copy $line to $EN_BLOG_DESTINATION"

        FILENAME=$(basename $line)
        cp $line "$EN_BLOG_DESTINATION/${FILENAME%.en.md}.md"
        cp $line "blog/${FILENAME%.en.md}.md"

    done < list-en.txt
fi

# Count line in list-id.txt
COUNT_ID=$(awk 'END {print NR}' list-id.txt)

if [ $COUNT_ID -gt 0 ]; then

    echo "Copy Files Blog Indonesia From contents/blog to $ID_BLOG_DESTINATION"

    while read line; do
        echo "Copy $line to $ID_BLOG_DESTINATION"

        FILENAME=$(basename $line)
        cp $line "$ID_BLOG_DESTINATION/${FILENAME%.id.md}.md"

    done < list-id.txt
fi