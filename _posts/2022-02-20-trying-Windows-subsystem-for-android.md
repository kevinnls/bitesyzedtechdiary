---
images:
  - "/assets/post-img/2022/02/20-000-win11-wsa-adb-ip.png"
---

I had seen [tweets](https://twitter.com/itsfoss2/status/1493864923528859648)
about the
[Windows Subsystem for Android](https://docs.microsoft.com/en-us/windows/android/wsa/)
(WSA) quite a few times recently.

> Twitter is the source of all my news, oops?

### Installation and connection

I found
[this guide on Windows Central](https://www.windowscentral.com/how-get-started-android-apps-windows-11)
(probably also from Twitter) and quickly followed the first few steps.
Then I realised I needed to install apps with the
[Android Debug Bridge](https://developer.android.com/studio/command-line/adb)
(adb) since at the moment the Amazon Appstore that's the official store
of WSA has support only in the USA. Luckily the guide linked to their own
[guide for sideloading with adb](https://www.windowscentral.com/how-sideload-android-apps-using-wsa-windows-11)

But it wasn't really very clear. The instructions for connecting were
(on 2022-02-20)

> `adb connect WSA-IP-ADDRESS`
>
> In the command, replace "WSA-IP-ADDRESS" with the actual IP address of
> the Windows Subsystem for Android.
>
> For example, this command connects using the 172.17.114.137 address:
>
> `adb connect 172.17.114.137`

However there's no mention of **how** one could find the IP address. I
scrambled about around the interface. Even if I found the "actual IP
address" of WSA from within the _Developer Options_ menu in the _Settings_
app, I would need to **authorise** the adb connection, but I could not
see the popup anywhere.

Turns out the answer was in Windows' own WSA application screen

![screenshot of WSA application; highlighted text: "ADB can be connected on 127.0.0.1:58526"]({{page.images[0] | relative_url }})

But that's not the IP of the WSA virtual machine. There's some
pre-authorised passthrough from the loopback interface. And Windows did a
good job of making it clear. A bit troublesome if there are no Android apps
running. The IP appears to be assigned only while apps are running,
so maybe open the _Developer Options_ menu from the link to forcefully
assign an IP.

### Praises

- #### It's so snappy!
  It's really very very smooth. I tried [Tachiyomi](https://tachiyomi.org)
  \- one of my alltime favourite opensource apps, a manga reader.

### Mehs

- #### What's the point?
  Even back when the feature was announced as part of Win11's release, I
  wasn't particularly impressed with it. I couldn't think of any real
  advantages. I still cannot. One I _could_ have seen in the past was
  WhatsApp or Instagram. But they can both by used very well from a browser
  today.
