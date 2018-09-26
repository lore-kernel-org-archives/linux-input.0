From: Bastien Nocera <hadess@hadess.net>
Subject: Re: AW: hid: microsoft: Add rumble support for Xbox One S controller
Date: Wed, 26 Sep 2018 20:02:53 +0200
Message-ID: <75590dbdffee5870537a344209af185cdda5de30.camel@hadess.net>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
                 <20180926125130.974-1-dollinger.florian@gmx.de>
         <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
         <003401d455ab$c6df5280$549df780$@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <003401d455ab$c6df5280$549df780$@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: dollinger.florian@gmx.de, andrew.smirnov@gmail.com
Cc: linux-kernel@vger.kernel.org, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2018-09-26 at 17:15 +0200, dollinger.florian@gmx.de wrote:
> Hey Bastien,
> 
> > Probably because he didn't know about it, and how would he?
> 
> Hum, it's the first hit when you search for something like 'xbox one
> s driver linux' since half an year or longer 😊

Sure it is, but:
- it's not an "XBox One S controller", it's a variant of the "XBox One
controller" shipped with the XBox One S.
- we discussed this on the linux-bluetooth mailing-list in August 2016:
  https://www.spinics.net/lists/linux-bluetooth/msg68102.html
  revived the thread in 2017:
  https://www.spinics.net/lists/linux-bluetooth/msg72750.html
  and discussed the force feedback in particular in August this year:
  https://www.spinics.net/lists/linux-input/msg57744.html
- why would we look for a "driver" when there's already one in the
kernel that supports all the xbox controllers except this one? :)

Really, as much as it's nice to find working code for this device, it's
surprising you didn't contact any kernel developer before, rather than
us having to find you.

> > I can imagine that a large portion of the driver can be integrated
> > in the existing XBox pad driver, with each feature added in
> > individual patches.
> 
> Would be great! But ist the xpad driver really the right place?
> 
> First of all, the BT interface is using HID, USB does not.
> Furthermore, the driver is currently around 1,3k lines long - for a
> single device and only BT... (okay yes, there are a lot of comments
> in it).
> But anyway, is it really a good idea to put everything into hid-
> microsoft?
> Moreover, there is another interface which I am trying to support at
> the moment - the one which is used by the XBOX (WiFi).
> 
> I think in the end the whole hid-microsoft thingy will get blown-up a
> bit - right?
> Or, everything is scattered over many places (hid-microsoft, xpad,
> another driver fort he wifi-interface).
> 
> Isn't it possible to use "one driver per device" in the kernel too,
> like I did?

Yes, but that's not the way the drivers are usually arranged. They're
arranged by vendors, so this driver would need to be merged into the
"hid-microsoft.c" driver.

I'm pretty sure that the USB version can also be made to use HID.

I have no idea how the RF protocol would work though. I imagine it
requires a dongle, or does it actually use Wi-Fi? (that would be
surprising...).

Anyway, I don't have much time to work on it right this minute, but it
would be great if you could send your Bluetooth patch to start with,
and we can iterate on that, and fix the other problems as we clear the
priority list.

Cheers
