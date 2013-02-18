From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/3] Introduce driver for IMS PCU devices
Date: Mon, 18 Feb 2013 11:05:54 -0800
Message-ID: <1361214357-21205-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:49555 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab3BRTGM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Feb 2013 14:06:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Chris Healy <chealy@imsco-us.com>

IMS, an In Flight Entertainment System provider, has a number of seat displays
Linux. To interact with the user IMS uses a passenger Control Unit (PCU), which
communicates with Rave Display Unit via a USB interface.

Originally large part of the PCU handling was done from userspace and so it
presents itself as two distinct USB devices: one is a standard HID mouse and
another is a CDC-ACM modem-like device. The latter one was used by IMS
userspace software to get the status of all PCU buttons and perform other
operations. However the fact that with the custom userspace handling the device
resides outside of the standard input framework hinders use of the device
elsewhere in the stack and this patch series attempts to fix this issue by
creating a proper input driver for the device. If the device was purely input
device it would also be possible to use cdc-acm + userspace solution and loop
the input events back into the kernel via uinput, however the device also
allows control its key backlight, which exported as a standard LED device, and
this functionality is not available through uinput (nor should it be).
Firmware update is also implemented via the standard "request_firmware"
mechanism.

The patch series consists of 3 parts:

- a patch adding new keycodes needed for PCU;
- the driver itself;
- a patch to cdc-acm driver to ignore PCU devices when ims-pcu driver is
  enabled.

Thanks.

-- 
Dmitry
