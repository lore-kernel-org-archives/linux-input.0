From: Casey Harkins <caseyharkins@gmail.com>
Subject: Thinkpad E420s (E220s and X220) trackpoint detection
Date: Tue, 6 Nov 2012 19:31:16 -0600
Message-ID: <CACe=8k-FK=rE3f3Up_M76-d7fh5MifUaKRnv4MaYoTcFFj86gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38017 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab2KGBbQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Nov 2012 20:31:16 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so818664pbb.19
        for <linux-input@vger.kernel.org>; Tue, 06 Nov 2012 17:31:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

I am still experiencing the trackpoint detection issue raised in
kernel.org bug #33292:

    https://bugzilla.kernel.org/show_bug.cgi?id=33292

The bug was closed as OBSOLETE, with a request to re-open and post a
summary to this list if anyone is still experiencing the bug. While a
few people have responded that they are still experiencing the bug, I
was unable to locate any summary posted to this list as requested.

On at least these three Thinkpad models (E420s, E220s and X220), the
trackpoint (and the physical mouse buttons) operate as a passthrough
device through the Synaptics touchpad. On boot or waking from sleep,
the trackpoint device frequently is not detected, rendering the
trackpoint (and physical buttons) useless. Based on previous
discussions on this list, it appears that this is accompanied by a
failure to get a proper id (PSMOUSE_CMD_GETID):

    http://www.spinics.net/lists/linux-input/msg14846.html

At a seemingly random interval, the touchpad will freeze for a few
seconds, then both the touchpad and trackpoint become usable. When
this occurs, it is accompanied by a "lost synchronization" message
from the synaptics driver. Moving the trackpoint repeatedly sometimes
appears to shorten this random interval.

On the X220, the bios allows for the touchpad to be disabled, which
apparently causes the trackpoint to be consistently detected. The
E420s and E220s do not have this bios option. Specifying
psmouse.proto=bare will also consistently allow the trackpoint to be
detected, but disables any advanced touchpad features (such as two
finger scrolling).

In addition to the kernel.org bug report, this issue was reported as
launchpad bug #787738:

    https://bugs.launchpad.net/ubuntu/+source/linux/+bug/787738

The issue has also been discussed in at least two threads on this list:

    X220: http://www.spinics.net/lists/linux-input/msg14828.html
    E220s: http://www.spinics.net/lists/linux-input/msg17550.html


What is needed to try and track the cause down and either fix the bug
(if the problem is on the kernel side), or work-around the issue if it
is a hardware issue (can we force the resynchronization)?

Thanks,

-casey
