From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [RFC] Microsoft Touch Mouse driver [was: Re: your mail]
Date: Tue, 07 Feb 2012 13:07:18 +0100
Message-ID: <4F3113F6.6000403@gmail.com>
References: <BROWNM3h3vLgAusVxON00000cfa@brown.emailprod.vodafone.se> <20120125132612.GA3890@polaris.bitmath.org> <4F200D14.80702@gmail.com> <20120125150035.GA4222@polaris.bitmath.org> <20120130072732.GA1855@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37503 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960Ab2BGMHW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Feb 2012 07:07:22 -0500
Received: by bkcjm19 with SMTP id jm19so5488197bkc.19
        for <linux-input@vger.kernel.org>; Tue, 07 Feb 2012 04:07:20 -0800 (PST)
In-Reply-To: <20120130072732.GA1855@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

Op 25-01-12 14:26, Henrik Rydberg schreef:
>> +
>> +struct mstm_state {
>> +	bool advance_flag;
>> +	int x;
>> +	int y;
>> +	unsigned char last_timestamp;
>> +	unsigned char data[MSTM_DATA_WIDTH][MSTM_DATA_HEIGHT];
>> +};
> The ability to simply send an "input screen" would be perfect
> here. This device may be on the border of what can/should be handled
> via input events. A memory mapped driver, uio-based or something
> similar, could be an option.

Op 30-01-12 08:27, Dmitry Torokhov schreef:
> On Wed, Jan 25, 2012 at 04:00:35PM +0100, Henrik Rydberg wrote:
>>
>>>> One possible option could be to use the
>>>> slots, but only send ABS_MT_TOUCH_MAJOR or ABS_MT_PRESSURE, nothing
>>>> else. The device would (rightfully) not be recognized as MT since the
>>>> position is missing, all data would be available for processing in
>>>> userspace, and bandwidth would be minimized since there could only be
>>>> so many changes coming in per millisecond.
>>> So how does userspace then finds out where these pressure points are
>>> located?
>>> Or do you mean to just dump all data to user space (15 * 13 *
>>> sizeof(ABS_MT_PRESSURE value) + overhead)?
>> Having each pressure point represented by one slot id was the idea.
>> Userspace would have to know how the points are mapped, of
>> course. Still not overly happy about the general fit, though. Dmitry?
> I am having doubts that this device, as it is, is suitable for input
> interface; I really do not think that bastardizing slot IDs is good
> idea. Unless we move all computation necessary to identify individual
> contacts into the kernel (and then use standard MT protocol), I'd
> recommend looking into hidraw + uinput solution.

Ok, so it's pretty clear the consensus is that there should be a 
different interface to push the data to user space.
My initial reaction is V4L, as the data is basically a stream of 
monochrome frames, this kind of fits the video description. Also, this 
could be of some benefit to all those emulate-multi-touch-using-webcam 
projects.
Other options I see are mmap on the input device, creating a separate 
(char?) device, UIO or even having the whole thing in userspace.

However, there's one tiny hack I'd like to have and I'm unsure whether 
this can be done from userspace: as the mouse has only one physical push 
button, it can't distinguish between left, middle or right click.
Obviously, it can do this based on the information it gathers from its 
touch surface, however the firmware has only the following dumb 
implementation: when only one finger is present on the right part of the 
surface, assume right click; otherwise assume left click. This means 
that you need to lift your left finger when performing a right click.

Now, the receiver is represented as 3 HID devices: one keyboard 
descriptor, one mouse descriptor and one miscellaneous/control 
descriptor (containing touch surface data). My plan was to intercept 
mouse clicks on the mouse descriptor and look at what part of touch 
surface (left/right) has the most pressure and, if needed, swap the 
click to a right click.

Any hints on how to do this in userspace? Of course I could hack up 
xf86-input-evdev, but I'd like to do this at the highest possible layer, 
ie the input subsystem.

-- 
Maurus Cuelenaere

