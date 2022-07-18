---
title: The <base> tag in HTML
description: I discover a way to make links work as I want!
images:
  - '/assets/post-img/2022/07/18-000-breadcrumbs_to_section.png'
---

<base target="_blank">
<script>
    document.title = 'The <base> tag in HTML'
    document.querySelector('article h1.post-title.p-name').innerHTML = 'The <code>&lt;base&gt;</code> tag in HTML'
</script>

### How I open links

I almost always open links in a new tab.
Be it with primary click while holding down <kbd>ctrl</kbd>;
or as I do nowadays with a middle click emulated by the scroll
wheel or a three-finger tap on the touchpad. That was a long
sentence that I most certainly could have framed better.

### Does everyone else open links like this?

I have no idea. I know my mother uses the secondary-click &rarr;
open in new tab flow. But I have not watched a lot of other people
use their computers.

Maybe I should start watching people who code stream and observe.

### What do I want links to do?

When I have an `<a>` tag in my site, during the initial stages
of making this blog I thought

> I want all links to always have `target=_blank`

But now I am wiser. I know that
1. I want links embedded in my post to have `_blank` as their target
2. I want navigational links to targe `_self`

Today I discovered that it may be possible to achieve this using
HTML!

### What's a blog post by me without a long and unnecessary tangent?

I was trying to think of a semantic tag that I could use to group
a set of action buttons in my website's header. Normally elements
in a header are grouped using `<nav`. But I wanted to use buttons
for print and contact. And neither was destined to be a navigation.

I could think of `<section>` but it did not seem right. Maybe I
should just use a `<div>`. Nonetheless, I was on mdn <3 &mdash;
[the Mozilla Developer Network Web Docs](https://developer.mozilla.org)
verifying the semantics of the section tag. Then I had the idea
of looking at all tags. So I went to the
[HTML Elements Reference](https://developer.mozilla.org/en-US/docs/Web/HTML/Element)

#### Breadcrumbs: A tangent from the tangent

![breadcrumbs on the MDN page leading to the section tag's page]({{-page.images[0] | relative_url-}})

The feature that many sites have started to adopt to show the logical
path in the website that leads to the current page. I learnt recently
it's called "breadcrumbs." Such a cute name. I forget where I learnt
it from. This is what I get for not writing my "diary" regulary.

Also props to Google Chrome's DevTools finally introducing node
screenshots. Makes things a bit easier while writing pieces like
this.

### The `<base>` tag

While perusing the list of elements, I chanced upon the base tag.
I had never heard of it before. Opening the [MDN reference page for
`<base>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base)
I find out it's used to specify a canonical uri that serves as the
base for relative uris within the page.

But it can also be used to define the default `target` behaviour for anchors
that do not have anything specified.

This exactly what I wanted!

### But

But the `target` defined using base does not differentiate between
internal navigation and external embeds. So everything opens in a new
context :(

Maybe this isn't the right solution. But it was a fun discovery!

### Other news

#### Getting better at vim

I use vim as my main editor most of the time. And I recently watched
a set of videos on YouTube by The Primeagen&mdash;
[_"Vim as your editor"_](https://youtube.com/playlist?list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R).
And I have got three videos in and started to use some of the tricks.
Slowly incorporating it into my work.

The `F` command has been useful. I used to keep doing `f` and `,` to
go search backwards in the line to jump. Horizontal movement. It was
not until recently that I even started using the `f` command. Used to
`hl` like a caveperson.

Also discovered `:set relativenumber` from the videos. So I am
also trying to use relative vertical movements instead of smashing
down on `jk`. I even added it to my `~/.vimrc`. I have not got
around to using it as effectively as I would like. But baby steps, right?

