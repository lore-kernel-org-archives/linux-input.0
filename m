From: Forest Bond <forest@forestbond.com>
Subject: [PATCH] HID: hid-multitouch: add support for SiS panels
Date: Mon, 21 Oct 2013 12:38:49 -0400
Message-ID: <20131021163849.GC30240@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:55617 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3JUQyi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Oct 2013 12:54:38 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

From: Forest Bond <forest.bond@rapidrollout.com>

Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
---
 drivers/hid/Kconfig             |    1 +
 drivers/hid/hid-core.c          |    2 ++
 drivers/hid/hid-ids.h           |    4 ++++
 drivers/hid/hid-multitouch.c    |    8 ++++++++
 drivers/hid/usbhid/hid-quirks.c |    2 ++
 5 files changed, 17 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c91d547..5448c02 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -453,6 +453,7 @@ config HID_MULTITOUCH
 	  - Pixcir dual touch panels
 	  - Quanta panels
 	  - eGalax dual-touch panels, including the Joojoo and Wetab tablets
+	  - SiS multitouch panels
 	  - Stantum multitouch panels
 	  - Touch International Panels
 	  - Unitec Panels
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index dfcd67f..1c4a442 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1815,6 +1815,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_PS1000) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS2_TOUCH, USB_DEVICE_ID_SIS9200_TOUCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS2_TOUCH, USB_DEVICE_ID_SIS817_TOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9cbc7ab..c511d4d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -744,6 +744,10 @@
 #define USB_VENDOR_ID_SIGMATEL		0x066F
 #define USB_DEVICE_ID_SIGMATEL_STMP3780	0x3780
 
+#define USB_VENDOR_ID_SIS2_TOUCH	0x0457
+#define USB_DEVICE_ID_SIS9200_TOUCH	0x9200
+#define USB_DEVICE_ID_SIS817_TOUCH	0x0817
+
 #define USB_VENDOR_ID_SKYCABLE			0x1223
 #define	USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER	0x3F07
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5e5fe1b..b18a943 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1284,6 +1284,14 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,
 			USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008) },
 
+	/* SiS panels */
+	{ .driver_data = MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_SIS2_TOUCH,
+		USB_DEVICE_ID_SIS9200_TOUCH) },
+	{ .driver_data = MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_SIS2_TOUCH,
+		USB_DEVICE_ID_SIS817_TOUCH) },
+
 	/* Stantum panels */
 	{ .driver_data = MT_CLS_CONFIDENCE,
 		MT_USB_DEVICE(USB_VENDOR_ID_STANTUM,
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 0734552..ae5c634 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -84,6 +84,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_REALTEK, USB_DEVICE_ID_REALTEK_READER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_SIS2_TOUCH, USB_DEVICE_ID_SIS9200_TOUCH, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_SIS2_TOUCH, USB_DEVICE_ID_SIS817_TOUCH, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_1, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2, HID_QUIRK_NOGET },
-- 
1.7.9.5
