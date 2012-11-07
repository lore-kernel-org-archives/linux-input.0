From: Keith Lawson <lawsonk@libertas-tech.com>
Subject: Re: Thinkpad E420s (E220s and X220) trackpoint detection
Date: Wed, 07 Nov 2012 15:54:25 -0500
Message-ID: <1b0e88beb3fe5a2983d99db90feb7ba9@www.nowhere.ca>
References: <CACe=8k-FK=rE3f3Up_M76-d7fh5MifUaKRnv4MaYoTcFFj86gw@mail.gmail.com>
Reply-To: <lawsonk@libertas-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from client-208-92-234-63.sevenl.net ([208.92.234.63]:43864 "EHLO
	can.libertas-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab2KGUy3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Nov 2012 15:54:29 -0500
In-Reply-To: <CACe=8k-FK=rE3f3Up_M76-d7fh5MifUaKRnv4MaYoTcFFj86gw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Casey Harkins <caseyharkins@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On 06.11.2012 20:31, Casey Harkins wrote:

> I am still experiencing the trackpoint detection issue raised in
> kernel.org bug #33292:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=33292
>
> The bug was closed as OBSOLETE, with a request to re-open and post a
> summary to this list if anyone is still experiencing the bug. While a
> few people have responded that they are still experiencing the bug, I
> was unable to locate any summary posted to this list as requested.
>
> On at least these three Thinkpad models (E420s, E220s and X220), the
> trackpoint (and the physical mouse buttons) operate as a passthrough
> device through the Synaptics touchpad. On boot or waking from sleep,
> the trackpoint device frequently is not detected, rendering the
> trackpoint (and physical buttons) useless. Based on previous
> discussions on this list, it appears that this is accompanied by a
> failure to get a proper id (PSMOUSE_CMD_GETID):
>
> http://www.spinics.net/lists/linux-input/msg14846.html
>
> At a seemingly random interval, the touchpad will freeze for a few
> seconds, then both the touchpad and trackpoint become usable. When
> this occurs, it is accompanied by a "lost synchronization" message
> from the synaptics driver. Moving the trackpoint repeatedly sometimes
> appears to shorten this random interval.
>
> On the X220, the bios allows for the touchpad to be disabled, which
> apparently causes the trackpoint to be consistently detected. The
> E420s and E220s do not have this bios option. Specifying
> psmouse.proto=bare will also consistently allow the trackpoint to be
> detected, but disables any advanced touchpad features (such as two
> finger scrolling).
>
> In addition to the kernel.org bug report, this issue was reported as
> launchpad bug #787738:
>
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/787738
>
> The issue has also been discussed in at least two threads on this 
> list:
>
> X220: http://www.spinics.net/lists/linux-input/msg14828.html
> E220s: http://www.spinics.net/lists/linux-input/msg17550.html
>
> What is needed to try and track the cause down and either fix the bug
> (if the problem is on the kernel side), or work-around the issue if 
> it
> is a hardware issue (can we force the resynchronization)?
>

I'm having this exact same issue on a Lenovo L430 but logged it against 
bug #48161[1] thinking it was something to do with the elantech 
touchpad. Now that I've read this bug #33292 it looks like I logged my 
data against the wrong bug.

This is also the issue my recent message[2] to the mailing list was 
about. I'm happy to test and debug but it's way beyond my kernel hacking 
skills to provide a patch.

1: https://bugzilla.kernel.org/show_bug.cgi?id=48161
2: http://www.spinics.net/lists/linux-input/msg23374.html

> Thanks,
>
> -casey
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
