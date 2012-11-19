From: Jan-Matthias Braun <jan_braun@gmx.net>
Subject: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Mon, 19 Nov 2012 12:58:57 +0100
Message-ID: <8159607.SRZZrRIPNF@orthese>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:34780 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751827Ab2KSME5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Nov 2012 07:04:57 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dear List,

using the current (Linux v2.6.7) hid-multitouch driver I have the problem, that the touchscreen works fine after a fresh boot, but after a suspend the touchscreen does not come back to live and I am asking for assistance to get this working. As I can reproduce this problem on a standard tty device without X (see below) I am suspecting a driver problem, but I might as well be wrong.

The device in question is the Touchscreen of a Dell Inspron Duo convertable, a USB device with id 0eef:725e (D-WAV Scientific Co., Ltd), found and registered as an input device by the kernel as
[    6.931638] usb 4-1: Manufacturer: eGalax Inc.
[   16.186272] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input/input10
[   16.187162] hid-multitouch 0003:0EEF:725E.0001: input,hiddev0,hidraw0: USB HID v2.10 Pointer
		 [eGalax Inc. USB TouchController] on usb-0000:00:1d.2-1/input0

I have tested the behaviour with and without X11. Without X11 I was using a standard tty and using cat on the input device.
After boot the input device gives lot of output while touching the screen, after resume the device stays silent.

I have this problem since moving to hid-multitouch for handling this device.

I will be happy to test and supply more information. Thanks a lot for looking into this,

Jan-Matthias Braun

PS: As I am not subscribed to the mailing list, please CC me.
