From: "J. Domburg" <jeroen@spritesmods.com>
Subject: Re: T440s Synaptics clickpad: lost sync / KBC bad data
Date: Mon, 6 Jan 2014 11:25:11 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1401061114400.6346@icf1.fcevgrfzbqf.pbz>
References: <alpine.DEB.2.00.1312151507560.6449@icf1.fcevgrfzbqf.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from spritesmods.com ([188.40.123.50]:46605 "EHLO spritesmods.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbaAFKZQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Jan 2014 05:25:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by spritesmods.com (Postfix) with ESMTP id D272E800001
	for <linux-input@vger.kernel.org>; Mon,  6 Jan 2014 11:25:11 +0100 (CET)
In-Reply-To: <alpine.DEB.2.00.1312151507560.6449@icf1.fcevgrfzbqf.pbz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

A last message about this issue, to help future people who find this 
data: In my case, it seems the problem was the hardware. For me the 
problem got increasingly worse, and also showed itself during a Win7 
installation and Win8 rescue session. Strangely, Windows 8 itself was less 
affected by the issue; maybe it has drivers that reset the Clickpad IC 
much quicker than Linux and the Windows installers.

With that data, I managed to convince Lenovo Support to exchange the 
clickpad hardware. (This means exchanging the complete keyboard bezel 
which means almost completely disassembling the machine, by the way...) 
The new clickpad has been working without _any_ lost sync byte for about a 
week now, so I'm a happy camper.

In the meantime, some other people have contacted me with the same issues. 
As far as I'm aware, they haven't solved it yet either by software or 
hardware exchange, but it may mean this is an issue a small amount of 
T440s's may have in general.

Anyway, sorry for the spam.

Cheers,
Jeroen

On Sun, 15 Dec 2013, J. Domburg wrote:

> Hello everyone,
>
> I hope I'm at the right address here with my problems. If not, please do 
> point me in the correct direction.
>
> I have a Lenovo Thinkpad T440s with a Synaptics clickpad and an IBM 
> trackpoint in it:
>
> input: PS/2 Synaptics TouchPad as 
> /devices/platform/i8042/serio1/input/input120
> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 
> 0xd001a3/0x940300/0x127c00, board id: 2668, fw id: 1293989
> psmouse serio1: synaptics: serio: Synaptics pass-through port at 
> isa0060/serio1/input0
> input: SynPS/2 Synaptics TouchPad as 
> /devices/platform/i8042/serio1/input/input123
> psmouse serio34: alps: Unknown ALPS touchpad: E7=10 00 64, EC=10 00 64
> psmouse serio34: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3 
> input: TPPS/2 IBM TrackPoint as 
> /devices/platform/i8042/serio1/serio34/input/input124
>
> The problem is that the trackpoint behaves incredibly erratic, sometimes 
> working correctly for minutes at a time, sometimes just jumping around and 
> many times just hanging. I need to remove and re-insert the psmouse module to 
> solve that. Alongside this behaviour, my kernel log also is getting spammed 
> with messages like:
>
> psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse serio1: TouchPad at isa0060/serio1/input0 - driver resynced.
> and psmouse serio1: bad data from KBC - timeout
>
> What I've tried:
> - Tried the kernel options i8042.nomux=1 and i8042.reset=1
> - Disable acpi by passing acpi=off to the kernel
> - Disabled CPU frequency scaling
> - Trying other protocols, e.g. by doing modprobe psmouse proto=imps or 
> proto=bare
> - Switching from vanilla 3.12 kernel to both the latest&greatest kernel from 
> Linus' Git and an antique 3.1.0 kernel
> - Turning on i8042.debug. To my untrained eye, it looks like bytes of PS/2 
> data are just disappearing when the 'lost sync' messages kick in. I can give 
> an example of that if needed.
>
> Strangely, the symptoms have been getting worse in the 10 days I've had this 
> machine: from the first few days with no trouble to today with the mouse 
> crapping out almost once every ten seconds or so. I would say it's a DOA and 
> claim my warranty, if not frustratingly the machine works perfectly fine in 
> Windows 8, with no touchpad trouble at all.
>
> I'm willing to try things on this machine, run patches or take any hint in 
> what I can change to get this working; if it helps I can even poke an 
> oscilloscope at the PS2 lines. Not having a working touchpad or touchpoint is 
> getting a bit frustrating...
>
> Cheers,
> Jeroen
>
>
>
>
