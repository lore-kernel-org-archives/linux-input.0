From: Alex Hudson <home@alexhudson.com>
Subject: Re: Driver problems: t213 on i8042 port
Date: Sat, 11 Dec 2010 08:56:05 +0000
Message-ID: <1292057765.2844.9.camel@lapland.localdomain>
References: <1291804388.3052.11.camel@lapland.localdomain>
	 <20101211071532.GB5306@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vm2.hosting.betterhosted.com ([78.46.205.147]:52989 "EHLO
	mx1.betterhosted.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab0LKI43 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Dec 2010 03:56:29 -0500
Received: from services1.betterhosted.com (unknown [192.168.54.3])
	by mx1.betterhosted.com (Postfix) with ESMTP id 9884C9FB06
	for <linux-input@vger.kernel.org>; Sat, 11 Dec 2010 07:58:14 +0000 (GMT)
Received: from [192.168.178.101] (cpc2-croy13-0-0-cust346.croy.cable.virginmedia.com [77.103.217.91])
	by services1.betterhosted.com (Postfix) with ESMTPSA id 41C7629C93
	for <linux-input@vger.kernel.org>; Sat, 11 Dec 2010 08:58:14 +0000 (GMT)
In-Reply-To: <20101211071532.GB5306@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>

Hi Dmitry,

Thanks for responding, much appreciated ;)

On Fri, 2010-12-10 at 23:15 -0800, Dmitry Torokhov wrote:
> > I'm having some trouble with the serio support for a touchit213 device,
> > and I'm hoping by describing what's going on someone can offer some
> > clues.
> 
> I guess I'd start by making sure that you are indeed dealing with
> touchit123 and not some other device.

Indeed, I'm pretty sure this is the right device. The xf86 driver I
mentioned comes as a source module, and accesses the device via
serio_raw. I've compared the code and the protocol is identical: and
indeed, the xf86 module makes clear some things the serio driver implies
(e.g., the xf86 driver treats the data definitively as 11-bit).

The problem with the xf86 driver is many-fold; it was written pre-Xorg
and it's taken me a fair bit of hacking just to even get it to work on
Fedora 14 without segfaulting. It's also a lot more complex than the
serio equivalent.

> > Now, there is a serio driver for the touchit213 series, but the obvious:
> > 
> > 	echo -n "touchit213" > /sys/bus/serio/devices/serio4/drvctl
> > 
> > .. doesn't work. I don't see anything in the logs; whereas if I use
> > inputattach to connect the driver to ttyS0 (which doesn't have the
> > device, obviously) I can see that the driver is enabled
> > in /var/log/messages and a touch /dev/input/event device is created.
> 
> Right, the current touchit123 driver only binds to serio that has
> appropriate type. Basically this means that the driver only works with
> serial ports (ttySx) and not PS/2 ports.

I think you've nailed the problem, then - is this to do with the
structure in touchit213_serio_ids[]? I had only really been looking at
the connect() function.

Is it possible it's as simple as adding another stanza accepting
SERIO_8042 or is there a more fundamental reason why ttySx is only
allowed?

Thanks for all your help, 

Alex.


--
This message was scanned by Better Hosted and is believed to be clean.
http://www.betterhosted.com

