From: Antonio Orefice <aorefice77@gmail.com>
Subject: [PATCH 2/2] HID: add support for force feedback in 'Thrustmaster F430
 Force Feedback' steering wheel
Date: Wed, 17 Nov 2010 09:44:43 +0100
Message-ID: <AANLkTikY+LfS-j5+dMzjh6z0cY_E5uV0uBdzDLY9kNmS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37479 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288Ab0KQIoo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Nov 2010 03:44:44 -0500
Received: by iwn35 with SMTP id 35so1849271iwn.19
        for <linux-input@vger.kernel.org>; Wed, 17 Nov 2010 00:44:43 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This patch add supports for force feedback Thrustmaster "F430 Force
Feedback" steering wheel.
I just added the right usb device id to the existing hid-tmff driver
by Zinx Verituse and to the exceptions list in hid-core.c
After the patches, the device correctly supports constant forces.
For example, the wheel will move correctly accordingly to the mouse
position when using ffmvforce from ffutils; ffset is able to set
autocenter strenght and ff gain.

I tested the patches over a 2.6.35 kernel, but the changes are so
minimal that they should work flawlessy on newer ones.

--- hid-core.c-2.6.35	2010-11-16 13:54:29.563224822 +0100
+++ hid-core.c	2010-11-16 13:46:46.576195469 +0100
@@ -1374,6 +1374,7 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb653) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb65a) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TWINHAN, USB_DEVICE_ID_TWINHAN_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
