From: "George Spelvin" <linux@horizon.com>
Subject: Re: Hacking on ati_remote driver
Date: 28 Sep 2010 15:04:19 -0400
Message-ID: <20100928190419.19528.qmail@science.horizon.com>
References: <20100927160733.GD32376@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:45325 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757437Ab0I1TEW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 15:04:22 -0400
In-Reply-To: <20100927160733.GD32376@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jarod@redhat.com, mchehab@redhat.com
Cc: linux-input@vger.kernel.org, linux@horizon.com

Thank you both for your replies.

To start with, a major misunderstanding on my part:
after some initial grepping, I limited the vast majority of my
investigations to drivers/media/IR, not realizing that the drivers are
all over drivers/media.  And I forgot about staging completely.

>>> Looking at the code leads to a few obvious questions:
>>> ir-common.h:
>>> 	Why is the linux keycode u32, when the input layer's
>>> 	key codes are __u16?  And why is keypressed an int
>>> 	rather than a bool?
>>>
>>> 	And why is the type __u64?  It appears top be a bitmap,
>>> 	with about 6 values defined so far...
>> 
>> ir-common.h is going away RSN, this is from an older pre-{ir,rc}-core IR
>> layer in the media tree. Its not used by imon, mceusb or streamzap,
>> anyway.

[Another quote]
> ir-functions will die as soon as we move all drivers to use rc-core.

Okay, so I'm confused: what *is* the {ir,rc}-core?
Can you tell me which header files constitute the interface?
Obviously I've been looking at the wrong stuff.

include/media/ir-core.h and drivers/media/IR/ir-core-priv.h?
Or just the former?


> The type is to handle the different IR protocols. As it is a bitmap, I
> opted to define it as u64, as I was afraid that we might run out of space
> with just 32 bits.

I can see how a bit-banged implementation could try multiple receive
protocols.  Although reserving bit 31 for magic purposes is a bit bizarre.

>>> ir-sysfs.c:
>>> 	Why is store_protocol, which appears to be turning an ASCII
>>> 	string into an ir_type bitmap, documented as "triggered by
>>> 	READING /sys/class/rc/rc?/current_protocol"?  Why doesn't that
>>> 	code support the rc6 protocol?
>> 
>> Um... what? I see:
>> 
>>  * This routine is a callback routine for changing the IR protocol type.
>>  * It is trigged by writing to /sys/class/rc/rc?/protocols.
>>   
>> And it definitely supports rc6.
>
> George, you're probably looking at an older implementation.

Indeed, I was looking at Linus' v2.6.35.  It's changed in the .36-rcX
series.

>>> Just what I want, more scope creep... I'm not immovably opposed to a
>>> larger conversion job, but can you tell me that the ir-core/rc-core
>>> layer gives me over the raw input layer?
>>
>> - Hopefully, a simplified interface, with less code duplication. Quite a
>> few remote drivers reimplement the same things over and over. I've not
>> actually looked at ati_remote.c to see exactly what its got, but
>> ati_remote2.c has some low-level evbit, keybit, __set_bit, etc.,
>> manipulations that would mostly disappear w/ir-core, in favor of using
>> common shared code.

This is just the input device wrappers in ir-keytable.c, particularly
__ir_input_register?  This is actually somewhat inconvenient, as this
code separates the remote (get_rc_map()) from the receiver hardare.
Great for generic protocols, but an unnecessary complication for one
tightly coupled to the receiver.

It's not like the input layer values that you're talking about are
that hard to use.

And can it handle the 8-way mouse pad on the remote?


I notice a lot of remotes have dense scancode assignments, so you could
provide an alternative map representation.  So keymaps/rc-flyvideo.c
would turn into:

static __u16 flyvideo[] = {
        KEY_POWER,	/* 0x00: Power */
	0,
        KEY_ZOOM,	/* 0x02: Fullscreen */
        KEY_1,
        KEY_2,
        KEY_3,
        KEY_AGAIN,	/* 0x06: Recall */
        KEY_4,
        KEY_5,
        KEY_6,
        KEY_ANGLE,	/* no label, may be used as the PAUSE button */
        KEY_7,
        KEY_8,
        KEY_9,
        KEY_MODE,	/* 0x0e: Air/Cable */
        KEY_0,
        KEY_ENTER,	/* 0x10: Enter */
        KEY_VIDEO,	/* 0x11: Video */
        KEY_CHANNELUP,	/* 0x12: Channel + */
        KEY_CHANNELDOWN,/* 0x13: Channel - */
        KEY_VOLUMEUP,	/* 0x14: Volume + */
        KEY_AUDIO,	/* 0x15: Audio */
	0,
        KEY_VOLUMEDOWN,	/* 0x17: Volume - */
        KEY_TUNER,	/* 0x18: AV Source */
        KEY_BACK,	/* 0x19: Rewind  ( <<< ) */
        KEY_LANGUAGE,	/* 0x1a: Stereo */
        KEY_MUTE,	/* 0x1b: Mute */
	0, 0, 0,
        KEY_FORWARD	/* 0x1f: Forward ( >>> ) */
};


>> - Userspace remote-specific manipulation tools in v4l-utils
>> 
>> - Sysfs hooks that reveal its a remote in the first place -- which may be
>>   of benefit to a userspace daemon, udev loading a new keymap
>>   automatically, or to media center apps that want to look directly at a
>>   remote control's input device until such time as X sucks less and will
>>   pass through keycodes larger than 8-bit.

Um, and does this consist of anything other than /sys/class/rc/$NAME/protocols?
Just to play devil's advocate here, how does that help me?
