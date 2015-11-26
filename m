From: Tuomas =?iso-8859-1?Q?R=E4s=E4nen?= <tuomasjjrasanen@opinsys.fi>
Subject: Re: Synaptics touchpad reset issue
Date: Thu, 26 Nov 2015 17:12:03 +0200
Message-ID: <20151126151202.GA30383@toimisto-tuomas-07.toimisto.opinsys.fi>
References: <20151123094336.GC11291@toimisto-tuomas-07.toimisto.opinsys.fi>
 <CAE7eX3JTaBFutMua6PqTLV90joHd9+V=1migsB9HOcWUubDnaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38576 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbKZPMK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2015 10:12:10 -0500
Received: by wmec201 with SMTP id c201so26172158wme.1
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2015 07:12:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAE7eX3JTaBFutMua6PqTLV90joHd9+V=1migsB9HOcWUubDnaw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <andrew.duggan@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Josep Pujadas-Jubany <jpujades@gmail.com>, Tobias Naumann <tobias-naumann@gmx.net>, Andrew Duggan <aduggan@synaptics.com>, Tuomas =?iso-8859-1?Q?R=E4s=E4nen?= <tuomasjjrasanen@tjjr.fi>

On Wed, Nov 25, 2015 at 05:15:44PM -0800, Andrew Duggan wrote:
> Hi Tuomas,
> 

Hi Andrew and thanks for the reply,

> It looks like some other people have reported similar issues with this
> particular touchpad module. I think there might be a hardware issue
> with some touchpads with the board/product id of 2991. Since this
> maybe a hardware issue there might not be a fix, but there might be a
> work around. This touchpad has a HID/I2C interface in addition to the
> PS/2 interface.
> 

Yes, I agree it's definitely a hardware issue. I'm just trying gather up
all bits and pieces to make an ugly but simple workaround:

 1. detect a malfunction by observing pressure values (just a simple threshold heuristic)
 2. reset the device when it's malfunctioning

> You should see a line in dmesg which looks something like this:
> hid-multitouch 0018:06CB:2991.0001: input,hidraw0: <UNKNOWN> HID v1.00
> Mouse [SYN1B7F:00 06CB:2991] on
> 

Yes, I just had to visit BIOS and set the touchpad operation mode to
"advanced".

> If you download and build rmihidtool
> (https://github.com/aduggan/rmi4utils), you can manually reset the
> touchpad and hopefully return it to a working state. The Fn+F7 on
> Windows is probably doing something similar by either cutting power to
> the touchpad or forcing a reset.
> 
> Running this command will reset the touchpad:
> $ sudo rmihidtool -e /dev/hidraw0
> 

Seems to work as expected.

> If the touchpad stops working completely then you may need to rebind
> the driver so that the touchpad is put back into PTP mode:
> $ sudo rmihidtool -b /dev/hidraw0
> 

Yes, rebind was required after a reset.

> >
> > To me it seems like the touchpad somehow recalibrates itself and becomes
> > highly sensitive and begins to emits touch events even when there's no
> > one touching it. The sensitiveness can be observed by looking at MT_ABS
> > values: in normal conditions maximum values are around 120, but in
> > confused state they are around 190.
> >
> 
> Do you mean EV_ABS?

I actually meant ABS_MT_PRESSURE.

> I'm not quite sure which values would have a
> normal max of around 120.

ABS_MT_PRESSURE values when synaptics PS/2 driver is managing the
device.

> Generally, these types of situations where
> false contacts are being reported are hard to distinguish in the
> firmware or driver from real contacts. Even if you notice a specific
> pattern on your particular system it might manifest itself differently
> on other systems.
> 

Yes, but here I'm trying to come up with an ugly workaround for this
specific device model. I guess it's quite safe to assume that all
devices with identical hardware generate sufficiently similar values,
no?

All in all, reseting the device via hidraw turned out to fix the
malfunction reliably. Thanks!!

But.

When the device is in HID/I2C mode, ABS_MT_PRESSURE events are not
available via the input device because hid-multitouch does not emit them
probably because device's report descriptor is missing
HID_DG_TIPPRESSURE usage? Otherwise it would have been mapped to
ABS_MT_PRESSURE, according to hid-multitouch.c.

On the other hand, in PS/2 mode, synaptics psmouse delivers pressure
events, but I don't know how to reset the device.

Perhaps I'll check raw HID reports if they contain pressure values, but
if they don't, I'm probably going to give up working around the problem.

One additional, probably silly, question though: because Fn+F7 always
fixes the problem under the hood, is it handled by the hardware or by
the kernel?

I decompiled DSDT and looked for methods of the device (TPD8), but
didn't see anything interesting, other than _DSM, which is probably a
standard ACPI method, Device Specific Method?. So I was wondering if it's
possible to reset the touchpad using some special ACPI method?

-- 
Tuomas
