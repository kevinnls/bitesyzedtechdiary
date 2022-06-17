---

description: >
  I test my outside-computer setup
  in drafting and publishing this
  post
---

[ext]: https://chrome.google.com/webstore/detail/secure-shell/iodihamcpbpeioajjeobimgagajmlibd

> {{ page.description }}

My main computing machine has been a laptop
for a long time. And it being a portable
machine, I did use it outside and inside the
house, at least&mdash;before 2020, I did.

Now I cannot fathom bringing my laptop that
has sat on some table in a public space
back to my bed. Yes my bed is workspace.

### An outside computing setup

So I had been thinking of having a secondary
laptop, one for "using outside only". A
Chromebook is often pretty inexpensive. And
I could safely do most of my work in a terminal
ssh-ing into my remote server! No sweat.

Whatever people may say against Chromebooks, I
absolutely enjoyed my experience while I used
it on a daily basis. It was snappy and lasted
long hours per charge and it charged over USB-C!

Most work I did was on a browser. And when I needed
a real Linux environment, I could just login to my
server using ssh via the
[client distributed by Google as a Chrome extension.][ext]
In a pinch, I could have also just used Crostini. But
having very little storage and working with Docker
containers was not very appealing to me. There was also
the battery drain to consider.

So a Chromebook was definitely a viable option
for me.

Another option I had in mind was a MacBook Air.
But I eventually changed my mind because I realised
I was looking for a convertible after all.

### Uh-oh thr's a problm

In my existing Chromebook,
many of the keys&mdash;notably **e** would not work at all.

Well not an issue, I was thinking of buying a new
one anyway&hellip; But this made me wonder&hellip;

Do I really need **another** laptop?

### What kind of work do I do?

- I browse the web.
- I sometimes write code.
- I do system administration via ssh.
- I write emails.
- And I write in general using Google Docs.
- When I do make spreadsheets, I use Google Sheets.

### When do I feel the need for a laptop outside?

- When a website is not optimised for mobile
- When I want a physical keyboard because I
  don't enjoy typing on a software one.

Apparently, I said that before

<blockquote class="twitter-tweet"
data-dnt="true"
data-theme="dark"><p lang="en" dir="ltr">
every time i feel the need for a laptop outside,
i&#39;m either craving the feel of physical keys
or just hoping to avoid the pain of browsing a web
un-optimised for smaller displays</p>
&mdash; Kevin Samuel (@kevinnlsamuel)
<a href="https://twitter.com/kevinnlsamuel/status/1526500357907660806?ref_src=twsrc%5Etfw">
May 17, 2022</a></blockquote>

### So what I really need is&hellip;

A physical keyboard that I can connect to
my phone and a larger display.

That should solve my problems, right?

### Experiments and baby steps

The first step was procuring a keyboard. A mouse
was optional, and the bigger screen could wait.

Oh when I said bigger screen I was thinking
of a foldable. No mobile display by itself
would be big enough to render broken websites
comfortable.

#### Testing existing keyboard

I already had a keyboard that could connect
to my phone. A
[Logitech K480 bluetooth keyboard](https://www.logitech.com/products/keyboards/k480-multi-device-wireless.html).
Viewing angle of the phone in its dedicated slot
was comfortable. And typing was decent enough.
A bit noisy, but not enough to bother me.
And the keyboard has enough heft to it that I
could easily use the keyboard on my lap with the
phone in its slot and type away without any
real issue. Except&hellips;

#### Android and physical keyboards

A lot of Android apps are simply never developed
with the physcial keyboard in mind. They are
justified because after all, Android is mostly
used as a touch-only operating system. But this
meant that a lot of apps didn't have great
keyboard support.

WhatsApp was especially painful because now I had
to enable "enter is send" because there was no
other mechanism to send text messages (I was
hoping for <kbd>ctrl</kbd> + <kbd>enter</kbd>).

But enabling that option meant I could no longer
draft multi-line messages.

Navigation with a keyboard is even more painful
<kbd>alt</kbd> + <kbd>tab</kbd> brings up the
Recent Apps screen, but doesn't allow switching
between apps. And the arrow keys often mean
nothing.

Chrome, and Google Docs on the other hand worked
really well. They even supported common keyboard
shortcuts that I would often use.
- In Chrome for Android
  - <kbd>ctrl</kbd> + <kbd>tab</kbd>
  - <kbd>ctrl</kbd> + <kbd>r</kbd>
  - <kbd>ctrl</kbd> + <kbd>t</kbd>
  - <kbd>ctrl</kbd> + <kbd>l</kbd>
- In Google Docs for Android
  - <kbd>ctrl</kbd> + <kbd>b/u/i</kbd>
  - <kbd>ctrl</kbd> + <kbd>alt</kbd> + <kbd>0&hellip;6</kbd>
- In Android, the operating system
  - <kbd>ctrl</kbd> + <kbd>a</kbd>
  - <kbd>ctrl</kbd> + <kbd>x/c/v</kbd>
  - <kbd>ctrl</kbd> + <kbd>backspace/delete</kbd>
  - <kbd>ctrl</kbd> + <kbd>arrow keys</kbd>

While that's not an exhaustive list, it is a list
of my most commonly used shortcuts.

And while I couldn't use <kbd>alt</kbd> + <kbd>tab</kbd>
I could at least double tap my keyboard's "menu" key
to switch to the last app instantly.

#### A different keyboard

Hoping to reduce the weight of my backpack, I was
browsing for lighter bluetooth keyboards from Logitech.
And the one I eventually picked and purchased was
not good enough. The slot for the phone did not
inspire confidence. I even managed to drop my phone
twice while using it with the keyboard.

And that is how the K480 became the first part of
my outdoor computing setup.


### Software and how I code now

This entire post so far has been written using my phone
with the K480!

I logged into my remote server using [Termux, a terminal
emulator for android](https://termux.dev/) with
[mosh, the mobile shell](https://mosh.org/).

And as I have been writing blogs since returning from the
break, I am typing in good old [vim](https://www.vim.org/).

Unfortunately, Termux isn't supporting <kbd>ctrl</kbd> +
 <kbd>shift</kbd> + <kbd>v</kbd>. So to paste the links I
have created so far, I had to reach forward and long press
the screen to paste.

<small>I suppose this may be one of my first
"real" open source contributions to an Android app.
Should be easy enough to implement, right?</small>

To check that the page is rendered as expected, I quickly
spun up a docker container behind my proxy on a subdomain
in my domain. Shout out to
[nginx-proxy](https://github.com/nginx-proxy/nginx-proxy)
for making that such an easy thing to do!

### Gripes

- Lack of support from the OS and the apps
  - Navigation
  - Some pretty basic functionality
- I need to take the cover off my phone to make it fit the slot
  - But then with a foldable, cover who? So might as well live
    with it.
- Couldn't hot reload Jekyll pages because nginx-proxy can proxy
  only one port by default.

Honestly, that's it. I have been working just fine.
