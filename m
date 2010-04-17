From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Sat, 17 Apr 2010 22:44:55 +0100
Message-ID: <1271540695.1970.3.camel@localhost.localdomain>
References: <1271434792.2045.5.camel@localhost.localdomain>
	 <20100417081212.GA19866@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:33551 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225Ab0DQVpZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Apr 2010 17:45:25 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 36B9C86EC0
	for <linux-input@vger.kernel.org>; Sat, 17 Apr 2010 23:45:24 +0200 (CEST)
In-Reply-To: <20100417081212.GA19866@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sat, 2010-04-17 at 01:12 -0700, Dmitry Torokhov wrote: 
> HI Bastien,
> 
> On Fri, Apr 16, 2010 at 05:19:52PM +0100, Bastien Nocera wrote:
> > This driver was originally written by James McKenzie, updated by
> > Greg Kroah-Hartman, further updated by myself, with suspend support
> > added.
> > 
> > More recent versions of the IR receiver are also supported through
> > a patch by Alex Karpenko.
> > 
> > Tested on a MacbookAir1,1
> > 
> 
> A few comments...

All fixed. I removed the suspend/resume code as it worked fine without
it (I was working of an old patch).

Sent the new patch separately.

> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  Documentation/input/appleir.txt |   45 ++++
> >  drivers/hid/hid-apple.c         |    4 -
> >  drivers/hid/hid-core.c          |    5 +-
> >  drivers/hid/hid-ids.h           |    1 +
> 
> HID pieces need to go through Jiri or he needs to ack them to go through
> my tree...

The HID pieces are necessary to get the "lirc" part of the documentation
working (in appleir.txt). The driver is fine without it, but it won't
work with lirc until the HID patch is in.

Cheers 

