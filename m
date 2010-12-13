From: Alex Hudson <home@alexhudson.com>
Subject: Re: Driver problems: t213 on i8042 port
Date: Mon, 13 Dec 2010 10:12:54 +0000
Message-ID: <1292235175.2805.19.camel@lapland.localdomain>
References: <1291804388.3052.11.camel@lapland.localdomain>
	 <20101211071532.GB5306@core.coreip.homeip.net>
	 <1292057765.2844.9.camel@lapland.localdomain>
	 <20101213091027.GI21401@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vm2.hosting.betterhosted.com ([78.46.205.147]:55689 "EHLO
	mx1.betterhosted.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab0LMKNK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 05:13:10 -0500
In-Reply-To: <20101213091027.GI21401@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 2010-12-13 at 01:10 -0800, Dmitry Torokhov wrote:
> > [re: xf86 driver for t213 device]
>
> Any chance you could post a link to the sources?

I can:

http://www.tabletkiosk.de/files//linux-general/drivers/testing/touchkit-linux-2.2.0.tar.bz2

There is a thread about this driver on their site as well:

http://www.tabletkiosk.com/forum/forum_posts.asp?TID=103

It doesn't compile at all against current X.org; I can send you my diff
for that but it's all X.org ABI stuff - nothing to do with the actual
t213 protocol. However, some of this might be moot anyway:

> You can't simply allowing binding to SERIO_8042 as it will cause
> touchkit213 to fight with the standard psmouse driver. What needs to be
> done is to write a sub-driver (or protocol driver) for psmouse module
> which would probe the devices and automatically select proper protocol.
> 
> Please take a look at drivers/input/mouse/psmouse-base.c and friends
> there.

Ah, ok, that makes sense then - originally when I was trying to make
sense of this hardware it kept coming through as a PS/2 mouse but of
course X.org went slightly nuts with that configuration. 

As an aside, I wonder if this speaks to some of the problems I was
having with the X.org driver. I was simply attaching serio_raw to serio4
as per the instructions; however, if this "fights" (as you describe it)
with the ps2 mouse, that could explain why it would mostly work but then
go weird.

I had a look at psmouse-base.c, and I can see what you mean: also,
there's a "Touchkit" driver for eGalax, and the protocol there looks
identical. Weirdly, this isn't working - even though looking at the code
the detect() function doesn't seem to need a manual trigger.

So, I think I have my place to look: the touchit213 driver is probably
the wrong thing, it's the mouse/touchkit driver I actually want and I
should attempt to debug this part first. 

I think the comms part of it looks right, so maybe what's going on is
that the probing earlier in the ps2 code is actually upsetting the
device.

> Also, please use 'reply-all' on kernel lists - this way you have much
> better chance to receive prompt replies ;)

Apologies, it's my first time trying to contribute on vger lists - thank
you very much for your patience!

Thanks

Alex.



--
This message was scanned by Better Hosted and is believed to be clean.
http://www.betterhosted.com

