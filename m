From: Matt Helsley <matt.helsley@gmail.com>
Subject: [PATCH] Fix genius pensketch 12x9 tablet
Date: Fri, 12 Dec 2008 22:42:28 -0800
Message-ID: <1229150548.11171.6.camel@molly>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:33777 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbYLMGmf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Dec 2008 01:42:35 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1681146wfd.4
        for <linux-input@vger.kernel.org>; Fri, 12 Dec 2008 22:42:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

The Genius PenSketch 12x9 tablet has a puck (labeled a
"Tablet Mouse") in addition to a pen. Without registering a quirk
the tablet appears to be a single input device that reports the
wrong axis information in /proc/bus/input/devices, and sends
incorrect events (e.g. ABS_Z instead of ABS_Y). This information
confuses the X evdev driver and makes the device impossible to
use.

The quirk fixes events and splits the device into multiple input
event devices so that at least the puck is useful.

Signed-off-by: Matt Helsley <matt.helsley@gmail.com>
---
NOTE: xinput lists the puck but not the pen. I've been using a
python script to verify the contents of the events independently
of X and, as far as I can tell, the remaining problems are in X
itself.

Tested on: 2.6.24, 2.6.25, 2.6.27, 2.6.28-rc8

Index: linux-2.6.28-rc8/drivers/hid/hid-ids.h
===================================================================
--- linux-2.6.28-rc8.orig/drivers/hid/hid-ids.h	2008-12-12 16:27:19.000000000 -0800
+++ linux-2.6.28-rc8/drivers/hid/hid-ids.h	2008-12-12 16:30:35.000000000 -0800
@@ -386,6 +386,9 @@
 #define USB_VENDOR_ID_TURBOX		0x062a
 #define USB_DEVICE_ID_TURBOX_KEYBOARD	0x0201
 
+#define USB_VENDOR_ID_UCLOGIC		0x5543
+#define USB_DEVICE_ID_UCLOGIC_TABLET_PF1209	0x0042
+
 #define USB_VENDOR_ID_VERNIER		0x08f7
 #define USB_DEVICE_ID_VERNIER_LABPRO	0x0001
 #define USB_DEVICE_ID_VERNIER_GOTEMP	0x0002
Index: linux-2.6.28-rc8/drivers/hid/usbhid/hid-quirks.c
===================================================================
--- linux-2.6.28-rc8.orig/drivers/hid/usbhid/hid-quirks.c	2008-12-12 17:22:59.000000000 -0800
+++ linux-2.6.28-rc8/drivers/hid/usbhid/hid-quirks.c	2008-12-12 17:30:44.000000000 -0800
@@ -54,6 +54,7 @@
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 


