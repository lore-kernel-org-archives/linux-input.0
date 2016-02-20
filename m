From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: How to get the kernel to emulate force feedback events?
Date: Sat, 20 Feb 2016 20:28:45 +0100
Message-ID: <56C8BE6D.7050409@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:35959 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012AbcBTT2s (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Feb 2016 14:28:48 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id D6F6343B79
	for <linux-input@vger.kernel.org>; Sat, 20 Feb 2016 20:28:46 +0100 (CET)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id NIRlTvcdBnIV for <linux-input@vger.kernel.org>;
	Sat, 20 Feb 2016 20:28:45 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

if I plug my Xbox 360 controller and run fftest on it, then the 
following force feedback modes are listed as supported:

| Force feedback effects types: Periodic, Rumble, Gain,
| Force feedback periodic effects: Square, Triangle, Sine,

If I have a look at the driver itself, then it actually only supports 
FF_RUMBLE:

https://github.com/torvalds/linux/blob/master/drivers/input/joystick/xpad.c#L1054
https://github.com/torvalds/linux/blob/master/drivers/input/joystick/xpad.c#L966

So somewhere in the kernel source there has to be some kind of built-in 
force feedback effect emulation...

If I do the same in an uinput driver (only report "FF_RUMBLE" as being 
supported), then fftest only shows this one effect to be supported by 
the device. The "kernel side emulation" does not kick in...

The kernel documentation 
(https://www.kernel.org/doc/Documentation/input/ff.txt) says:

| Note: In most cases you should use FF_PERIODIC instead of FF_RUMBLE.
|       All devices that support FF_RUMBLE support FF_PERIODIC (square,
|       triangle, sine) and the other way around.

But what could be the mistake, which allowed me to create a device 
driver which actually only supports FF_RUMBLE? Are there any special 
driver parameters that have to be present, so the kernel side emulation 
gets active?

Thanks in advance.

Best regards,

Manuel
