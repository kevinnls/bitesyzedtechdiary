---
description: >
    Thank you to Wireguard VPN
    for making this blog possible.
title: Exposing to the Internet using VPN
# image:
  # path:
  # alt:
---
Given all the false advertising around virtual private networks
(VPNs), it sounds counter-intuitive that the same thing would
be used to "expose" something to the internet.

But not all VPN advertising is fake, and some aspects of it
are rather useful&mdash;in ways that are not often portrayed by
VPN providers.

[Skip the ranting tangent](#using-vpn-to-expose-the-home-network) (Not recommended)

### What is a VPN?

In essence, it is exactly what it says. A private network that
is virtual.

#### What is a network?

Connection between two more devices. In the context of the
internet, the connection is usually established using
- copper cables
- radio waves
- fiber optic cables

#### A virtual nework?

In computing, virtual refers to hardware that does not
exist physically. It is existing hardware
but in software it appears as a device that is distinct
from what exists physically.

A now common example is virtualised CPUs. A physical CPU
that has sixteen cores can be presented in software as two CPUs
with eight cores each.

Likewise, virtual networks use the existing network hardware
but appear as a completely separate network in software.

#### So a Virutal Private Network?

To be fair, a lot of networks are private in that they cannot be
accessed by members who are not directly connected to the network.
Every home router of today sets up a LAN&mdash;local area network.
And only the devices connected directly to the router can access
resources on the network (printers, other computers, etc.)

Normally such networks are restricted and no other computer from the
internet is allowed access. While it is possible to open the network
to others on the internet, it poses the security risk of unauthorised
access.

Instead, by using virtualised networks one can allow access to
certain devices on a network while using the existing hardware of
the internet. Such networks, at least the modern implementations,
typically use more secure ways to communicate and authenticate
devices to one another.

### Consumer VPNs

> XXXXX VPN encrypts and routes your network through our secure
> servers in N global locations&hellip;

It's exactly what it says. Instead of joining the virtual network
to access other devices on it, all connections to the internet
are made through only one device of the network.

And so,
- the internet service provider sees a lot of requests
to XXXXX VPN's server
  - but not the actual site that you visit
- The site that you visit sees a lot of requests from the XXXXX
VPN server
  - but not from your actual device/IP address

This functionality is **proxying** &ndash; communication between
two devices via an intermediary called a proxy.

It could be sort of anonymous. But VPN services are obliged to
log and share logs with government authorities in some countries.
And if the site has a way for users to login (as do most
common ones today) the site knows who it is, just not your
actual location, unless it already had access to device location
and does not rely on IP address for locating in the first place.

The service offerred by majority of consumer VPN providers is
essentially a web proxy. While they offer partial
anonymitiy, it really depends on how it is being used.
It irks me that advertising today makes it look like an
all in one solution.

> &hellip;allowing you to access geo-restricted content&hellip;

This is possibly the only real use for most consummer VPN services.
And luckily, a lot more advertising is stressing on this more
than the "encryption" and "anonymity" that they offer. Hurray! 🎊

Perhaps this [Tom Scott video on VPN advertising claims](https://youtu.be/WVDQEoe6ZWY)
from 2019 shifted the industry. Notably later on in 2022, Tom Scott himself
[concedes that VPNs are useful](https://youtu.be/uAdmzyKagvE?t=351)
in the sponsor segment
of a video. And the conecession was that they
are useful forrr pretending you are visiting
a site from a different country. 🥁

Hah. Vindication.

### Enterprise VPNs

But not all VPNs are the same. Many large organisations deploy
and use their own VPNs to allow their staff access to company
resources from outside the premises. Using a VPN adds a layer
of protection against unauthorised access by keeping the
network private.

### Using VPN to Expose the Home Network

Today is the third day of writing this post, and I have entered
the main topic only now. Will I ever stop wandering?

I run some network-accessible services on a Raspberry Pi 400
on the home network that acts as my "server." It's mostly just
a [Syncthing](https://syncthing.net) instance to handle backup
of my phone's camera folder
and a [Photoprism](https://photoprism.app) instance to view
said backups.

I would expand on it some day. But for now, it's just two
services.

And sometimes, I wished I could access these from outside
home: on my phone, on a 4G connection.

### How does one set that up?

By hosting one's own VPN. Which often requires
having at least one device with a public IP address.

##### OpenVPN

I tried setting up OpenVPN first. But I could not
understand any of what I was doing. I did set up a docker
container based on
[docker.io/kylemann/openvpn](https://hub.docker.com/r/kylemanna/openvpn/){:target="\_blank"}.
But not knowing what I was doing was troubling.

##### Wireguard

Wireguard was supposed to be easier to set up. It's new
and reportedly more secure out of the box.

##### Others

Um&hellip; I didn't check 😅

### Wiring up Wireguard

#### Installation
```
sudo apt update
sudo apt install wireguard-tools
```
It wasn't too bad with Raspbian, eh? Good thing it's based on
Debian 11. I won't be complaining for a while.

#### Education

Then I went to read the documentation. Okay, I did read some
beforehand too. I read the quickstart guides off the official
website.

I understood a little. Then I read the man pages. And I stopped
trying to understand and just started smashing buttons.

Also it has been a week since I started writing this post and
I don't remember what I did.

#### Configuration

I started by using `wg set` but soon realised it wasn't easy.
I somehow figured out `wg-quick`.

Finally found the systemd
service `wg-quick@.service`. So now I had an
`/etc/wireguard/wg0.conf` file to manage my configuration.

Eventually got it setup on two devices. Using the systemd
service. But what I didn't know was that the service had
a `reload` command. I could have used
`systemctl reload wg-quick@wg0`. But I realised it only
much later.

I used a very complicated `wg syncconf <(wg-quick strip wg0)`
that seemed to fail at times

The configuration file itself was simple enough
```ini
[Interface]
Address = 192.168.2.2/31
PrivateKey = RandomKeyThatIsWeirdlyShort

[Peer 1]
PublicKey = AnotherKeyButPublicStyle

[Peer 2]
PublicKey = AnotherKeyButPublicStyle

[Peer n]
PublicKey = AnotherKeyButPublicStyle
```

I had added every single device's public key
to every device's configuration. So every wirguard
instance had the public key of all its peers.

Everything should be working fine, right?


### Wires crossed

Of course not. The 'public key' was not enough to
make a connection. Key exchanges are for authentication.
Wireguard also needs an 'endpoint.'

At first I had expected there to be some kind of
global signalling server that handled this.
Similar to how Syncthing establishes connections
between devices.

Since that did not happen, I tried giving the
private IP address assigned to each interface
as the public endpoint. Of course it didn't
work. But I tried it because one of my peers
had a public IP as its endpoint, so I thought
if all peers connected to said public peer
they should also be able to speak to each
other via the public peer. And since the
public peer would know the internal IPs
I hoped they would suffice as endpoints.

Nope. They did not suffice. IP forwarding
and things were needed. Things I did not
know or understand until&hellip;

### Unofficial WireGuard Documentation to Detangle

I discovered some
[community-created documentation for WireGuard](https://github.com/pirate/wireguard-docs)
and found out that the setup I was going for is called
a "bounce server."

To configure a WireGuard network composed of
a mixture of devices with public and
private IPs, one or more fo the public peers
would be configured as bounce servers.

### A bounce server

So far I configured peers as having an internal
IP address with a 32-bit prefix.
But instead a bounce server has a 24-bit (or
smaller prefix)
```ini
[Interface]
Address = 192.168.2.1/24
```

In doing so, I let wireguard know that the current
peer may receive and forward traffic for other
peers within the same subnet.

A peer that handles connections to the internet
would have a prefix of 0 presumably.

### Connecting to a peer via a bounce server

Normally each peer needs the public key of
every peer it expects to connect to. But
when part of a network that involves a bounce
only the bounce is configured as a peer. I
expect this means the bounce server decrypts
traffic from one peer, then encrypts and
sends it to the next using its own keys.

I am not too concerned by this since I have
complete control over my bounce server. And
also because the alternatives are STUN server
which are more complicated.

### Bounce not forwarding

I had set everything up as I should, and
every peer was connected to the bounce.
But I could not connect from one peer
to the next over the wirguard network.

I decided to try enabling the
`net.ipv4.ip_forward` kernel parameter
that every guide was talking about. But
it was already enabled.

### IRC for help

Seeing no other way to resolve and
get it up and running I went to the
recommended IRC room for help.

Turns out my firewall was blocking IP forwards.
My server, running Fedora, used [firewalld](https://firewalld.org/)&mdash;
the opposite of
<abbr title="reference to ufw&mdash;uncomplicated fire-wall&mdash;the firewall software used by the Ubuntu family">
uncomplicated</abbr>.

It has been a month and half since I started writing this post by the way. I am just going to
get this over with as soon as possible.
