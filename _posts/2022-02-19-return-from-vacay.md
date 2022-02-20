---
images:
  - "/assets/post-img/2022/02/19-001-win11settingssearchkeyboard.png"
  - "/assets/post-img/2022/02/19-002-langandregion.png"
  - "/assets/post-img/2022/02/19-003-typing.png"
  - "/assets/post-img/2022/02/19-004-language.png"
  - "/assets/post-img/2022/02/19-005-switcher.png"
---

After a week of voyaging, I return!

### Remote Flutter

Putting to the test
[what I understood last time about SSH port forwarding]({{site.baseurl}}{% post_url 2022-02-10-creation-log-003 %}#sshs-port-forwarding)
, I built and "ran" a flutter app on my remote server with my physical phone
connected to my laptop wirelessly via adb as the target device.

This is a case for remote forwarding. Because requests to a remote port are
being forwarded to the local one.

### Cleaning up

To set up flutter, I decided I needed to clean up some space. I used
[a trick published on LinuxHandboox](https://linuxhandbook.com/docker-disk-space-usage/)
that I'd read during the voyaging

```
docker system df
```

But it didn't work. Some filesystem errors, but nonetheless I could use

```
docker system prune -a
```

that I discovered from some googling troubleshooting.

### That `-` file

I was also cleaning out the home directory in my
[Termux](https://termux.com/) environment and as
[tweeted today](https://twitter.com/kevinnlsamuel/status/1495163310827884546)
chanced upon a file named
`-`. Just that. A literal hyphen.

What file is this? To answer as is second nature I ran

```console
cat -
```

But that did nothing because `cat` interprets `-` as `/dev/stdin` and
the standard input is empty, but there's no `EOF` so the cursor just
moves to the other line and stares at me.

Okay let's do the pro move and use

```console
file -
```

Oh. `file` also interprets it as stdin. And I was thinking not enough
Linux apps interpret `-` as stdin.

In the end, I figured it out with some
[fancy command line foo](https://twitter.com/kevinnlsamuel/status/1495164996917026819)

```console
cat < -
cat < - | file -
```

Nonetheless it's not sane to name a file starting with `-` (or just that)
anyway. I'm pretty sure this happened by accident where I had tried to
write to stdin but that particular command did not interpret `-` as stdin
but rather as a filename and voilà ... or oops?

### Windows and keyboards

I had to write quite a few mails in French. Normally I would switch to
a US International keyboard with <kbd>WinKey</kbd> + <kbd>Space</kbd>.
But this time I felt like I did want to use the **verily French** AZERTY
layout.

So... now I get to go through confusing and unintuitive settings in
Windows 11. Sure Windows 11 has a lot of cool things; but not all of
the settings experience is fully polished; not yet at least.

A search for "keyboard" in Windows Settings looks quite promising

![ screenshot of Windows settings search ]({{ page.images[0] | relative_url }})

A result saying

> Edit keyboard and language settings

That's exactly what I'm looking for!

And now in the new screen I see it makes sense to choose the option
called **Typing**, right?

![screenshot of Region and Language settings page; Typing menu item highlighted]({{ page.images[1] | relative_url }})

Oh look! **THIS** should be the one, right? It says

> Region and Language
>
> <small>Language packs, regional format</small>

![screenshot of Typing settings page; Language & Region menu item highlighted]({{ page.images[2] | relative_url }})

I just came back to where I started. The **Language and Region** settings
page.

<big> **Grrr.** </big>

Turns out you're supposed to open a language from the... **Language** section
and add a keyboard. Or just add a language like I did and automatically get
the default keyboard of that language

![screenshot of Language & Region Page; cropped to show Language section]({{ page.images[3] | relative_url }})

But that does not explain how I have two languages not in the list, each
with their own keyboard layout show up when I open my Keyboard Layout
switcher.

![screenshot of language switcher popup with extra layouts highlighted]({{ page.images[4] | relative_url }})

Not today. I have work to do, so I do.

> what a good thing a diary is!
>
> <small>(Don't tell my mother I said this.)</small>
>
> I referred back to recall how I managed
> to make `post_url` work.
