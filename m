From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Driver problems: t213 on i8042 port
Date: Wed, 15 Dec 2010 00:03:52 -0800
Message-ID: <20101215080352.GA11920@core.coreip.homeip.net>
References: <1291804388.3052.11.camel@lapland.localdomain>
 <20101211071532.GB5306@core.coreip.homeip.net>
 <1292057765.2844.9.camel@lapland.localdomain>
 <20101213091027.GI21401@core.coreip.homeip.net>
 <1292235175.2805.19.camel@lapland.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:52131 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab0LOIEA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Dec 2010 03:04:00 -0500
Received: by gwb20 with SMTP id 20so1251359gwb.1
        for <linux-input@vger.kernel.org>; Wed, 15 Dec 2010 00:04:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292235175.2805.19.camel@lapland.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alex Hudson <home@alexhudson.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Mon, Dec 13, 2010 at 10:12:54AM +0000, Alex Hudson wrote:
> On Mon, 2010-12-13 at 01:10 -0800, Dmitry Torokhov wrote:
> > > [re: xf86 driver for t213 device]
> >
> > Any chance you could post a link to the sources?
> 
> I can:
> 
> http://www.tabletkiosk.de/files//linux-general/drivers/testing/touchkit-linux-2.2.0.tar.bz2
> 
> There is a thread about this driver on their site as well:
> 
> http://www.tabletkiosk.com/forum/forum_posts.asp?TID=103
> 
> It doesn't compile at all against current X.org; I can send you my diff
> for that but it's all X.org ABI stuff - nothing to do with the actual
> t213 protocol. However, some of this might be moot anyway:
> 
> > You can't simply allowing binding to SERIO_8042 as it will cause
> > touchkit213 to fight with the standard psmouse driver. What needs to be
> > done is to write a sub-driver (or protocol driver) for psmouse module
> > which would probe the devices and automatically select proper protocol.
> > 
> > Please take a look at drivers/input/mouse/psmouse-base.c and friends
> > there.
> 
> Ah, ok, that makes sense then - originally when I was trying to make
> sense of this hardware it kept coming through as a PS/2 mouse but of
> course X.org went slightly nuts with that configuration. 
> 
> As an aside, I wonder if this speaks to some of the problems I was
> having with the X.org driver. I was simply attaching serio_raw to serio4
> as per the instructions; however, if this "fights" (as you describe it)
> with the ps2 mouse, that could explain why it would mostly work but then
> go weird.
> 
> I had a look at psmouse-base.c, and I can see what you mean: also,
> there's a "Touchkit" driver for eGalax, and the protocol there looks
> identical. Weirdly, this isn't working - even though looking at the code
> the detect() function doesn't seem to need a manual trigger.
>

Touchkit initialization sequence looks similar to the one used in X
driver. You probably want to boot with i8042.debug (or activate it via
/sys/module/i8042/parameters/debug), load psmouse module and see what
kind of response you are getting from the device.

Also, have you tried forcing touchkit protocol by doing:

	echo "touchkit" > /sys/bus/serio/devices/serioX/protocol

Thanks.

-- 
Dmitry
