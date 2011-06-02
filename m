From: simon@mungewell.org
Subject: Re: [PATCH v2] hid: Fix Logitech Driving Force Pro wheel
Date: Thu, 2 Jun 2011 12:35:31 -0400
Message-ID: <2b85316d7925dad6c55672d7d9738e18.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:36258 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab1FBQfd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Jun 2011 12:35:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Bauer <michael@m-bauer.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

> Changes from initial patch:
> - shorten comment (removed original descriptor)
> - optimized new descriptor (simpler and shorter)

Concept looks go to me, but I'm getting
--
simon@ubuntu:~/linux-2.6$ patch -p 1 <
../Downloads/v2-hid-Fix-Logitech-Driving-Force-Pro-wheel.patch
patching file drivers/hid/hid-lg.c
patch: **** malformed patch at line 91: USB_DEVICE_ID_LOGITECH_G25_WHEEL), --

Looks like word wrap has been applied to the patch.

It also fails to patch chunk 3 against 3.0rc1 as the G27 wheel has been
added.
--
--- drivers/hid/hid-lg.c    2011-05-19 06:06:34.000000000 +0200
+++ drivers/hid/hid-lg.c    2011-05-30 21:49:51.535184784 +0200
@@ -450,7 +522,7 @@
    { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_G25_WHEEL),
        .driver_data = LG_FF },
    { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_DFP_WHEEL),
-       .driver_data = LG_FF },
+       .driver_data = LG_NOGET | LG_FF },
    { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,

--
    { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_G25_WHEEL),
        .driver_data = LG_FF },
    { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_G27_WHEEL),
        .driver_data = LG_FF },
    { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_DFP_WHEEL),
        .driver_data = LG_FF },
--

All that said it appears to build (don't have this wheel to test) and have
it in a git archive if you'd like be to spin a fixed patch for you.

Simon




