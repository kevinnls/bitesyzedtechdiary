---
title: Python can do that???
---

### It all started with a tweet

Browsing through Twitter I came across a
[particular tweet](https://twitter.com/svpino/status/1490385489601257472)
today. It was a simple expression in Python, accompanied by a challenge to
guess its evaluated result.

```python
False == False in [False]
```

Although I didn't get it at first, after a little bit of strenous staring
I decided that it was `False`, or `True` I can no longer recall.

The answer is `True` though. If you're confused
(I'm looking at you, future me) pay attention to the order of precedence.

### Led to discord

It was interesting, so I shared the tweet with a discord server of coding
comrades. There, the Python specialist of the troupe posed a challenge
of their own.

```python
if False == False is [False,True]: print("4")
else: print("5")
```

While I knew the result was `4`, I remarked that it would be syntactically
incorrect since the body blocks were not indented (nor line broken).

### And I had remarked wrong!

Having dabbled very little with Python, I only
knew that indents were strict, not that a single body statement could be
written in the same line!

### Anoth...er discovery

Also turns out, Python has truthy and falsey values. I for some reason had
been thinking it was unique to JavaScript as it was among the first things
I learnt.

With some experimentation

```python
if 9: print("it was true ...thy!")
if '.': print("this was also truthy!")
if [1,2,3]: print("trueee")

if 0: print("i am never getting printed")
if '': print("me neither")
if []: print("well will i be printed? no")
```

###### OUTPUT

```output
it was true ...thy!
this was also truthy!
trueee
```

I found out that the rules are mostly similar to JavaScript, except Python
is more sensible in that an empty array evaluates as falsey.

### Looking for stricter booleans

But now I cannot remember anywhere else that has strict booleans. C?

Ah, I have already found an answer (the next day). Empty strings `''` are also evaluated
as true in C. Almost everything except for `0` and `(null)` has evaluated
to true. Although, when I say true, I just mean `if`'s body was executed
since C doesn't have actual booleans.

In experimenting to find this, I have now understood why
schools teach `scanf` instead of `argv`. Data types.
