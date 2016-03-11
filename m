From: Slava Bacherikov <slava@bacher09.org>
Subject: [PATCH] HID: microsoft: Add ID for MS Wireless Comfort Keyboard
Date: Fri, 11 Mar 2016 18:57:24 +0200
Message-ID: <1457715444-18097-1-git-send-email-slava@bacher09.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vinnica.in ([71.19.158.239]:44322 "EHLO vinnica.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932596AbcCKRHc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2016 12:07:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Slava Bacherikov <slava@bacher09.org>

Microsoft Wireless Comfort Keyboard has vendor specific My Favorites
1-5 keys. Linux already supports this buttons on other MS keyboards by
MS_ERGONOMY quirk. So apply MS_ERGONOMY quirk to USB PID 0x00e3
(Microsoft Wireless Optical Desktop Receiver 3.0A). After this
My Favorites 1..5 keys will be reported as KEY_F14..KEY_F15 events.

Signed-off-by: Slava Bacherikov <slava@bacher09.org>
---
 drivers/hid/hid-core.c      | 1 +
 drivers/hid/hid-ids.h       | 1 +
 drivers/hid/hid-microsoft.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9ce9dfe..beaf100 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1890,6 +1890,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD_BOOTLOADER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K_JP) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7ce93d9..037e924 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -668,6 +668,7 @@
 #define USB_DEVICE_ID_MS_NE7K		0x071d
 #define USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K	0x0730
 #define USB_DEVICE_ID_MS_COMFORT_MOUSE_4500	0x076c
+#define USB_DEVICE_ID_MS_COMFORT_KEYBOARD 0x00e3
 #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
 #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index af935eb..43ac73b 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -280,6 +280,8 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP),
 		.driver_data = MS_HIDINPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_KEYBOARD),
+		.driver_data = MS_ERGONOMY},
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
 		.driver_data = MS_PRESENTER },
-- 
2.1.4

