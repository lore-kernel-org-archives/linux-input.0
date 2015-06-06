From: Raimund Roth <raimundmroth@googlemail.com>
Subject: [PATCH] input: adding Surface Power Cover
Date: Sun, 07 Jun 2015 00:49:58 +0200
Message-ID: <55737916.40206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34251 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbbFFWuB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Jun 2015 18:50:01 -0400
Received: by wgv5 with SMTP id 5so78523868wgv.1
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2015 15:50:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org

Adding support for the Microsoft Surface Pro Power Cover, Patch was
tested on Debian, Keyboard and Trackpad are fully working, both when
plugged in at boot or hotplugged.

Signed-off-by: Raimund Roth <raimundmroth@gmail.gom>
---
diff -uprN linux-4.1-rc6-vanilla/drivers/hid/hid-core.c
linux-4.1-rc6-wip/drivers/hid/hid-core.c
--- linux-4.1-rc6-vanilla/drivers/hid/hid-core.c	2015-06-01
04:01:07.000000000 +0200
+++ linux-4.1-rc6-wip/drivers/hid/hid-core.c	2015-06-06
23:31:58.373034000 +0200
@@ -706,7 +706,8 @@ static void hid_scan_collection(struct h

 	if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
 	    (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP) &&
+	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP ||
+	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
 	    hid->group == HID_GROUP_MULTITOUCH)
 		hid->group = HID_GROUP_GENERIC;

@@ -1901,6 +1902,7 @@ static const struct hid_device_id hid_ha
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
USB_DEVICE_ID_MS_TYPE_COVER_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
USB_DEVICE_ID_MS_TYPE_COVER_3_JP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
diff -uprN linux-4.1-rc6-vanilla/drivers/hid/hid-ids.h
linux-4.1-rc6-wip/drivers/hid/hid-ids.h
--- linux-4.1-rc6-vanilla/drivers/hid/hid-ids.h	2015-06-01
04:01:07.000000000 +0200
+++ linux-4.1-rc6-wip/drivers/hid/hid-ids.h	2015-06-06
23:32:05.100989000 +0200
@@ -673,6 +673,7 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
 #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07dc
 #define USB_DEVICE_ID_MS_TYPE_COVER_3_JP 0x07dd
+#define USB_DEVICE_ID_MS_POWER_COVER     0x07da

 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
diff -uprN linux-4.1-rc6-vanilla/drivers/hid/hid-microsoft.c
linux-4.1-rc6-wip/drivers/hid/hid-microsoft.c
--- linux-4.1-rc6-vanilla/drivers/hid/hid-microsoft.c	2015-06-01
04:01:07.000000000 +0200
+++ linux-4.1-rc6-wip/drivers/hid/hid-microsoft.c	2015-06-06
23:32:19.016894000 +0200
@@ -280,6 +280,8 @@ static const struct hid_device_id ms_dev
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
USB_DEVICE_ID_MS_TYPE_COVER_3_JP),
 		.driver_data = MS_HIDINPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER),
+		.driver_data = MS_HIDINPUT },

 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
USB_DEVICE_ID_MS_PRESENTER_8K_BT),
 		.driver_data = MS_PRESENTER },
diff -uprN linux-4.1-rc6-vanilla/drivers/hid/usbhid/hid-quirks.c
linux-4.1-rc6-wip/drivers/hid/usbhid/hid-quirks.c
--- linux-4.1-rc6-vanilla/drivers/hid/usbhid/hid-quirks.c	2015-06-01
04:01:07.000000000 +0200
+++ linux-4.1-rc6-wip/drivers/hid/usbhid/hid-quirks.c	2015-06-06
23:32:37.876767000 +0200
@@ -89,6 +89,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3,
HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP,
HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER,
HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL,
HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750,
HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE,
HID_QUIRK_NO_INIT_REPORTS },
