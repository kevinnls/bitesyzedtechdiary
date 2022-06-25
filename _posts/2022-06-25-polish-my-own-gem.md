---
layout: post_extended
description: >
    I fork and build my own
    Docker image for GitHub Pages using GitHub's resources
---

and deny that I took another break

### GitHub Pages and Jekyll

This blog has been hosted on
[GitHub Pages](https://pages.github.com)
from the very beginning. Pages is the free
static-hosting offered by GitHub.

It was Pages that introduced me to
[Jekyll](https://jekyllrb.com) &ndash; a
static site generator that runs on Ruby.
And I have since had a soft spot for Jekyll.
I would use it anywhere I could.

I find it easy to use and understand.
The major factor for me is possibly the
direct relation between source file and html.
Something I had not seen in the
Javascript-frameworks I had experienced until
then. Abstractations frighten me. Well, some
of them. I have no knowledge in Ruby after all.

### Local Development

As I write the posts in watch them rendered
in my browser using Jekyll's server&mdash;
`jekyll serve`.

But I don't like installing development
dependencies to my host operating systems
so I run Jekyll in a Docker container.

Long ago, I used the
[`jekyll/jekyll`](https://hub.docker.com/r/jekyll/jekyll)
image. Took a lot of fiddling and customising
to get it to work the way I wanted (cannot
remember why). But I had evenually
discovered GitHub published its own
[Docker image for GitHub Pages](https://github.com/github/pages-gem/pkgs/container/pages-gem).
This image used the correct gem (ruby module)
and installed all the other dependencies too.

Just one problem. It was **HUGE**. Sizes beyond
a gigabyte. Something I did not prefer.

They did have a Dockerfile for Alpine images.
But they just never built or published it.

#### Local Development on a Pi

And another hitch I ran into was when I ran
the server off my Rapsberry Pi, a computer
running Linux on the ARM architecture.

The image &ndash; the whole gigabyte of it
&ndash; downloaded without complaints. But
in the end it wouldn't run because it was
not the supported architecture. Well that
was disappointing.

### New Images from the Gem

So I forked and cloned the entire
[repository for the Pages gem and image](https://github.com/github/pages-gem).

It had a Makefile with a defined target
`image_alpine`

But I didn't want to have to clone the entire
repo each time on each system I needed the
image. Not even a shallow clone. I really
don't like downloading development things
I don't need.

So I took it upon myself to use GitHub Actions&mdash;the
CI/CD service offerred by them and build
and publish the Alpine image for myself.

The original repo already had some configuration
for this since that was how the images were built
upstream too.

After 16 commits and lots of failed builds I finally
got the images I needed building automatically on
[my fork](https://github.com/kevinnls/pages-gem)
using GitHub's infrastructure.

### Thoughts on GitHub

But with all this, it certainly does seem like
I am locking myself to the vendor (read Microsoft).
Hosting my code, my site, building my images,
publishing my images. Everything on GitHub.

But I am not necessarily a fan of the platform.
At least not as much as I used to be.

The recent questions of ethics that have been raised
with GitHub charging for their Co-Pilot service
is a minor reason for it. I also find the Actions
platform rather complicated. GitLab CI was quite
simpler. But I do enjoy that the yaml files are
in a subdirectory and that I can have more than one,
something GitLab doesn't seem to support.

I do enjoy that they have a CLI app. But I have
been using it less and less. And overall
GitHub does feel less refined and more cluttered
that it used to be when I started using it.

I do plan to eventually go completely self-hosted
for my own repositories. But that's a way off in
the future. Until then, GitHub it is.
