---
title: Modules in the Browser and Yaks
description: >
  Diving deep into the murky
  shallows of the web and shaving yaks
images:
  - /assets/post-img/2022/07/27-001-counter.png
---

### Building websites

So far every website I have ever built was either created using
a JavaScript framework's default tools, Jekyll, or plain
HTML/CSS/JS.

I decided I wanted to learn to build websites using build tools
that I configured myself.
[Vite](https://vitejs.dev) has been the most popular as far as I
know.
So I went to their homepage. The helpful
['Why Vite?'](https://vitejs.dev/guide/why.html) link caught my
attention. Navigating to the next page, I soon lost attention.

I had no idea what 'modules' were. And that is all that the page
was talking about.

### What are modules?

Is the question I embarked to answer. Of course by modules, I
mean ESM&ndash;ECMAScript Modules.

[MDN's article on JavaScript Modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)
is where I begin my journey. To play around with the concepts
I started building a website that was definitely not inspired
by Svelte's tutorial.

It was simple enough. A numeric counter that updates based on
user input. The user is given two buttons: one to increment
the counter and the other to decrement it.

![increment decrement buttons with a counter in the center]({{-page.images[0] | relative_url-}}){: style="border: 2px solid grey; border-radius: 23px;" }

But what's the point of having modules if there's only one thing
done?

### Observing the counter
#### aka `yak-1`
{: style="margin-top: 0px;" }

To keep experimenting with modules, I did add a few `console.log()`
statements because duh. But I also went a bit further and
decided to persist the counter between sessions.

Normally, I would use `localStorage.setItem()` as part of the button's
click event handler. This time I decided to try something different.
Hoping that doing this would not block the main thread, I used the
[MutationObserver](https://developer.mozilla.org/en-US/docs/Web/API/MutationObserver)
API to watch the DOM change and store to localStorage when it does.

Might be better to use a promise or some mechanism to debounce.
But those are things I thought of now; not when I was working on it.

### A Spinner
#### aka `yak-2`
{: style="margin-top: 0px;" }

Because I was storing to localStorage, I had to read from localStorage
on page loads. While the browser storage is fast, it is visible
when the value changes at initial load.

So I wrote a spinner SVG. COMPLETELY BY HAND! Okay I mean manually.

I even added animation! TADA!

<figure style="text-align: center; border: 2px solid grey; border-radius:23px; padding: 2ch;">
<svg width="100px" height="100px" id="spinner" fill="none" viewbox="0 0 11 11">
    <circle stroke="white" stroke-opacity="30%"
	cx="5.5" cy="5.5" r="5"/>
    <path stroke="hotpink" d="
	    M 5.5 .5
	    a 5 5 90 0 1 5 5
	      ">
	<animateTransform attributeName="transform" attributeType="XML"
	    type="rotate"
	    dur="1s" repeatCount="indefinite"
	    from="0 5.5 5.5"
	    to="360 5.5 5.5"/>
    </path>
</svg>
<figcaption>The spinner I manually drew and animated using SVG</figcaption>
</figure>

The inspiration was a recent episode of HTTP203 titled [_"Demystifying SVG Paths"_](https://youtu.be/9qen5CKjUe8)

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">the episode worked! i wrote some SVG manually! 🐢<br>then i forced the user to see it because i wanted to show off</p>&mdash; Kevin Samuel (@kevinnlsamuel) <a href="https://twitter.com/kevinnlsamuel/status/1551932848763985921?ref_src=twsrc%5Etfw">July 26, 2022</a></blockquote>

### I now know modules
#### aka finish shaving `yak-0`
{: style="margin-top: 0px;" }

I realised only while writing this post that my entire journey
learning about modules was a yak shaving trip in itself.

I had started because I wanted to try out Vite&hellip;
