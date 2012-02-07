From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [RFC] Microsoft Touch Mouse driver [was: Re: your mail]
Date: Tue, 07 Feb 2012 22:09:08 +0100
Message-ID: <4F3192F4.1040401@gmail.com>
References: <BROWNM3h3vLgAusVxON00000cfa@brown.emailprod.vodafone.se> <20120125132612.GA3890@polaris.bitmath.org> <4F200D14.80702@gmail.com> <20120125150035.GA4222@polaris.bitmath.org> <20120130072732.GA1855@core.coreip.homeip.net> <4F3113F6.6000403@gmail.com> <20120207161231.GA13128@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46050 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542Ab2BGVJL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Feb 2012 16:09:11 -0500
Received: by wics10 with SMTP id s10so5213769wic.19
        for <linux-input@vger.kernel.org>; Tue, 07 Feb 2012 13:09:10 -0800 (PST)
In-Reply-To: <20120207161231.GA13128@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Op 07-02-12 17:12, Henrik Rydberg schreef:
>> Ok, so it's pretty clear the consensus is that there should be a
>> different interface to push the data to user space.
>> My initial reaction is V4L, as the data is basically a stream of
>> monochrome frames, this kind of fits the video description. Also,
>> this could be of some benefit to all those
>> emulate-multi-touch-using-webcam projects.
> On the other hand, your device, and the ones to come, are likely not
> normal ccd cameras, and the interface is bound to be different; you
> would most likely prefer the stream to be silent when there are no
> touches, for instance, and only generate interrupts or new-data events
> as there is something to react to.

True, I had forgotten about that. There are no HID packets sent when 
nothing touches the surface and the CPU shouldn't needlessly spent 
cycles on parsing an empty stream.

>> Other options I see are mmap on the input device, creating a
>> separate (char?) device, UIO or even having the whole thing in
>> userspace.
> Personally, I think mmapped input devices would be a great extension
> to the input subsystem. I am thinking event types distributed in a 2D
> plane, maybe one node per type, and signalled by normal input events
> of the data-to-read type.

Ok, I'll look into that!

>> However, there's one tiny hack I'd like to have and I'm unsure
>> whether this can be done from userspace: as the mouse has only one
>> physical push button, it can't distinguish between left, middle or
>> right click.
>> Obviously, it can do this based on the information it gathers from
>> its touch surface, however the firmware has only the following dumb
>> implementation: when only one finger is present on the right part of
>> the surface, assume right click; otherwise assume left click. This
>> means that you need to lift your left finger when performing a right
>> click.
>>
>> Now, the receiver is represented as 3 HID devices: one keyboard
>> descriptor, one mouse descriptor and one miscellaneous/control
>> descriptor (containing touch surface data). My plan was to intercept
>> mouse clicks on the mouse descriptor and look at what part of touch
>> surface (left/right) has the most pressure and, if needed, swap the
>> click to a right click.
>>
>> Any hints on how to do this in userspace? Of course I could hack up
>> xf86-input-evdev, but I'd like to do this at the highest possible
>> layer, ie the input subsystem.
> The application you describe could well be implemented in the driver
> you submitted; a simple handling of the MT data resulting in normal
> input events.

Yes, that was my initial idea. But as I had the impression that an 
userspace solution was preferred, I wondered how to solve that.

-- 
Maurus Cuelenaere

