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

And this gave me two files that I could install to my server.

### Trusting on the client
Open client, normally my browser, settings and import `cert.pem` from
the previous step. On my android phone, I install the certificate
system-wide.


```
openssl genpkey \
    -out privkey.pem \
    -algorithm EC \
    -pkeyopt ec_paramgen_curve:P-384 \
    -pkeyopt ec_param_enc:named_curve
```

