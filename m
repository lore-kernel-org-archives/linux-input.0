From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Driver problems: t213 on i8042 port
Date: Mon, 13 Dec 2010 01:10:27 -0800
Message-ID: <20101213091027.GI21401@core.coreip.homeip.net>
References: <1291804388.3052.11.camel@lapland.localdomain>
 <20101211071532.GB5306@core.coreip.homeip.net>
 <1292057765.2844.9.camel@lapland.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:48660 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab0LMJKe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 04:10:34 -0500
Received: by gwb20 with SMTP id 20so4814919gwb.1
        for <linux-input@vger.kernel.org>; Mon, 13 Dec 2010 01:10:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292057765.2844.9.camel@lapland.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alex Hudson <home@alexhudson.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Sat, Dec 11, 2010 at 08:56:05AM +0000, Alex Hudson wrote:
> Hi Dmitry,
> 
> Thanks for responding, much appreciated ;)
> 
> On Fri, 2010-12-10 at 23:15 -0800, Dmitry Torokhov wrote:
> > > I'm having some trouble with the serio support for a touchit213 device,
> > > and I'm hoping by describing what's going on someone can offer some
> > > clues.
> > 
> > I guess I'd start by making sure that you are indeed dealing with
> > touchit123 and not some other device.
> 
> Indeed, I'm pretty sure this is the right device. The xf86 driver I
> mentioned comes as a source module, and accesses the device via
> serio_raw. I've compared the code and the protocol is identical: and
> indeed, the xf86 module makes clear some things the serio driver implies
> (e.g., the xf86 driver treats the data definitively as 11-bit).

Any chance you could post a link to the sources?

> 
> The problem with the xf86 driver is many-fold; it was written pre-Xorg
> and it's taken me a fair bit of hacking just to even get it to work on
> Fedora 14 without segfaulting. It's also a lot more complex than the
> serio equivalent.

Right, it is most likely does hardware probing and initialization
whereas touchkit213 expects input_attach to do this for it.

> 
> > > Now, there is a serio driver for the touchit213 series, but the obvious:
> > > 
> > > 	echo -n "touchit213" > /sys/bus/serio/devices/serio4/drvctl
> > > 
> > > .. doesn't work. I don't see anything in the logs; whereas if I use
> > > inputattach to connect the driver to ttyS0 (which doesn't have the
> > > device, obviously) I can see that the driver is enabled
> > > in /var/log/messages and a touch /dev/input/event device is created.
> > 
> > Right, the current touchit123 driver only binds to serio that has
> > appropriate type. Basically this means that the driver only works with
> > serial ports (ttySx) and not PS/2 ports.
> 
> I think you've nailed the problem, then - is this to do with the
> structure in touchit213_serio_ids[]? I had only really been looking at
> the connect() function.
> 
> Is it possible it's as simple as adding another stanza accepting
> SERIO_8042 or is there a more fundamental reason why ttySx is only
> allowed?

You can't simply allowing binding to SERIO_8042 as it will cause
touchkit213 to fight with the standard psmouse driver. What needs to be
done is to write a sub-driver (or protocol driver) for psmouse module
which would probe the devices and automatically select proper protocol.

Please take a look at drivers/input/mouse/psmouse-base.c and friends
there.

Also, please use 'reply-all' on kernel lists - this way you have much
better chance to receive prompt replies ;)

-- 
Dmitry
