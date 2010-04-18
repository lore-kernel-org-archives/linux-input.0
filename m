From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Sun, 18 Apr 2010 12:43:28 -0700
Message-ID: <20100418194328.GA17565@core.coreip.homeip.net>
References: <1271434792.2045.5.camel@localhost.localdomain>
 <20100417081212.GA19866@core.coreip.homeip.net>
 <1271540695.1970.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:56802 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab0DRTng (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Apr 2010 15:43:36 -0400
Received: by yxe29 with SMTP id 29so2126273yxe.4
        for <linux-input@vger.kernel.org>; Sun, 18 Apr 2010 12:43:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271540695.1970.3.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sat, Apr 17, 2010 at 10:44:55PM +0100, Bastien Nocera wrote:
> On Sat, 2010-04-17 at 01:12 -0700, Dmitry Torokhov wrote: 
> > HI Bastien,
> > 
> > On Fri, Apr 16, 2010 at 05:19:52PM +0100, Bastien Nocera wrote:
> > > This driver was originally written by James McKenzie, updated by
> > > Greg Kroah-Hartman, further updated by myself, with suspend support
> > > added.
> > > 
> > > More recent versions of the IR receiver are also supported through
> > > a patch by Alex Karpenko.
> > > 
> > > Tested on a MacbookAir1,1
> > > 
> > 
> > A few comments...
> 
> All fixed. I removed the suspend/resume code as it worked fine without
> it (I was working of an old patch).
> 
> Sent the new patch separately.

Hmm, I am curious why suspend and resume is not necessary for this
device... Are you relying on the USB core to tear down and re-create the
device? Then you may lose user-applied settings (like changed keymap).

But if suspend and resume are really not needed then you need to
complete cleanup and get rid of APPLIEIR_OPENED and APPLEIR_SUSPENDED
and their handling in applieir_open() and appleir_close().

> 
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > ---
> > >  Documentation/input/appleir.txt |   45 ++++
> > >  drivers/hid/hid-apple.c         |    4 -
> > >  drivers/hid/hid-core.c          |    5 +-
> > >  drivers/hid/hid-ids.h           |    1 +
> > 
> > HID pieces need to go through Jiri or he needs to ack them to go through
> > my tree...
> 
> The HID pieces are necessary to get the "lirc" part of the documentation
> working (in appleir.txt). The driver is fine without it, but it won't
> work with lirc until the HID patch is in.
> 

Right. I was just saying that Jiri needs to either take HID parts
through his tree or give OK for me to take through mine.

-- 
Dmitry
