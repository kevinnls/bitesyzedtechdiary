---
title: Logitech Unifying Tech is Cool

description: >
    I finally write the thing I wanted to write a week ago
    about the thing I tried a week ago
#image:
  #path:
  #alt:
images:
  - /assets/post-img/2022/08/10-000-yearsago.png
---

Recently installed Debian+GNOME on the home media computer.
It's an aging first-gen Intel i5 machine typically running Windows.
And controlled using a Logitech mouse and keyboard via bluetooth.

### The Problem with bluetooth peripherals

Bluetooth is not too bad. The connection is quite stable once
connected. But connecting is not always the fun part. And sure
there is probably a little bit of latency. Not one that I can
perceive. I just type, point and click on links. And best of
all, no wires!

The real problem for me is that bluetooth connections are made
at the operating system level.

### Bluetooth and the operating system

I did not actually know that bluetooth was OS-level until I
came across this bit in the Arch Linux wiki (the best Linux docs, ftw)
[about pairing for dual boot](https://wiki.archlinux.org/title/bluetooth#Dual_boot_pairing)

> To pair devices on dual boot setups you need to change the pairing
> keys manually on your Linux install, so that they match in both systems.

Okay to be clear, the connection is done between hardware, obviously.
But the pairing is handled by the operating system. And pairing keys
are linked to the adapters.

#### A tangent explaining bluetooth
> not verified

- Bluetooth is a set of rules for exchanging information between devices
using radio waves
- Every bluetooth-enabled device has an "adapter"&mdash;a device to
transmit and receive said radio waves
- Each adapter has a unique <abbr title="media access control">MAC</abbr> address
to identify itself to other adapters (devices)
- When two devices are being **paired**&mdash;connected for the first time&mdash;they exchange pairing keys
- The operating system stores said key and uses it for future connections

This is not a problem when your bluetooth headsets have only one invisible
operating system; or one phone with one OS. But with a dual boot system,
you need to copy the pairing keys so both OSes share the same keys since
because assuming that the computer shares the bluetooth hardware, the MAC
would be mapped to a specific pairing key on the other device.

GRR.

But this is easily solvable. I do it all the time on my personal laptop
to connect my headphones to both Fedora and Windows.

### The real problem for me

is that I could not switch between OSes without using another keyboard.
I would need to press keys at the GRUB menu to change OSes, but that
would not be possible with a bluetooth keyboard because connections
are OS-level, not at the <abbr title="BIOS/UEFI">firmware</abbr> level.

So GRUB has no way of receiving this input.

### Logitech Unifying

Now I already knew both the multi-device mouse and the multi-device keyboard
supported Logitech's Unifying
receiver and each came with its own tiny one. But I had never used it.

I assumed that connecting or pairing would just be plug and pair. Those are
the kinds of receivers I had used so far. The device came with one dongle
and worked only with that one.

But instead it wanted some *software*??? Oh no. I thought it meant I needed
the software everywhere, and that it would immediately mean no Linux
compatability and definitely not working in firmware.

### StackExchange to the rescue
> Google played a minor role too

Looking up "Logitech Unifying + BIOS" gave me the answer I needed. It *was*
possible to use the the keyboard with the receiver in firmware menus!

I took a look at YouTube also because Logitech has a pretty good stock of
content on their channel. And WOW those videos are OOOLD!

![video listings on Logitech's YouTube channel from thirteen and nine years
before 2022 (2009 and 2013) on the topic of unifying receiver]({{ page.images[0] | relative_url }}){: loading="lazy" }

> This has been around since 2009???

That is so cool!

### Connecting via the Unifying Receiver

Turns out the special software is needed only to make the connection.
The pairing process so to speak. And this time the pairing information
is stored on the receiver itself; not the OS. So it becomes possible to
use it on any system, it just reports itself as a regular old wireless
keyboard and mouse!

I can use it in firmware, GRUB, Linux, Windows. And even on a completely
different computer because now the device is paired with the receiver,
not the computer.

### I am disappointed

That I did not know this before.

