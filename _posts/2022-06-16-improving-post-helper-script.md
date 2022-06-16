---
---
<style>
    .highlight .gd {
	color: white;
	background-color: #ff000050;
    }
    .highlight .gi {
	color: white;
	background-color: #00ff0050;
    }
</style>
```diff
 #!/bin/sh
 
+set -e

 [ -n "${DEBUG}" ] && set -x
 
-_postpattern="_posts/$(date +'%Y-%m-%d-*.md')"
+_date=$(date '+%F' --date="${1:-now}")

+_postpattern="_posts/${_date}-*.md"
 
 if [ -z "${post}" ]; then
     post=$(find _posts/ -name "${_postpattern##*/}")
 fi
 
 if [ -z "${post}" ]; then
+    echo creating post for ${_date}
     read -p "NAME/SLUG REQUIRED: " slug
-    post="${_postpattern/\*/${slug}}"
+    post="${_postpattern%%\**}${slug}${_postpattern##*\*}"
 fi
 
 "${EDITOR:-vi}" "${post}"
```
