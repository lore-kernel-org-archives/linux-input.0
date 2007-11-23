From: Roel Kluin <12o3l@tiscali.nl>
Subject: mouse trouble
Date: Fri, 23 Nov 2007 20:27:07 +0100
Message-ID: <4747298B.8040208@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out1.tiscali.nl ([195.241.79.176]:60576 "EHLO
	smtp-out1.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbXKWT1Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Nov 2007 14:27:16 -0500
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out1.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IveBG-000469-OY
	for <linux-input@vger.kernel.org>; Fri, 23 Nov 2007 20:27:15 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Once in every so often boots I end up in X without a functioning mouse. A reboot
will fix it, but I have had this behavior for a few years now and still no clue
what the origin of the problem is. dmesg reports as it does normally:

PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
mice: PS/2 mouse device common for all mice

killing and restarting X and/or gpm doesn't work.

I have been storing dmesgs at failures:
2007-08-29
2007-09-15
2007-11-23
(I boot twice a day on average)

As you can see, today I had one. I also made a copy of my /proc and /sys
directories. (I am guessing /proc was not needed)maybe any info can still be
extracted?

Is there anything that I could do to provide more info when this occurs next
time?

Thanks

Roel

