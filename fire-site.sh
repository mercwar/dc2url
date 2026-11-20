#!/bin/bash
# IDENTITY: VERSION 3.9 // FIRE-SITE // CVBGOD
# ROLE: Dynamic Sitemap Generation with URL Encoding & Link/Datalake Safety.

# 1. Get the base GitHub URL from your git config
REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//; s#git@github.com:#https://github.com/#; s#https://[^@]*@github.com/#https://github.com/#')
BRANCH="main"
BASE_URL="${REPO_URL}/blob/${BRANCH}"

OUTPUT_FILE="sitemap.xml"

echo "Generating sitemap for: ${BASE_URL}"

url_encode_path() {
    local p="$1"
    # Encode spaces first, then other common URL-unsafe characters while preserving '/'
    p="${p// /%20}"
    p="${p//\#/%23}"
    p="${p//\?/%3F}"
    p="${p//\%/%25}"
    printf '%s' "$p"
}

xml_escape() {
    local s="$1"
    s="${s//&/&amp;}"
    s="${s//</&lt;}"
    s="${s//>/&gt;}"
    s="${s//\"/&quot;}"
    s="${s//\'/&apos;}"
    printf '%s' "$s"
}

# 2. Start the XML structure
{
    echo '<?xml version="1.0" encoding="UTF-8"?>'
    echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

    # 3. Find all regular files while pruning .git, AVIS-DATALAKE, and the generated sitemap itself
    find . \
        \( -path './.git' -o -path './AVIS-DATALAKE' -o -name "$OUTPUT_FILE" \) -prune \
        -o -type f -print0 | while IFS= read -r -d '' file; do
        CLEAN_PATH="${file#./}"
        ENCODED_PATH=$(url_encode_path "$CLEAN_PATH")
        SAFE_LOC=$(xml_escape "${BASE_URL}/${ENCODED_PATH}")

        printf '  <url>\n    <loc>%s</loc>\n  </url>\n' "$SAFE_LOC"
    done

    # 4. Close the tag
    echo '</urlset>'
} > "$OUTPUT_FILE"

echo "Done! Full sitemap saved to $OUTPUT_FILE"
