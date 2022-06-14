---
description: I try once more to keep up the supposedly daily journal
image:
  path: /assets/post-img/2022/06/13-000-catchingup.webp
  alt: >
    calendar of march with a big june
    superimposed to indicating the jump
    since the date of most recent post
images:
  000: "/assets/post-img/2022/06/13-000-catchingup.svg"
---

> {{ page.description }}

[Nextcloud]: https://nextcloud.com
[com.opensource-intro-dns]: https://opensource.com/article/17/4/introduction-domain-name-system-dns
[com.opensource-build-dns]: https://opensource.com/article/17/4/build-your-own-name-server
[http203]: https://youtube.com/playlist?list=PLNYkxOF6rcIAKIQFsNbV0JDws_G_bnNo9

## Wow that was a long break...

![calendar of march with a big june superimposed indicating the jump since the date of most recent post]( {{ page.images[0] | relative_url }} )

It's been such a long break that I don't even remember my
own stylistic rules. Should I be capitalising? Do I use
contractions?

Oh wait. It doesn't matter that much anyway, I hardly edit
on this blog.

### Moving forward

while it is tempting to type all lowercase and ignore any
kind of stylistic rules, I have realised that writing for
this blog will make up the most of my touch typing practice.

And so, here we go.

## (Tech) Things I plan to do and write about

- Migrate my mailserver from _Linode_ to _Google Cloud Platform_
- Set up my own DNS server
- Learn Kubernetes
  - Deploy my mailserver, [Nextcloud] instance and other essential
  servers using K8s
- Improve this blog
- Make my server at home accessible _privately_ from the internet
> <small>a wild paradox has appeared!</small>

### Linode ➡ GCP

I have been renting a virtual private server from
[Linode](https://linode.com) for more than a year now, and I love it.
The plain simplicity of a virtual machine with minimal abstractions;
a responsive user interface for configuring the server and
auxillaries like the firewall and the DNS.

On the other hand, I dislike Google Cloud Platform and Amazon Web
Services: the other cloud service providers I have used. I have found
the abstractions extremely annoying and the user interface is just
too slow.

BUT, they do have free tiers and that seems a more sustainable
option for my budget. Hence the possible switch, but...

### Resolve my own Domain Names

I do not want to be locked to any vendor's ecosystem. But having
multiple entries in your domain's name server makes it not
so-easy: GitHub verification, email keys, subdomains!

Should be easy enough to set up my own DNS...right?

So far I have started reading
[an introduction to DNS on Opensource.com][com.opensource-intro-dns].
And will read part two
on [building my own DNS][com.opensource-build-dns] soon after.

The articles use `bind`, _Berkely Internet Name Domain_, as the server
software. But I am considering `[unbound](https://nlnetlabs.nl/projects/unbound/about/)`
based on its being modern. Guess we'll find out eventually!

### K8s for deployments

I have been wanting to learn K8s for way too long. I currently use
`[docker compose](https://docs.docker.com/compose/)` for my deployments.
But having all my containers dev, experiment and production off the same
Docker daemon sounds like a disaster waiting to happen!

I did not really manage to get around to learning K8s fully, but I ought
to learn soon. Should make my migrations easier!

### The blog

Well I have not really got anything big in mind yet. But it is pretty plain.
And I realise I do not really want links to third party websites to be opened
in the same tab. I would prefer setting `target="_blank"`.

But I do not want to break away from using markdown! Maybe the new Navigation
API will help?

The Navigation API that Jake Archibald
([twitter.com/jaffathecake](https://twitter.com/jaffathecake))
has been speaking of a lot recently.

<iframe width="560" height="315"
title="YouTube video player" frameborder="0"
src="https://www.youtube-nocookie.com/embed/cgKUMRPAliw"
allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
allowfullscreen></iframe>

Speaking of, I have been watching a lot of [HTTP203](http203), the podcast/talk show hosted by
Jake Archibald. They have a lot of interesting topics.

Here's another thing to improve, the embed is left aligned. I want it centered, but
I have no idea how.

But I did manage to fix the timezone and enable livereloads. Well they are both improvements
to the development setup, but improvements nonetheless.

### Internet-accessible home network???

🤫 a secret project to be revealed later

<small>aka I don't want to accidentally compromise my home
network's security by sleepily writing a blog post</small>
