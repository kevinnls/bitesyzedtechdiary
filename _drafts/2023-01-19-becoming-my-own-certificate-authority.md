---
description: I dabble with signing TLS certificates for home web services
# image:
  # path:
  # alt:
---

I have deployed quite a few websites and I know the importance of TLS certificates.
But I hardly ever have to do the work myself.

TLS certificates are handled by GitHub Pages, or Netlify where I usually host my static
sites. And for the few web services I selfhost on a cloud server, I use
[nginx-proxy](https://github.com/nginx-proxy/nginx-proxy){: target="\_blank" }
with its companion service for
requesting and installing certificates from [letsencrypt.org](https://letsencrypt.org){: target="\_blank" }.

I had a vague idea of how to generate self-signed certificates using
[`openssl`](https://openssl.org){: target="\_blank" }. But my understanding was so vague that I
had to refer to some guide online each time.

And the complexity of generating self-signed certificates is complemented by the fact that they are
not trusted by most clients due to the abscence of signatures from a known and trusted
**Certificate Authority**.

And so began my journey to become my own certificate authority.

## What I Already Know

### HTTP
The hyper-text transfer protocol is at the application layer of communications that make
up the world wide web &ndash; the web. It is built on top of
<abbr title="transmission control protocol">TCP</abbr> and <abbr title="internet protocol">IP</abbr>

### HTTPS
The secure version of HTTP uses transport layer security &ndash; TLS &ndash; to encrypt the data packets
that are being trasmitted. This ensures that nobody other than the client and server will understand
the messages being exchanged between themselves.

### TLS
A layer between TCP and HTTP for encrypting HTTP packets. It is deployed by installing _something_ to
your webserver. I almost always use nginx, so to me that meant saving a certificate file, and a key file
and configuring nginx webservers to use them. This meant specifying the `ssl_certificate` and
`ssl_certificat_key` directives in the nginx configurations.

### Generating the TLS certificate
I have had to keep referring back to online guides to get this done.
```
openssl req -new -x509 \
    -newkey rsa:4096 \
    -nodes -sha256 \
    -days 365 \
    -keyout key.pem \
    -out cert.pem
```

And this gave me two files &ndash; a certificate and a key &ndash; that I could install on my server.

### Trusting on the client
Open client, normally my browser, settings and import `cert.pem` from
the previous step. On my android phone, I install the certificate
system-wide.

## What I Want Now

I wanted to improve my setup in the following ways

* use ecliptic curve keys; that are supposedly faster and also more secure

* be a certificate authority; to avoid trusting new certificates each time

## Getting To What I need

### The importance of the key
My understanding thus far of most cryptographic operations had been vague.
But now, I finally realised the private key was the more basic element from
which the certificate was derived.

I had come to the realise that the private key is also the encryption key. In
retrospect, that is quite obvious! I just had not thought enough about what I
was doing.

The private key is used to encrypt data. But first, I sign a certificate with it.
Then I get it signed by an authority so my certificate is proven as trustworthy.

And there is usually a verification step to show that I do control the domain name
in the certificate.

### Ecliptic Curve key
Trudging through the documentation, I did not really fully understand, but I found
an example in the manpage `openssl-genpkey(1)`.

```
openssl genpkey \
    -out privkey.pem \
    -algorithm EC \
    -pkeyopt ec_paramgen_curve:P-384 \
    -pkeyopt ec_param_enc:named_curve
```

Going a bit further, I added the `-aes256` flag to encrypt the key output.
The password was collected in the openssl prompts.

### Becoming the certificate authority
Turns out becoming a certificate authority is pretty simple. I just had to
create a self-signed certificate with they key I wanted to use. And then
use the same certificate to sign other certificates.

```
openssl req -x509 \
    -key privkey.pem \
    -out CAcert.pem \
    -sha512 -days 365
```

`openssl-req` is the subcommand to generate certificate requests (more on that later),
but combined with the `-x509` flag, it generates self-signed certificates. I do not
need to specify `-new` as I did before because it is implied when used with x509.

So now that I had a satisfactory certificate linked to an ecliptic key, I
installed it on my devices.

### Certificate signing request
Until now, I had only made certificates that were signed by the key. But now
that I wanted to have it signed by a certificate authority, I had to generate
<abbr title="certificate signing requests">CSRs</abbr>. These are created
using the same command as self-signed certificates with the `-new` instead of
the `-x509` flag.

First I generate a new private key - using an ecliptic curve! Then a CSR using
the key.

```
openssl req -new \
    -key domainkey.pem \
    -out domain.csr \
    -sha512 -days 365
```

### Authoritatively signed certificates
Now to use the original key `privkey.pem` and its certificate
to sign the CSR and generate a new trusted certificate for the
domain.

```
openssl x509 -req \
    -out domaincert.pem \
    -in domain.csr \
    -CA CAcert.pem -CAkey privkey.pem \
    -sha512 -days 365
```

and done!

***

I now have a domaincert.pem and a domainkey.pem that I can use to set up https on
my self-hosted webservers. And I also have a CAcert.pem that I can install on my
devices to trust the current and future domain certificates.
