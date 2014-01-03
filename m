From: Dylan Paul Thurston <dpthurst@indiana.edu>
Subject: Another ALPS touchpad
Date: Thu, 2 Jan 2014 23:59:15 -0500
Message-ID: <20140103045915.GB30008@whitehail.bostoncoop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from whitehail.bostoncoop.net ([74.50.63.164]:41878 "EHLO
	bostoncoop.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbaACFzt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Jan 2014 00:55:49 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I just bought a HP Revolve 810 G1 laptop. (This is a convertible
ultrabook, normally sold with Windows 8.) The touchpad seems to be
another ALPS touchpad, not yet recognized by the kernel; I tried the
Debian package of 3.12 and linux-next-20131224 compiled from
source. Without the proper driver, it is unusuably sensisitive,
registering clicks when my hands are well away from the touchpad.
The relevant line from dmesg is

[    2.776630] psmouse serio4: alps: Unknown ALPS touchpad: E7=73 03 0a, EC=88 b3 18

Should I try hacking drivers/input/mouse/alps.c to see if one of the
existing protocols works?

Thanks,
	Dylan Thurston
	dpt@bostoncoop.net
