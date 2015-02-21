From: Jakub Sitnicki <jsitnicki@gmail.com>
Subject: [PATCH] HID: microsoft: Add ID for NE7K wireless keyboard
Date: Sat, 21 Feb 2015 20:51:08 +0100
Message-ID: <1424548268-11021-1-git-send-email-jsitnicki@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46208 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbBUTvb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Feb 2015 14:51:31 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Sitnicki <jsitnicki@gmail.com>

Microsoft Natural Wireless Ergonomic Keyboard 7000 has special My
Favorites 1..5 keys which are handled through a vendor-defined usage
page (0xff05).

Apply MS_ERGONOMY quirks handling to USB PID 0x071d (Microsoft Microsoft
2.4GHz Transceiver V1.0) so that the My Favorites 1..5 keys are reported
as KEY_F14..18 events.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=52841
Signed-off-by: Jakub Sitnicki <jsitnicki@gmail.com>
---
 drivers/hid/hid-core.c      | 1 +
 drivers/hid/hid-ids.h       | 1 +
 drivers/hid/hid-microsoft.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8b63879..13320c1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1855,6 +1855,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K_JP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE7K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_LK6K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_USB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9243359..4e77ce1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -648,6 +648,7 @@
 #define USB_DEVICE_ID_MS_LK6K		0x00f9
 #define USB_DEVICE_ID_MS_PRESENTER_8K_BT	0x0701
 #define USB_DEVICE_ID_MS_PRESENTER_8K_USB	0x0713
+#define USB_DEVICE_ID_MS_NE7K		0x071d
 #define USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K	0x0730
 #define USB_DEVICE_ID_MS_COMFORT_MOUSE_4500	0x076c
 #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index cacda43..b962df4 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -264,6 +264,8 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_ERGONOMY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K_JP),
 		.driver_data = MS_ERGONOMY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE7K),
+		.driver_data = MS_ERGONOMY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_LK6K),
 		.driver_data = MS_ERGONOMY | MS_RDESC },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_USB),
-- 
2.1.0

