From: Alistair Leslie-Hughes <leslie_alistair@hotmail.com>
Subject: [PATCH] Handle more microsoft keyboards types.
Date: Sat, 31 Jan 2015 19:09:53 +1100
Message-ID: <BLU437-SMTP5899ACD24B27B6961B4476933E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from blu004-omc4s28.hotmail.com ([65.55.111.167]:60251 "EHLO
	BLU004-OMC4S28.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750995AbbAaILU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 03:11:20 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz

Fixes https://bugzilla.kernel.org/show_bug.cgi?id=52841

---
 drivers/hid/hid-core.c      | 4 ++++
 drivers/hid/hid-ids.h       | 4 ++++
 drivers/hid/hid-microsoft.c | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8b63879..1629c8a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1861,6 +1861,10 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_4K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_600) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9243359..e7f25c7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -643,12 +643,16 @@
 #define USB_DEVICE_ID_SIDEWINDER_GV	0x003b
 #define USB_DEVICE_ID_MS_OFFICE_KB	0x0048
 #define USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0 0x009d
+#define USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K 0x00b4
 #define USB_DEVICE_ID_MS_NE4K		0x00db
 #define USB_DEVICE_ID_MS_NE4K_JP	0x00dc
 #define USB_DEVICE_ID_MS_LK6K		0x00f9
 #define USB_DEVICE_ID_MS_PRESENTER_8K_BT	0x0701
 #define USB_DEVICE_ID_MS_PRESENTER_8K_USB	0x0713
+#define USB_DEVICE_ID_MS_DIGITAL_MEDIA_4K      0x071d
 #define USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K	0x0730
+#define USB_DEVICE_ID_MS_DIGITAL_MEDIA_600     0x0750
+#define USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1    0x0732
 #define USB_DEVICE_ID_MS_COMFORT_MOUSE_4500	0x076c
 #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
 #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index cacda43..3b57636 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -260,6 +260,8 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB),
 		.driver_data = MS_ERGONOMY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K),
+		.driver_data = MS_ERGONOMY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K),
 		.driver_data = MS_ERGONOMY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K_JP),
@@ -268,8 +270,14 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_ERGONOMY | MS_RDESC },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_USB),
 		.driver_data = MS_PRESENTER },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_4K),
+		.driver_data = MS_ERGONOMY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K),
 		.driver_data = MS_ERGONOMY | MS_RDESC_3K },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_600),
+		.driver_data = MS_ERGONOMY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1),
+		.driver_data = MS_ERGONOMY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0),
 		.driver_data = MS_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
-- 
2.1.4

