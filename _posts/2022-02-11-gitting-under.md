---
---

### Under the magical hood of `.git`

Today's [Computerphile video](https://youtu.be/bSA91XTzeuA)
on the inner workings of a git repository has been enlightening. A little
enlightening. It was pretty basic to me, but I am really glad I have learnt
about the different types of objects in git.

- commit
- tree
- blob

Also cool learning the `cat-file` command (with `-t` and `-p`).

```terminal
# get current commit id/hash
git describe --always

git cat-file -t <commit hash>
# => commit

git cat-file -p <commit hash>
# => commit tree object hash, commit parent, committer details, signature

git cat-file -p <tree object hash>
# => list of "blobs" and child trees with their object hashes
```

Turns out all objects are compressed versions of the orignal. And the
compression algorithm(standard ?) is zlib, or so was said in the vid.

I don't have a very clear or deep understanding of how git works, but
it's a start!
