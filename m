From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: Hacking on ati_remote driver
Date: Tue, 28 Sep 2010 17:00:09 -0300
Message-ID: <4CA24949.4080606@redhat.com>
References: <20100928190419.19528.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23167 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354Ab0I1UAP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 16:00:15 -0400
In-Reply-To: <20100928190419.19528.qmail@science.horizon.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: jarod@redhat.com, linux-input@vger.kernel.org

Em 28-09-2010 16:04, George Spelvin escreveu:

> [Another quote]
>> ir-functions will die as soon as we move all drivers to use rc-core.
> 
> Okay, so I'm confused: what *is* the {ir,rc}-core?
> Can you tell me which header files constitute the interface?
> Obviously I've been looking at the wrong stuff.
> 
> include/media/ir-core.h and drivers/media/IR/ir-core-priv.h?
> Or just the former?

include/media/ir-core.h should have everything that a driver needs to work
with rc-core (please notice that have some includes inside). The 
ir-core-priv.h is meant to be used internally inside the subsystem, 
for example, to connect RC decoders. The subsystem is new, so, maybe you
may find the need of adding something more there, or to export an internal
interface to your drivers. In this case, just sent us a patch ;)

>> The type is to handle the different IR protocols. As it is a bitmap, I
>> opted to define it as u64, as I was afraid that we might run out of space
>> with just 32 bits.
> 
> I can see how a bit-banged implementation could try multiple receive
> protocols.  Although reserving bit 31 for magic purposes is a bit bizarre.

Better to think big than small in this case ;) When I started, I had no
idea how many protocols we would need there, since there are some "special
cases" where the normal demod doesn't handle (for example, a RC5-variant
with one extra bit, found on one specific device model).

>>>> Just what I want, more scope creep... I'm not immovably opposed to a
>>>> larger conversion job, but can you tell me that the ir-core/rc-core
>>>> layer gives me over the raw input layer?
>>>
>>> - Hopefully, a simplified interface, with less code duplication. Quite a
>>> few remote drivers reimplement the same things over and over. I've not
>>> actually looked at ati_remote.c to see exactly what its got, but
>>> ati_remote2.c has some low-level evbit, keybit, __set_bit, etc.,
>>> manipulations that would mostly disappear w/ir-core, in favor of using
>>> common shared code.
> 
> This is just the input device wrappers in ir-keytable.c, particularly
> __ir_input_register?  This is actually somewhat inconvenient, as this
> code separates the remote (get_rc_map()) from the receiver hardare.
> Great for generic protocols, but an unnecessary complication for one
> tightly coupled to the receiver.

On a few cases, it is not required to allow changing the scancodes for a table
(e. g. in the case where the hardware has some logic to prevent the usage of 
any other different remote model), but almost all IR hardware allows you to use 
a remote with a different set of scancodes (sometimes requiring the usage of
the same protocol) to work. By splitting the keymaps, userspace apps can replace
the scancode table, if the user wants to use this feature.

Even in the case where the hardware doesn't allow the usage of a different
remote controller (for example, Bluetooth remotes), user may want to
change the keycode tables, for example associating scancode 0x12345678 to KEY_F1,
instead of KEY_F2.

By splitting the keycode tables, they can be moved entirely to userspace, and
let udev to load the table that the user wants.

> It's not like the input layer values that you're talking about are
> that hard to use.
> 
> And can it handle the 8-way mouse pad on the remote?

Well, it may handle, but maybe the better is to have a separate input device
for mouse events.

> I notice a lot of remotes have dense scancode assignments, so you could
> provide an alternative map representation.  So keymaps/rc-flyvideo.c
> would turn into:
> 
> static __u16 flyvideo[] = {
>         KEY_POWER,	/* 0x00: Power */
> 	0,
>         KEY_ZOOM,	/* 0x02: Fullscreen */
>         KEY_1,
>         KEY_2,
>         KEY_3,
>         KEY_AGAIN,	/* 0x06: Recall */
>         KEY_4,
>         KEY_5,
>         KEY_6,
>         KEY_ANGLE,	/* no label, may be used as the PAUSE button */
>         KEY_7,
>         KEY_8,
>         KEY_9,
>         KEY_MODE,	/* 0x0e: Air/Cable */
>         KEY_0,
>         KEY_ENTER,	/* 0x10: Enter */
>         KEY_VIDEO,	/* 0x11: Video */
>         KEY_CHANNELUP,	/* 0x12: Channel + */
>         KEY_CHANNELDOWN,/* 0x13: Channel - */
>         KEY_VOLUMEUP,	/* 0x14: Volume + */
>         KEY_AUDIO,	/* 0x15: Audio */
> 	0,
>         KEY_VOLUMEDOWN,	/* 0x17: Volume - */
>         KEY_TUNER,	/* 0x18: AV Source */
>         KEY_BACK,	/* 0x19: Rewind  ( <<< ) */
>         KEY_LANGUAGE,	/* 0x1a: Stereo */
>         KEY_MUTE,	/* 0x1b: Mute */
> 	0, 0, 0,
>         KEY_FORWARD	/* 0x1f: Forward ( >>> ) */
> };

There are a few cases where the hardware only outputs 8 bits. Yet, most of
the time, the issue were in the way V4L used to handle keycodes, limiting
it to have only 7 bits, at max, due to an old limitation at input layer
(solved on kernel 2.6.22). 

>>> - Userspace remote-specific manipulation tools in v4l-utils
>>>
>>> - Sysfs hooks that reveal its a remote in the first place -- which may be
>>>   of benefit to a userspace daemon, udev loading a new keymap
>>>   automatically, or to media center apps that want to look directly at a
>>>   remote control's input device until such time as X sucks less and will
>>>   pass through keycodes larger than 8-bit.
> 
> Um, and does this consist of anything other than /sys/class/rc/$NAME/protocols?
> Just to play devil's advocate here, how does that help me?

The ir-keytable app understands all sysfs nodes at /sys/class/rc, and also
implements the logic to replace the keycode tables, via input/event ioctl.
It were written to allow dynamically loading a new keycode table, during udev
add event, by reading a file with the keycode table that are associated to each
remote controller.

Cheers,
Mauro
