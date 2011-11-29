From: Daniel Manrique <daniel.manrique@canonical.com>
Subject: Bug: touchpad unresponsive after resume from S3 (psmouse driver)
Date: Tue, 29 Nov 2011 11:26:19 -0500
Message-ID: <4ED507AB.6040905@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55058 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755953Ab1K2Q0V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 11:26:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hello,

I apologize for sending this bug report directly; with the kernel.org bugtracker
down I was told this was the best option for the time being. If this is not
correct, could you please let me know of a good place to submit this bug report?

I have several Dell laptops with Synaptics touchpads, particularly a group of
Vostro V13 systems. On these, after a suspend/resume cycle, the touchpad
(Synaptics) is unresponsive; a workaround is to rmmod psmouse; modprobe psmouse.

This was first reported on kernel 2.6.38, although I think the issue has been
present from as early as 2.6.32. I verified it for sure with Ubuntu 2.6.38
kernels, 3.0.0 kernels, and a 3.2.0 kernel from the development release, as well
as a "mainline" 3.1.0-rc10 kernel.

Since this problem was seen on Ubuntu, it's filed on the Launchpad bug tracker.
The first report I can find is this one:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/715267

This includes a series of log messages I don't see on my systems. I then filed
this other bug:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/879650

The last one contains specific information from one of my systems (a Vostro V13).

I'd really appreciate any help or guidance on how to solve this problem. If you
need me to collect any information or run any tests on these machines, please
don't hesitate to ask, these systems are primarily used for testing.

Thanks in advance,

- Daniel Manrique
  daniel.manrique@canonical.com
