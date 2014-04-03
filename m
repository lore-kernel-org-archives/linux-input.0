From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID vendor access from user space
Date: Thu, 3 Apr 2014 15:57:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com> <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com> <CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37615 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbaDCN5t (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Apr 2014 09:57:49 -0400
In-Reply-To: <CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew de los Reyes <adlr@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Wed, 2 Apr 2014, Nestor Lopez Casado wrote:

> >> If a user wants to configure/control the device there are two choices,
> >> either write a hid-specific driver to deal with the vendor specific
> >> collection, or open the corresponding /hidraw node from userspace.
> >>
> >> But a hidraw node that carries system input data requires root priviledges.
> >>
> >> I'm interested in hearing your opinions on how to add the capability
> >> for a normal user process to control/configure a HID device via
> >> reports exchanged with a vendor collection.
> >>
> >> I have one proposal, which is to create, say  "/dev/hidvendorX", nodes
> >> for all top level HID collections which are today ignored by hid-input
> >> and/or other subsystems.
> >>
> >> These nodes would not require root priviledge by default and thus,
> >> users could control/reconfigure their devices from a standard
> >> application while keeping the "standard" input functionality intact.
> >
> > Why not write a kernel driver? We have a pretty nice infrastructure
> > for all this.
>
> Do you mean a "hid-specific" driver for certain vid & pid devices ?

I indeed believe that it's what David was proposing. Writing in-kernel 
drivers that handle just specific collections/usages, and let the rest 
be handled by the core infrastructure, is super-easy these days.

Also, if you need users to be able to trigger particular actions being 
perfomed by the driver, sysfs knobs should be a reasonable way to doing 
this.

As an example of such interface -- creating a sysfs trigger for 
hid-logitech-dj that will send the pairing command to the unified 
receiver, has been on my TODO list for quite some time already (and was 
even suggested by Linus).

> > If it's a license-issue, I recommend using udev rules to change
> > permissions on the requested devices directly during setup. You can
> > then use hidraw.
> It is not a license issue, it is a security issue.
> 
> Every hid class interface, (either usb, bluetooth, i2c, etc) has an
> associated hidraw node, and that node aggregates all reports sent from
> the device.
> 
> Say that for example, the device has a keyboard collection and a
> vendor collection, then changing permissions on the associated hidraw
> node (so as to give any desktop user unrestricted access to the vendor
> collection) would open the door to malicious code that could log the
> keyboard activity (as both the vendor reports and input reports are
> seen on the same hidraw node)

I think I am missing the point here. If you own the credentials of the 
session owner, you can log keystrokes anyway even now, just use

	xinput list
	xinput test <id>

and see the result :) Admittedly, this is a little bit more difficult when 
you are outside X11 session, but I am not sure how much concerned you are 
about such scenario anyway.

-- 
Jiri Kosina
SUSE Labs
