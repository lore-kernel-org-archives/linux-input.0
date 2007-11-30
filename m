From: Roel Kluin <12o3l@tiscali.nl>
Subject: mouse bug
Date: Fri, 30 Nov 2007 15:06:27 +0100
Message-ID: <475018E3.5090606@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:50862 "EHLO
	smtp-out0.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbXK3OGb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Nov 2007 09:06:31 -0500
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out0.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1Iy6Vi-0002fF-5L
	for <linux-input@vger.kernel.org>; Fri, 30 Nov 2007 15:06:30 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Once in every so often boots I end up in X without a functioning mouse. A
pointer is shown, but glued to the center of the screen. A reboot will fix it,
but I have had this behavior for a few years now and still no clue what the
origin of the problem is - dmesg reports as it does normally:

PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
mice: PS/2 mouse device common for all mice

killing and restarting X and/or gpm doesn't return control over the mouse.

I have been storing dmesgs at failures:
2007-08-29
2007-09-15
2007-11-23
(I boot twice a day on average)

As you can see, I had one recently. This time I also made a copy of my /proc
and /sys directories. (I am guessing /proc was not really needed) maybe any info
can still be extracted?

Where can I look, what can I do to find the source of this problem? Is there
anything that I should do to obtain more info when this occurs nexttime?

Thanks

Roel


