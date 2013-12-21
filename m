From: Heinz Wiesinger <HMWiesinger@liwjatan.at>
Subject: Re: T440s Synaptics clickpad: lost sync / KBC bad data
Date: Sat, 21 Dec 2013 21:59:37 +0000 (UTC)
Message-ID: <loom.20131221T224832-537@post.gmane.org>
References: <alpine.DEB.2.00.1312151507560.6449@icf1.fcevgrfzbqf.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40421 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192Ab3LUWF3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Dec 2013 17:05:29 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1VuUfQ-000120-4R
	for linux-input@vger.kernel.org; Sat, 21 Dec 2013 23:05:04 +0100
Received: from 31-151-200-123.dynamic.upc.nl ([31.151.200.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sat, 21 Dec 2013 23:05:04 +0100
Received: from HMWiesinger by 31-151-200-123.dynamic.upc.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sat, 21 Dec 2013 23:05:04 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

J. Domburg <jeroen <at> spritesmods.com> writes:
> 
> Hello everyone,
> 
> I hope I'm at the right address here with my problems. If not, please do 
> point me in the correct direction.
> 
> I have a Lenovo Thinkpad T440s with a Synaptics clickpad and an IBM 
> trackpoint in it:
> 
> input: PS/2 Synaptics TouchPad as 
/devices/platform/i8042/serio1/input/input120
> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 
0xd001a3/0x940300/0x127c00,
> board id: 2668, fw id: 1293989
> psmouse serio1: synaptics: serio: Synaptics pass-through port at 
isa0060/serio1/input0
> input: SynPS/2 Synaptics TouchPad as 
/devices/platform/i8042/serio1/input/input123
> psmouse serio34: alps: Unknown ALPS touchpad: E7=10 00 64, EC=10 00 64
> psmouse serio34: trackpoint: IBM TrackPoint firmware: 0x0e, 
> buttons: 3/3 input: TPPS/2 IBM TrackPoint as 
/devices/platform/i8042/serio1/serio34/input/input124
> 
> The problem is that the trackpoint behaves incredibly erratic, sometimes 
> working correctly for minutes at a time, sometimes just jumping around and 
> many times just hanging. I need to remove and re-insert the psmouse module 
> to solve that. Alongside this behaviour, my kernel log also is getting 
> spammed with messages like:
> 
> psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse serio1: TouchPad at isa0060/serio1/input0 - driver resynced.
> and 
> psmouse serio1: bad data from KBC - timeout
> 
> What I've tried:
> - Tried the kernel options i8042.nomux=1 and i8042.reset=1
> - Disable acpi by passing acpi=off to the kernel
> - Disabled CPU frequency scaling
> - Trying other protocols, e.g. by doing modprobe psmouse proto=imps or 
> proto=bare
> - Switching from vanilla 3.12 kernel to both the latest&greatest kernel 
> from Linus' Git and an antique 3.1.0 kernel
> - Turning on i8042.debug. To my untrained eye, it looks like bytes of PS/2 
> data are just disappearing when the 'lost sync' messages kick in. I can 
> give an example of that if needed.
> 
> Strangely, the symptoms have been getting worse in the 10 days I've had 
> this machine: from the first few days with no trouble to today with the 
> mouse crapping out almost once every ten seconds or so. I would say it's a 
> DOA and claim my warranty, if not frustratingly the machine works 
> perfectly fine in Windows 8, with no touchpad trouble at all.
> 
> I'm willing to try things on this machine, run patches or take any hint in 
> what I can change to get this working; if it helps I can even poke an 
> oscilloscope at the PS2 lines. Not having a working touchpad or 
> touchpoint is getting a bit frustrating...

I'm experiencing exactly the same issue. I have my T440s now for a bit more 
than two weeks. No issues with the touchpad until today when it suddenly 
started acting up and I now see messages like these in dmesg:

[ 2244.631822] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 
0x1e2b1, caps: 0xd001a3/0x940300/0x127c00, board id: 2668, fw id: 1293989
[ 2244.631830] psmouse serio1: synaptics: serio: Synaptics pass-through port 
at isa0060/serio1/input0
[ 2244.668037] input: SynPS/2 Synaptics TouchPad as 
/devices/platform/i8042/serio1/input/input34
[ 2247.518110] psmouse serio8: alps: Unknown ALPS touchpad: E7=10 00 64, 
EC=10 00 64
[ 2248.807888] psmouse serio8: trackpoint: IBM TrackPoint firmware: 0x0e, 
buttons: 3/3
[ 2249.016659] input: TPPS/2 IBM TrackPoint as 
/devices/platform/i8042/serio1/serio8/input/input35
[ 2254.649940] psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync 
at byte 1
[ 2254.651179] psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync 
at byte 1
[ 2254.652358] psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync 
at byte 1
[ 2254.653594] psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync 
at byte 1
[ 2254.663943] psmouse serio1: TouchPad at isa0060/serio1/input0 - driver 
resynced.
[ 2254.997536] psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync 
at byte 4
[ 2254.998663] psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync 
at byte 1
[ 2254.999790] psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync 
at byte 1
[ 2255.000973] psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync 
at byte 1
[ 2255.002107] psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync 
at byte 1
[ 2255.002111] psmouse serio1: issuing reconnect request
[ 2255.131535] psmouse serio1: synaptics: Unable to query device.
[ 2255.598324] psmouse serio1: synaptics: device claims to have extended 
capability 0x0c, but I'm not able to read it.
[ 2255.643293] psmouse serio1: synaptics: Unable to initialize device.
[ 2255.767364] input: PS/2 Synaptics TouchPad as 
/devices/platform/i8042/serio1/input/input37
[ 2255.953314] psmouse serio1: synaptics: Unable to query device.

Same as Jeroen, I'm willing to try anything that might help resolve this 
situation.

Grs,
Heinz

