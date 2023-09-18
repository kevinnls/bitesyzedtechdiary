---
title: Terminal for Plebeians
description: >
    Not just for nerds, the command line is a great tool
    for regular people too!
image:
    path: /assets/post-img/2023/09/18-000-cowsay_term_for_mooore.png
    alt: >
        a wise cow living in the terminal says:
        far mooore than nerds the terminal exists to serve
---

The terminal is oft considered an esoteric tool intended
for programmers and none else. The sight of a terminal is
immediately associated with coding.

> This one time, a classmate asked me after class "What are
> you always coding?"
>
> I was simply taking lecture notes in vim.

Okay, most would immediately disqualify my being "plebeian"
on account of my using vim… doesn't help that I was writing
in markdown.

But this post is more about the terminal being useful in fields
other than programming. In this particular case, a university
literature course.

## The splitting task

The instructor was going to go over excerpts from course material.
Some of the material was really long pdf files. But we only
needed a few sections. How do we extract out only the parts we need?

We could <abbr title="sign an eternal contract in money">pay
Adobe</abbr> to let us extract pages. Or my sneaky trick
of opening the pdf file in a browser and printing to file
after typing in the range of pages I need. But repeating
that 12 times with different page ranges each time is
meh.

## The CLI can split and unite

On the terminal, I have access to a tool called `pdfseparate`
that extracts pages from a pdf. But each page is saved to its
own file. Luckily, there's also a `pdfunite` that does I could
use to combine these files.

But while that solves the question of tools to use, I do still
need to repeatedly specify the page numbers somewhat like

```shell
pdfseparate -f 4 -l 5 "filename.pdf" "filename-p%d.pdf"
pdfunite "filename-p4.pdf" "filename-p5.pdf" "filename.excerpt.pdf"
```

That is two separate commands for just one file and each
filename and page count needs to be stated so expressly… how is this more
efficient?

It isn't. But the command line offers so much opportunity
for efficiency through other features such as loops.

## Loops

I could simply change my command to go over all the pdf files and
run the commands for each one. By using a variable `${file}`, I
can let the terminal (technically shell) change the filename
for each command.

```shell
for file in *.pdf; do
    pdfseparate -f XYZ -l XYZ "${file}.pdf" "${file}-p%d.page" ;
    pdfunite "${file}-p*.page" "${file}.excerpt.pdf" ;
done
```

Additionally, I set the individual pages to be saved to `.page` files
instead of `.pdf` file. This lets me use the `${file}-p*.page` part
to indicate a pattern of filenames instead of specifying each file
that needs to be combined by `pdfunite`; and also won't interfere
with my loop that is looking for the pattern `*.pdf`.

### Wildcards / Globs
The `*` is called a glob character (or wildcard) to mean that it
can match anything. In this particular case, it is being used
to select all files whose names match a particular pattern.

## Varying page numbers

Yet persists the problem of the required page number ranges
being different for each pdf file. I could use variables again.
But for this one, a little bit of manual typing is needed. So
I created a spreadsheet and ~~pushed off~~ delegated to a
classmate, the work of keying in the first and last page
number for each filename.

Spreadsheets can be easily exported to CSV (comma-separated value)
files. Then, I used a different loop on the CSV file's rows instead
of working on `*.pdf` as I did before.

```csv
filename-093.pdf,5,45
fileplace-02.pdf,3,12
fileanima-98.pdf,9,11
filethgns-09.pdf,1,9
```
The above is a sample CSV file. Now I could get values for three variables
from each row of the file, the filename, first page and last page.

```shell
while IFS=, read file firstp lastp; do
    pdfseparate -f ${firstp} -l ${lastp} "${file}.pdf" "${file}-p%d.page" ;
    pdfunite "${file}-p*.page" "${file}.excerpt.pdf" ;
done
```
You could also go further and combine all the excerpts into a single big file
using the handy `*.excerpt.pdf` pattern.

```shell
pdfunite "*.exercpt.pdf" "allmaterial.pdf"
```

## CLI for mooore than just code

And with that I conclude this badly written blog post. The CLI is useful in
situations other than coding&mdash;such as a university literature course.

Or to simple take notes in class if you use vim 😎


![that is just how my notepad looks](/assets/post-img/2023/09/18-001-not_code.png)

{%comment%}
<!--
#!/bin/sh

set -e

tmpdir=.sync-not
if [ ! -d ${tmpdir} ]; then mkdir "${tmpdir}"; fi

while IFS=, read sno fname fpage lpage author title year ; do

sno=$(printf "%03d" ${sno})

if [ -z "${lpage}" ]; then >&2 echo last page missing; exit 1; fi

pdfseparate "${fname%___*}/${fname}" \
-f ${fpage:-1} -l ${lpage} \
"${tmpdir}/${sno}-%03d.pdf"

if [ "${title}" == "%ignore%" ]; then continue; fi

cat <<- EOM >>${tmpdir}/000-title.md
1. **${title}**  
${author} _\(${year}\)_
EOM

cat <<- EOM | pandoc -fhtml -thtml -o ${tmpdir}/${sno}-000.pdf
<header>
<h1>${title}</h1>
<p>${author}</p>
<p>${year}</p>
</header>
EOM


done < pages.csv

pandoc -fmarkdown -thtml -o${tmpdir}/000-title.pdf ${tmpdir}/000-title.md
pdfunite ${tmpdir}/*.pdf ../LittératureContemporaines_extraits.pdf

-->

<!--
- vim: spell spelllang=en
-->
{%endcomment%}
