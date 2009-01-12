From: Michael Tokarev <mjt@tls.msk.ru>
Subject: new modular hid?
Date: Mon, 12 Jan 2009 23:05:09 +0300
Message-ID: <496BA275.1080504@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.33.150]:24578 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754960AbZALUFM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 15:05:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hello.

I tried to run a new (2.6.28) kernel today, to discover that
my keyboard does not work anymore.  After investigation it
turned out the keyboard is now handled by a hid-sub-driver,
hid-bright, and it does not work if this (mostly one-liner)
driver module is not loaded.

udev/m.i.t works fine, it's the initramfs which is broken.
I.e., there's no keyboard during initramfs stage, only when
udev runs and loads everything - as much as i hate it, it
becomes more and more mandatory, but that's another story.

Before 2.6.28, I used to include usbhid into initramfs.
Now, it's not sufficient anymore.

So I've two questions:

1) which drivers to include into ramfs and load for a
 "generic USB keyboard" to work?  Maybe from now on one
 have to use usbkbd instead of usbhid?  I just want to
 be able to do some rescue stuff before actual system
 startup in case a system does not boot for whatever
 reason (root fs is corrupt or wrong raid1 replacement
 disk or whatever).

2) why all those tiny "subdrivers" in the first place?
 I looked into several of them, and they're mostly sort
 of quirks or some additional features or additional key
 (re)mapping.  Why can't it all be done in the main driver
 instead, just like it is done for PCI bus for example?
 The amount of real-work code is tiny, modules are much
 bigger - both the resulting .ko files and all the
 init/exit wrappers in .c files...

Thanks!

/mjt
