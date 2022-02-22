---
title: Migrating to Nextcloud fpm
images:
  - "/assets/post-img/2022/02/21-000-win11-cloud-sync-ui.png"
---

### Existing Nextcloud setup

I've had my own Nextcloud instance for almost half a year now hosted off
a [Linode](https://linode.com) running a Docker container based on the
[Nextcloud Apache image](https://hub.docker.com/_/nextcloud#:~:text=of%20the%20container.-,Using%20the%20apache%20image,-The%20apache%20image).

And for SSL encryption, because duh this isn't the early 2000s, I used the
[three-container setup](https://github.com/nginx-proxy/acme-companion/blob/main/docs/Advanced-usage.md)
of [nginx-proxy](https://github.com/nginx-proxy/)'s
dockergen and acme-companion with the
[alpine edition of nginx](https://hub.docker.com/_/nginx#:~:text=the%20perl%20module.-,nginx%3A%3Cversion%3E%2Dalpine,-This%20image%20is)
as my public-facing reverse proxy.

A very dockerised setup. And well-encrypted.

### Nextcloud's https complaints

But whenever I tried to connect to my Nextcloud server using the Desktop
client, it refused saying there was no https. I thought it was just because
the Apache container that's behind the proxy wasn't using ssl.

### Possible solution?

I surmised that using the fpm image of Nextcloud would solve it because
I could set that up with ssl easily. But I was horribly wrong. In my defense,
I ~~had~~ have no idea how or what fpms are.

Today I decided I would fix the https prompt using fpm. I just followed
[the example](https://github.com/nextcloud/docker/tree/master/.examples/docker-compose/with-nginx-proxy/postgres/fpm)
from the official documentation in a test environment. (safe practices, haha).
But the desktop client was still rejecting it with the same reason.
So I just googled it.

### Working solution!

A little bit of browsing told me to set the `overwriteprotocol` in
`config.php` to `https`.

```php
//...
  'overwriteprotocol' => 'https',
//...
```

I tested it and now the desktop client was happy to
connect to my testing instance.

### Fix and migrate

I could have changed just that in my production setup. But
I had already tried fpm in a test environment. So now I knew how to
create a suitable compose configuration!
I went ahead and updated my production
compose file to use the `nextcloud:fpm-alpine` image.

Here's the excerpt

```yaml
services:
  # ...
  # redacted and simplified
  nextcloudfpm:
    image: nextcloud:fpm-alpine
    volumes:
      - nextcloud:/var/www/html
    environment:
      # only works on new containers
      - "NEXTCLOUD_OVERWRITEPROTOCOL=https"

  nextcloud:
    image: nginx:alpine
    depends_on: ["nextcloudfpm"] # optional
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - nextcloud:/var/www/html
  # ...
```

`./nginx.conf` is just a
[copy from the official example](https://github.com/nextcloud/docker/blob/master/.examples/docker-compose/with-nginx-proxy/postgres/fpm/web/nginx.conf)
(I sure hope the link doesn't break)

And used `vi` (because I'm a pro) to update the `config.php` file

```console
$ docker compose exec <nextcloud-service-name> vi /var/www/html/config/config.php
```

But no, that just broke the **entire instance**!

### Fix migrate

> plis notice my wordplay in the headings. thx.

To be more accurate, my migration wasn't working. It was not the change
to the Nextcloud configuration file. It was a file ownership issue.

The `nextcloud:apache` images set the ownership of all the assets under
`/var/www/html` to uid `33`; but `nextcloud:fpm*` uses uid `82`.

> they are both named `www-data` in the respective containers

While the container had automatically changed the ownership for most files,
some were still owned by `33`.

Of course I found this after some tinkering and poking around and
experimenting. It wasn't magical.

```console
$ # safety first
$ docker compose exec <nextcloud-fpm-service> php occ maintenance:mode --on

$ # change owner to www-data (uid 82 on nextcloud:fpm*)
$ docker compose exec <nextcloud-fpm-service> chown www-data -R ./

$ docker compose exec <nextcloud-fpm-service> php occ maintenance:mode --off
```

### Connect from desktop ... and WOW :exploding_head:

I connected it successfully, but that's not the cool part!
The cool part is
[Window's Cloud Sync Engine](https://docs.microsoft.com/en-us/windows/win32/cfapi/build-a-cloud-file-sync-engine)!

It has support for keeping files only online or both online and offline.
And also control it directly in Windows Explorer!
(bonus improvement with Win11's new UI design)

![screenshot of Windows Explorer UI showing cloud sync control menu items and status icon]({{ page.images[0] | relative_url }})

This is a very different experience from 2016 Google Drive sync that
saved it in both locally and remotely. The primary reason I wanted to use
only WebDAV and not the client. But WebDAV had been problematic and I
couldn't use it at work, but a portable Nextcloud client seemed possible.

I am honestly very impressed with Windows having the feature. And extremely
happy that
[Nextcloud decided to tap into the feature](https://nextcloud.com/blog/nextcloud-desktop-client-3-2-with-status-feature-and-virtual-files-available-now/).
(Something I feel they don't do in their other platforms as much).

It was so exciting I even
[live tweeted it.](https://twitter.com/kevinnlsamuel/status/1495870494863724554)
I normally don't really appreciate Windows all that much, but gotta give
credit where it's due. Some things are becoming better and better in
Windows.

Admittedly, this is also visible in the OneDrive folder while enabled. But
I am not going to be creating "online only" files, so didn't really notice.
