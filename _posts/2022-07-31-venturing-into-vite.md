---
title: Venturing into Vite
description: I check out Vite
---

### Why Vite?

Is a section of the official website of the Vite project.
Trying to read it without understanding ESM was what led
me on [the previous rabbit hole, where I checked out
modules]( {{site.baseurl}}{%-post_url 2022-07-27-modules-in-the-browser-and-yaks-%} )

Since then, I am a bit clearer on JavaScript modules
in the browser. And also no longer in the mood to read
so much documentation. Time to dive in blind and figure
it out.

### Initialising a Vite Project

I jumped to the Getting Started section in Vite's homepage
and found the commands to create a Vite project

```
npm create vite@latest
```
or
```
yarn create vite
```

I was using a container based on the
[`docker.io/kevinnls/node-unprivileged` image](
https://hub.docker.com/r/kevinnls/node-unprivileged){: target="\_blank" }
I wrote
(_coughs_&mdash;that **very badly** needs updates and automation)
with a docker-compose spec to mount the project directory to
the correct destination within the container.

So I set these files up before running `yarn create vite .`&hellip;
and the `vite-create` package strongly insisted on removing everything
in `.`.

I thought to myself that I could just restore the files using git
since I had already checked them in. Then I chose a vanill + TypeScript
config for the prject.

Ha. Ha. `create-vite` deleted the `.git`
folder too. This is not a good start.

```console
$ git clone <url>
$ cd <repo>
$ docker compose run --rm dev sh

node@container $ cd <mount point>
node@container $ yarn create vite
node@container $ # chose vanilla + ts
node@container $ mv vite-app/* vite-app/.* .
node@container $ rmdir vite-app
node@container $ exit

$ docker compose up -d
```

Well that was complex. But it did not fix everything

### The container exited immediately

And to debug, I ran it again, duh. And when that did not fix it, I
checked the logs.

The container's command was `yarn run dev` and it could not find
a binary for `vite`. Oh. I did not install any of the packages.

```console
$ docker run --rm dev sh

node@container $ cd <mount point>
node@container $ yarn
node@container $ exit

$ docker compose up -d
```

I had already changed the publish ports to match the server in the
container.

But I still could not access the server from the host.

### Exposing the Vite container's dev server

Turns out the Vite dev server exposes only to localhost (as do most
others) and my command needed the `--host` flag

Modify the compose spec further. New command now `yarn run dev --host`.

### The file tree

I went over the files that were created by `create-vite`.
- #### `package.json`
A `scripts` object was added with the `dev`, `build`, `preview`
commands and the corresponding `vite` commands.

- #### `index.html`
Basic HTML that every JS framework generates. An empty div
to be manipulated later by scripts. And a script that is
imported _as a module_.
I have not really noticed this before. Do all frameworks
use module now?

- #### `tsconfig.json`
TypeScript configuration options that I don't really know anything
about. The only thing that stood out to me was the `include` key
whose value was `["src"]` where the `main.ts` file is saved.

- #### `src/main.ts`
It was just one very big string that got inserted into the container
div. And it calls a setup function definied in another module

- #### `src/counter.ts`
Exports the setup function I mentioned earlier that adds a click
listener on a button that's a counter

> Looks like counters are the demo of every framework

- #### `src/vite-env.d.ts`
No iead what this is. But I don't know enough TS for this to make
sense. Yet.

- #### a bunch of static files
Styles, SVGs. But why are we importing styles into the modules?
I don't know. We don't import it in the `index.html` file I
realised later (as in, just now). I suppose that's part of
the vite magic? Applying CSS through module imports? Or did
I just not realise it was possible?


#### And it serves TypeScript files...?

I saw the imported script file in `index.html` was still `src/main.ts`.
Interesting... At the moment, the browser is not a runtime that
can execute TypeScript (and I don't think it ever will be).

Heading over to `view-source://localhost:8080/src/main.ts` and I read
pure JavaScript. So it's serving a file with `.ts` but it's a JS file.
But browsers wouldn't know what to do with the `.ts` extension&ndash;
oh wait. Browsers don't care about extensions. Only media types.

```console
$ curl localhost:8080/src/main.ts -I
...
Content-Type: application/javascript
...
```
And it's the server that sets the media type. MIME type. That's the
word. I have been writing this for too long. Procrastination. And
I cannot speak nerd anymore.

### So what does Vite do?

It serves the project source. That's it. Well, that's all I know.

