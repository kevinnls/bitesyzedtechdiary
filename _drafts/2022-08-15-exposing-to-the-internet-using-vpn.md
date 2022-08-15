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
are rather useful&mdash;in ways that are not portrayed by
common VPN providers.

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
exist physically. In other words, it is existing hardware
but in software it appears as a device that is distinct
from what exists physically.

A now common example is virtualised CPUs. A physical CPU
that has sixteen cores can be presented in software as two CPUs
with eight cores each.

Likewise, virtual networks use the existing network hardware&ndash;
copper, fiber or radio&ndash;but appear as a completely separate
network in software.

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

By hosting one's own VPN solution. Which often requires
having at least one device with a public IP address.

##### OpenVPN

I tried setting up OpenVPN first. But I could not
understand any of what I was doing. I did set up a docker
container based on [kylemann/openvpn](https://hub.docker.com/r/kylemanna/openvpn/){:target="\_blank"}.
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

#### Configuring

Was basically 
