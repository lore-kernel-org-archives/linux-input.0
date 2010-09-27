From: "George Spelvin" <linux@horizon.com>
Subject: Re: Hacking on ati_remote driver
Date: 27 Sep 2010 10:42:19 -0400
Message-ID: <20100927144219.5901.qmail@science.horizon.com>
References: <20100926192226.GA24012@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:51358 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756176Ab0I0OmU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Sep 2010 10:42:20 -0400
In-Reply-To: <20100926192226.GA24012@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jarod@redhat.com, linux@horizon.com
Cc: linux-input@vger.kernel.org

> IMO, ati_remote.c and ati_remote2.c should be adapted to use the ir-core
> (soon to be rc-core) interfaces. I've got remote2 hardware myself, so
> doing the conversion for that driver is already on my personal TODO list,
> but its a long queue of more important things ahead of it first...

Just what I want, more scope creep... I'm not immovably opposed to a
larger conversion job, but can you tell me that the ir-core/rc-core
layer gives me over the raw input layer?  I see how there are a bunch
of utilities for decoding raw pulse streams, but there's only one
RC_DRIVER_SCANCODE driver, imon.c, and even that seems to use the RC6
protocol sometimes.

Looking at the code leads to a few obvious questions:
ir-common.h:
	Why is the linux keycode u32, when the input layer's
	key codes are __u16?  And why is keypressed an int
	rather than a bool?

	And why is the type __u64?  It appears top be a bitmap,
	with about 6 values defined so far...

ir-sysfs.c:
	Why is store_protocol, which appears to be turning an ASCII
	string into an ir_type bitmap, documented as "triggered by
	READING /sys/class/rc/rc?/current_protocol"?  Why doesn't that
	code support the rc6 protocol?

In general, I'm bit confused about what it means to change_protocol
to a bitmap with multiple bits set.  Are you sure ir_type needs to be
a bitmap?  The only place I can see its bitmapness actually used is in
show_supported_protocols(), and that could be replaced by an array of a
few chars or something.  (Most devices support only one or two protocols.)
Reserving 0 for "end of list" would make the structure initialization
simpler.

One thing that would be nice is to have the permissions on the sysfs
protocol file depend on the existence of a change_protocol method.

Um.. I also notice that change_protocol isn't even supported on
non-RC_DRIVER_SCANCODE drivers.  Is this all a big kludge invented for
the imon driver?

ir-functions.c: Is ir->last_bit actually used for anything?  I can't
find an assignement to a non-zero value anywhere...
Oh, wait, drivers/media/video/cx23885/cx23885-input.c and
drivers/media/video/saa7134/saa7134-input.c
Does that need to be in the generic structure?
