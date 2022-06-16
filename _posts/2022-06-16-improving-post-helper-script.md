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

### add `set -e`

In shell scripts `set -e` is an instruction
to the shell to exit any time it encounters
an error.

In shells (in \*nix) any command that exits
with `0` as the exit code **suceeded**. Any
non-zero exit code is a failure. With
`set -e` the shell is watching for non-zero
exit codes. And when one occurs, the entire
script exits with failure.

And while I had not really needed this
before, it became necessary now because
I started to use the `date` program
an external command that **could** fail
with the wrong input values.

### use `date` for easy

I often end up writing posts the early hours
of the next day. Happens when one stays up
late. So `./post` would not have the expected
result since it was configured to work for
"today".

I wanted to run `./post yesterday` and have
it automatically open the post of the
previous day for editing.

I wasn't sure what I could use, but turns
out good old `date(1)` was all I needed
`date` takes the `--date` parameter
whose value could also be relative terms
like _yesterday_, _tomorrow_, _next week_

And because I set the script to exit on
errors I don't need to worry about invalid
terms that `date` does not understand

### sh parameter expansion

is often tricky. I was able to run
simple substitution with `${var/find/replace}`
syntax in my Fedora installation.
But it failed in my Debian ones.
Weird. So I decided to check POSIX
specs, and apparently only remove suffix/prefix
is in the spec.

So that was one hacky solution, but now
I understand the removal expansion much
better than I ever have before!
