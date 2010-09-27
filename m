From: Jarod Wilson <jarod@redhat.com>
Subject: Re: Hacking on ati_remote driver
Date: Mon, 27 Sep 2010 12:07:33 -0400
Message-ID: <20100927160733.GD32376@redhat.com>
References: <20100926192226.GA24012@redhat.com>
 <20100927144219.5901.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15226 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933247Ab0I0QHh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Sep 2010 12:07:37 -0400
Content-Disposition: inline
In-Reply-To: <20100927144219.5901.qmail@science.horizon.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-input@vger.kernel.org, mchehab@redhat.com

On Mon, Sep 27, 2010 at 10:42:19AM -0400, George Spelvin wrote:
> > IMO, ati_remote.c and ati_remote2.c should be adapted to use the ir-core
> > (soon to be rc-core) interfaces. I've got remote2 hardware myself, so
> > doing the conversion for that driver is already on my personal TODO list,
> > but its a long queue of more important things ahead of it first...
> 
> Just what I want, more scope creep... I'm not immovably opposed to a
> larger conversion job, but can you tell me that the ir-core/rc-core
> layer gives me over the raw input layer?

- Hopefully, a simplified interface, with less code duplication. Quite a
few remote drivers reimplement the same things over and over. I've not
actually looked at ati_remote.c to see exactly what its got, but
ati_remote2.c has some low-level evbit, keybit, __set_bit, etc.,
manipulations that would mostly disappear w/ir-core, in favor of using
common shared code.

- Userspace remote-specific manipulation tools in v4l-utils

- Sysfs hooks that reveal its a remote in the first place -- which may be
  of benefit to a userspace daemon, udev loading a new keymap
  automatically, or to media center apps that want to look directly at a
  remote control's input device until such time as X sucks less and will
  pass through keycodes larger than 8-bit.

> I see how there are a bunch
> of utilities for decoding raw pulse streams, but there's only one
> RC_DRIVER_SCANCODE driver, imon.c, and even that seems to use the RC6
> protocol sometimes.

imon is always scancode, but some of the devices can be configured to use
one device or another. One of them is an RC6A MCE remote. But it still
does decoding in hardware and passes along scancodes. There's tm6000 in
staging that is RC_DRIVER_SCANCODE, and I swear more devices under
drivers/media/ are scancode-only and simply haven't been ported fully over
to ir-core just yet, but I could be wrong about that.

> Looking at the code leads to a few obvious questions:
> ir-common.h:
> 	Why is the linux keycode u32, when the input layer's
> 	key codes are __u16?  And why is keypressed an int
> 	rather than a bool?
> 
> 	And why is the type __u64?  It appears top be a bitmap,
> 	with about 6 values defined so far...

ir-common.h is going away RSN, this is from an older pre-{ir,rc}-core IR
layer in the media tree. Its not used by imon, mceusb or streamzap,
anyway.

> ir-sysfs.c:
> 	Why is store_protocol, which appears to be turning an ASCII
> 	string into an ir_type bitmap, documented as "triggered by
> 	READING /sys/class/rc/rc?/current_protocol"?  Why doesn't that
> 	code support the rc6 protocol?

Um... what? I see:

 * This routine is a callback routine for changing the IR protocol type.
 * It is trigged by writing to /sys/class/rc/rc?/protocols.
  
And it definitely supports rc6.

> In general, I'm bit confused about what it means to change_protocol
> to a bitmap with multiple bits set.  Are you sure ir_type needs to be
> a bitmap?  The only place I can see its bitmapness actually used is in
> show_supported_protocols(), and that could be replaced by an array of a
> few chars or something.  (Most devices support only one or two protocols.)
> Reserving 0 for "end of list" would make the structure initialization
> simpler.

May or may not need to be a bitmap, I didn't write that part. Mauro may be
able to shed some light here. Generally, you'll only change_protocol to a
single proto (that's the case w/imon), but there could be receivers where
more than one can be enabled simultaneously.

> One thing that would be nice is to have the permissions on the sysfs
> protocol file depend on the existence of a change_protocol method.
> 
> Um.. I also notice that change_protocol isn't even supported on
> non-RC_DRIVER_SCANCODE drivers.  Is this all a big kludge invented for
> the imon driver?

No. It existed before the imon driver. git grep for change_protocol, and
you'll see its used in a number of places besides imon.c.

> ir-functions.c: Is ir->last_bit actually used for anything?  I can't
> find an assignement to a non-zero value anywhere...
> Oh, wait, drivers/media/video/cx23885/cx23885-input.c and
> drivers/media/video/saa7134/saa7134-input.c
> Does that need to be in the generic structure?

Not sure, haven't ever touched it myself.

-- 
Jarod Wilson
jarod@redhat.com

