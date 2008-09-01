From: Richard Hughes <rhughes@redhat.com>
Subject: Re: Remove HID ignore quirk for MGE UPS devices
Date: Mon, 01 Sep 2008 13:14:02 +0100
Message-ID: <1220271242.16219.39.camel@hughsie-work>
References: <1218798061.14646.13.camel@hughsie-work>
	 <ec33acbd0809010450r1a14a3e8x3ea3e1ada63c2484@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:43738 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794AbYIAMTt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Sep 2008 08:19:49 -0400
In-Reply-To: <ec33acbd0809010450r1a14a3e8x3ea3e1ada63c2484@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnaud Quette <aquette.dev@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, David Zeuthen <davidz@redhat.com>, "kay.sievers" <kay.sievers@vrfy.org>

On Mon, 2008-09-01 at 13:50 +0200, Arnaud Quette wrote:
> first, note that I'm the originator of the below mentioned (2.4.25)
> patch, and the one that has developed the USB UPS support code (helped
> only for the kernel part, and done the userland one).

After reading al the kernel and NUT HID stuff, I'm really not convinced
any of the low level HID table parsing should be done in userspace at
all.

> 2008/8/15 Richard Hughes <rhughes@redhat.com>:
> > The attached patch reverts the change made four years ago here:
> > http://www.vg.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-hid-2.4.25-pre7.patch
> >
> > UPS's made by MGE can be used with usbhid just fine, and by removing the
> > ignore quirk allows them to be used with HAL so they just work when plugged
> > in, without needing to be manually configured.
> 
> this is true for recent units, but hiddev (not itself but something in
> the USB stack at that time) was breaking the communication with some
> of MGE *UPS* small devices. Note that this might have been solved
> since then.

Right, so it should be a tiny patch to the kernel HID parser, if it's
not been fixed already.

> the assertion that is false is that without this, HAL support can't work.
> the code to support USB UPSs that I've developed since this oldish
> kernel since that allows this (Richard, you have missed to compile nut
> with --with-hal...). This latter is more complete (support all USB HID
> UPS + all USB devices, along with more features, more specific
> handling, more data, more ... everything) and is *portable* (or
> ported) on other USB enabled Unix (*bsd, solaris and darwin). So as to
> the HAL support code using this exact same NUT code.

Sure, I've used --with-hal myself. The number of desktop users who
install NUT and use the hal-nut sub package is virtually nil in the real
world. It also excludes server machines that don't want or need HAL, and
doesn't really work well when DeviceKit starts being used instead. I've
got thousands of lshal outputs from desktop machines, and the majority
of USB UPS devices are not managed by NUT as the users probably think it
"doesn't work with Linux".

I appreciate some of the older more random serial cable units probably
belong in a userspace library, but when the new standard USB HID stuff
in the kernel makes this just work without any drivers, libraries or
daemons, then I really think we should use that.

> > With the ignore quirk in place a user would have to configure NUT before the
> > UPS could be used, as NUT uses it's own internal USB matching framework
> > to match against the USB devices, do low level control messages on the
> > device and then parse the HID tables all in userspace.
> 
> wrong, see above.

I don't see why a user should have to install a multi-megabyte library
and daemon just to use the power page device that the kernel already
supports. This stuff can _just work_, and does for all the other of
thousands of UPS devices that support the HID power page.

> The only thing I can say, as in 2004 is that in kernel UPS handling is
> too fat, incomplete and unuseful.

Right, so the proper way to do this is to work with the subsystem
maintainers, and push the quirk patches lower into the kernel as they
are probably useful for other devices.

> the userland support is there, and for some time mature, propose more
> features, best device handling (and there are many devices specifics
> out there)

Right, there are a ton of HID quirks right now, I don't think adding a
couple more for obsolete devices there would be a problem.

> , support all USB UPSs (not only HID ones), support HAL and
> hotplug / 0 config things and is portable.
> 
> the PDC support is hiddev should simply be removed! that would give a
> small diet to the kernel too...

I don't agree. After all the work I've done with userspace drivers the
conclusion I've come to is that they are more complex, slower and often
are not as stable as in kernel drivers. If the PDC page is removed, then
NUT has to be installed by default on every machine, just in case a USB
UPS is ever inserted. I don't think that's a good idea.

Richard.


