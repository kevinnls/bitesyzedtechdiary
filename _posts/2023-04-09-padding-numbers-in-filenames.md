---
description: |
  file1.txt
  file100.txt
  file2.txt
  &hellip; is hardly ordered and regular. So pattern&#8209;match&#8209;pad&#8209;replace.
# image:
  # path:
  # alt:
---

## TL;DR

```shell
for name in *.txt; do
    mv "${name}" \
      "${name/(#b)(<->)/${(l:3::0:)match}}"
done
```

## Numbered filenames without padding

Filenames with numbers in them are not uncommon. But sorting them always
has an unexpected conclusion.

```
file1.txt
file100.txt
file2.txt
file200.txt
```

This is because sorting is an operation based on individual
character codes rather than words or numbers which are both
strings of characters (or digits).

## Pad it

The well&#8209;known solution is to rename the files such that
the numbers are all of the same length. So if the numbers
go from 1 to 100, all the numbers have to be three digits
long

```
file001.txt
file002.txt
file100.txt
file200.txt
```

But that's a slow process, so obviously one has to do it
faster

## Pad it programmatically

> **NB** These are instructions for zsh and most likely will
> not work in other shells

Hence the expanded parameter
```shell
${name/(#b)(<->)/${l:3::0:)match}}
```
that is broken down.

### substitution
```shell
${name/pattern/replacement}
```
Overall, it is a substituition. `${name}` is the parameter
(assuming `name` holds a filename). zsh will look for
the first occurence of `pattern`
in `name` and replace it with the value of `replacement`.

```console
$ name='John Doe'
$ echo "${name/o/u}"
Juhn Doe
$ echo "${name/oe/onne}"
John Donne
```

### number pattern
The search pattern `(#b)(<->)` has two parts. Let's first look at the
`<->`.

`<n-m>` is a glob pattern in zsh to indicate a range of numbers&mdash;
not digit characters. This is useful because the more common `[0-9]`
pattern only matches one digit. But numbers in filenames are longer.

The pattern `<->` is shorthand to mean any number.

```console
$ name='May 1968'
$ echo "${name/<->/XXXX}"
May XXXX
```

Once the shell option `extendedglob` is enabled in zsh, the other part `(#b)`
enables back-referencing for all subsequent patterns
enclosed in parantheses. Back-referencing stores the matched pattern in a
variable called `match`.

Hence `(#b)(<->)` finds a number and then stores it in a variable called
`match`.

### padded replacement
The `${(l:3::0:)match}` which is used as the replacement in the main expansion
is essentially `${match}`&mdash;the matched number from earlier&mdash;with a
qualifier enclosed in parentheses.

The `(l:3::0:)` qualifier to a parameter pads the paramater to 3 characters on the left
with the character 0.

`(l:3:)` would truncate or pad a parameter as needed to make it three characters long.
By default, padding is done using blank spaces, but in `::0` we specify to use zeros.

## pattern&#8209;match&#8209;pad&#8209;replace

Bringing it all together, we have
`${name/(#b)(<->)/${(l:3::0:)name}}` in a for-loop


