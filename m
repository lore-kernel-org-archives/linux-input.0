From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Driver problems: t213 on i8042 port
Date: Fri, 10 Dec 2010 23:15:33 -0800
Message-ID: <20101211071532.GB5306@core.coreip.homeip.net>
References: <1291804388.3052.11.camel@lapland.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60678 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab0LKHPj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Dec 2010 02:15:39 -0500
Received: by iwn9 with SMTP id 9so6719076iwn.5
        for <linux-input@vger.kernel.org>; Fri, 10 Dec 2010 23:15:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291804388.3052.11.camel@lapland.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alex Hudson <home@alexhudson.com>
Cc: Linux Input <linux-input@vger.kernel.org>

Hi Alex,

On Wed, Dec 08, 2010 at 10:33:08AM +0000, Alex Hudson wrote:
> Hi all,
> 
> I'm having some trouble with the serio support for a touchit213 device,
> and I'm hoping by describing what's going on someone can offer some
> clues.

I guess I'd start by making sure that you are indeed dealing with
touchit123 and not some other device.

> 
> The PC in question is a tablet PC with the touchscreen apparently
> connected to the fourth serial/ps2 port on the i8042 internally, rather
> than ttyS0 or something.
> 
> The manufacturer provides an xf86 driver which is extremely ropey,

They don't support the source do they?

> and
> requires raw access the port. This works:
> 
> 	echo -n "serio_raw" > /sys/bus/serio/devices/serio4/drvctl
> 
> .. and /dev/serio_raw0 is created.

Well, even if they don't we can capture the driver initializzation
sequence by doing:

	echo 1 > /sys/module/i8042/paramaters/debug

before switching to X and activating the vendor driver. This will also
allow us capture the data stream from the device and analyze it.

> 
> Now, there is a serio driver for the touchit213 series, but the obvious:
> 
> 	echo -n "touchit213" > /sys/bus/serio/devices/serio4/drvctl
> 
> .. doesn't work. I don't see anything in the logs; whereas if I use
> inputattach to connect the driver to ttyS0 (which doesn't have the
> device, obviously) I can see that the driver is enabled
> in /var/log/messages and a touch /dev/input/event device is created.

Right, the current touchit123 driver only binds to serio that has
appropriate type. Basically this means that the driver only works with
serial ports (ttySx) and not PS/2 ports.

> 
> I've looked through the source for the touchit213 driver, and it's nice
> simple code - and I'm assuming that it's failing somewhere in the
> connect function. However, I'm struggling to get much further than this.
> 
> I guess the first question is, should this work? Attaching touchit213 to
> a 'real' serial port appears to work, so I'm making the guess that this
> is something to do with it being a port on the i8042.

I am not sure, it depends whether touchit123 is indeed the right driver.
You sure it is not a variation of Lifebook touchscreen? What device
(laptop) is this?

> However, I don't
> really know much serio and haven't been able to find any good
> documentation about it - it could be I'm just missing an appropriate
> incantation?

There is no appropriate incantation for PS/2 ports. It either works
automatically or we need to adjust in-kernel driver to make it work
automatically.

> 
> Second question is, if it's supposed to work - does anyone have some
> good ideas for debugging this? I think otherwise I'm going to be
> sprinkling kprintfs() in the driver and seeing what happens - are there
> any better ways than this?

Like I said, if there is no sources to vendor driver just enable
debugging for i8042 and capture initialization steam and the data steam
with vendor driver and we'll have to make sense out of it.

Hope this helps.

-- 
Dmitry
