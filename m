From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Logitech G13 driver (fixed cc list --- ignore others)
Date: Wed, 16 Dec 2009 15:08:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912161504360.3755@pobox.suse.cz>
References: <200912142122.nBELMW7d001243@mustang.cs.nmsu.edu> <20091216103423.GE1377@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56419 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934023AbZLPOIR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2009 09:08:17 -0500
In-Reply-To: <20091216103423.GE1377@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, linux-kernel@vger.kernel.org, krzysztof.h1@wp.pl, Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org

On Wed, 16 Dec 2009, Pavel Machek wrote:

> > Although identified as a HID, the device does not support standard HID 
> > input messages. As a result, a sub-input device is allocated and 
> > registered separately in g13_probe(). The raw events are monitored and 
> > key presses/joystick activity is reported through the input device 
> > after referencing an indexed keymap.
> > 
> > Additionally, this device contains a 160x43 monochrome LCD display. A 
> > registered framebuffer device manages this display. The design of this 
> > portion of the driver was based on the design of the hecubafb driver 
> > with deferred framebuffer I/O since there is no real memory to map.
> > 
> > This patch is against the torvalds/linux-2.6.git tree.
> 
> Should this use auxdisplay framework and be located there?

Well, the device is still primarily HID device in its nature, so either 
keeping the whole driver in drivers/hid, or separating it into two 
drivers, one for the HID part and second for the framebuffer part should 
be acceptable.

> > --- /dev/null
> > +++ b/drivers/hid/hid-g13-logo.xbm
> > @@ -0,0 +1,75 @@
> > +#define g13_lcd_width 160
> > +#define g13_lcd_height 43
> > +static unsigned char g13_lcd_bits[] = {
> > +   0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +   0x00, 0x00, 0x00, 0x28, 0x03, 0x00, 0x40, 0x01, 0x00, 0xc0, 0x3f, 0x00,
> > +   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa1,
> > +   0x08, 0x00, 0x08, 0x00, 0x00, 0xe0, 0x7f, 0x00, 0x00, 0x00,
> > 0x00, 0x00,
> 
> I'd prefer to go without another logo. Just make sure default penguin gets
> there or something.

What logo is this, BTW? :)

I will proceed with reviewing the driver soon, sorry for slightly higher 
latencies these days.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
