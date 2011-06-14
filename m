From: simon@mungewell.org
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Tue, 14 Jun 2011 19:16:37 -0400
Message-ID: <2756a7d8aa2d4187bb6d39577b69c097.squirrel@host171.canaca.com>
References: <2502891.N5kVV5at6b@qosmio-x300>
    <e8b1518b49c3c1dd660270df5e512705.squirrel@host171.canaca.com>
    <7710689.O2quS97bHe@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:41691 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab1FNXQl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 19:16:41 -0400
In-Reply-To: <7710689.O2quS97bHe@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>
Cc: simon@mungewell.org, jkosina@suse.cz, linux-input@vger.kernel.org


>> 2. http://wiibrew.org/wiki/Logitech_USB_steering_wheel
>
> Sure, but please don't take it like I have some inside knowledge of
> Logitech FF implementation. I've been given few bits of useful
> information, the rest I figured out from sniffed USB communication.

Of course, we're all in the same boat of trying to figure it out. Our only
help is that Engineers are lazy and often reuse stuff they've done before.


> It looks like the stiffness coeff actually
> wraps around, because 0 = no stiffness, 7 = max stiffness, 8 = low
> stiffness, 15 = max
> stiffness. It'd be interesting to see if you can observe the same behavior
> on the Wii wheel.

Yes the Wii Wheel only does 0-7 and then loops too...

I actually meant to quantify the force produced and purchased a torque
meter, but its range wasn't low enough to be useful so I took it back. I
think I can do something with a 'luggage scale' pulling at a tangent to
the wheel so will give that a try.

My reverse engineer technique had a python-hid script so that I could
throw packets directly at the wheel to produce specific force setups. I
need to port this to python-libusb (as python-hid is dead), but that
should be relatively simple and can forward off list to anyone who wants a
copy.

>
> As for the other FF effects, I guess these are things like "rumble" etc.
> I'm planning to look into it more when I'll have some extra free time.

If you figure codes out, I'd love to try them against my Wheel. I did have
a PS3 Driving Force Wireless, but fried it's micro whilst I was hooking
the BusPirate up to it.

This would work under Windows and playback various effects in test mode as
you pushed buttons - if anybody can grab some USB logs of this I can
attempt to parse them for the codes....

Simon

