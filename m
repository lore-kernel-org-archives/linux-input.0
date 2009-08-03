From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [PATCH] hid: ignore all recent SoundGraph iMON devices
Date: Mon, 03 Aug 2009 16:42:39 +0300
Message-ID: <4A76E94F.1010508@gmail.com>
References: <200907311056.36729.jarod@redhat.com> <200908022116.05450.jarod@redhat.com> <4A76E098.90705@gmail.com> <200908030922.32334.jarod@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:60644 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084AbZHCNvh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Aug 2009 09:51:37 -0400
In-Reply-To: <200908030922.32334.jarod@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Jarod Wilson wrote:
> On Monday 03 August 2009 09:05:28 Anssi Hannula wrote:
>> Jarod Wilson wrote:
>>> Also, out of curiosity, what does a "proper HID driver for it" look
>>> like and/or do that the latest lirc_imon doesn't?
>> Well, I didn't want to use 3rdparty drivers with my device.
>>
>> Anyways.. my driver implements a hid_driver (see /drivers/hid/hid-*.c),
>> and sets a raw_event callback for the non-standard-hid-input events of
>> the 2nd interface and emits input layer events for those. The device
>> uses standard HID input protocol in first interface, so my driver
>> doesn't touch that at all and lets the general hid code handle that
>> (some remote control buttons are passed by that).
> 
> Yeah, a lot of this sounds like what Rene Harder and I have discussed
> doing over on the lirc list. We're both a bit tied up with other things
> right now though, so its not really progressed in a few weeks, since
> we merged a bunch of touchscreen and mouse input device support a bit
> ago.
> 
>> LCD write packets are
>> queued via usbhid_submit_report(). The driver also has code for
>> registering the LCD as standard framebuffer device and allowing led
>> subsystem access to the icons, though I'm not sure yet if those should
>> be there (1-bit framebuffers may not be supported by much userspace
>> code, haven't checked yet; having the icons registered for led subsystem
>> allows triggers and handling via /sys, but I'm not sure if that is
>> useful for these kind of icons).
> 
> So is the LCD usable with, say, lcdproc? I hadn't ever really thought
> about using mine any other way (I have an 0045 device myself, its an
> Antec Veris Premiere, which is a rebranded iMON UltraBay).

Well, these can be additional to /dev/lcd*, not necessarily replacing it.

I also see that currently the LCD handling code is somewhat duplicated
at least with lcdproc and VDR imon
(http://projects.vdr-developer.org/wiki/plg-imonlcd), haven't searched
if there are other projects doin the same. Maybe an userspace library
would be better suited for this, though.

>>> We're already doing
>>> input layer stuff with the mouse mode and mouse buttons, and looking to
>>> further extend that, potentially making the driver pure input layer,
>>> but still usable with the lirc devinput userspace driver.
>> Oh, this sounds to me like active work getting lirc into upstreamable
>> condition :)  Is it that?
> 
> It is. I'm hoping to send another submission for upstream review Real
> Soon Now. lirc_imon, lirc_mceusb, lirc_serial and lirc_i2c are all in
> pretty good shape now, will probably limit the submission to those
> four this time around...

Great :)

>> More incentive for me to not submit my driver, then.
> 
> More than anything, I'd love to see any worthwhile additions in your
> work merged into the lirc_imon driver.

I'll see. I have so much other work to do currently, that it may not
happen soon, though.

-- 
Anssi Hannula
