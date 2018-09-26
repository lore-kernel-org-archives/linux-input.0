From: Florian Dollinger <dollinger.florian@gmx.de>
Subject: Re: hid: microsoft: Add rumble support for Xbox One S controller
Date: Thu, 27 Sep 2018 00:50:04 +0200
Message-ID: <895230e5-05a8-68f4-5794-28e3d3068e81@gmx.de>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
 <20180926125130.974-1-dollinger.florian@gmx.de>
 <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
 <003401d455ab$c6df5280$549df780$@gmx.de>
 <75590dbdffee5870537a344209af185cdda5de30.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <75590dbdffee5870537a344209af185cdda5de30.camel@hadess.net>
Content-Language: en-HK
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, andrew.smirnov@gmail.com
Cc: linux-kernel@vger.kernel.org, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> Sure it is, but:
> - it's not an "XBox One S controller", it's a variant of the "XBox One
> controller" shipped with the XBox One S.
> - we discussed this on the linux-bluetooth mailing-list in August 2016:
>    https://www.spinics.net/lists/linux-bluetooth/msg68102.html
>    revived the thread in 2017:
>    https://www.spinics.net/lists/linux-bluetooth/msg72750.html
>    and discussed the force feedback in particular in August this year:
>    https://www.spinics.net/lists/linux-input/msg57744.html
> - why would we look for a "driver" when there's already one in the
> kernel that supports all the xbox controllers except this one? :)
> 
> Really, as much as it's nice to find working code for this device, it's
> surprising you didn't contact any kernel developer before, rather than
> us having to find you.

Fair enough :)

> Yes, but that's not the way the drivers are usually arranged. They're
> arranged by vendors, so this driver would need to be merged into the
> "hid-microsoft.c" driver.

That's probably the main reason for not getting in touch earlier, I 
really don't like the idea of putting everything into the same driver 
just because it is the same vendor - or at leas the same name (even if 
Microsoft Xbox has nearly nothing to do with other parts of Microsoft).

> I'm pretty sure that the USB version can also be made to use HID.

I really don't think so, I already gave it a try. At least not "out of 
the box".

> I have no idea how the RF protocol would work though. I imagine it
> requires a dongle, or does it actually use Wi-Fi? (that would be
> surprising...).

In theory it does need one, but it is nothing more than normal Wi-Fi 
(2,4 and 5 GHz) - you can talk to the gamepad using any Wi-Fi card / 
stick you want. The problem is, that the connection is secured somehow.
If you are interested, take a look here: 
https://github.com/atar-axis/xpadneo/wiki/Microsoft-Xbox-One-Wireless-Adapter

> Anyway, I don't have much time to work on it right this minute, but it
> would be great if you could send your Bluetooth patch to start with,
> and we can iterate on that, and fix the other problems as we clear the
> priority list.

Jap, I will do that - Thank you so far!

> Cheers

Dito.
