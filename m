From: Ari Savolainen <ari.m.savolainen@gmail.com>
Subject: [PATCH] HID: fix horizontal wheel for ms comfort mouse 4500
Date: Mon, 11 Jul 2011 21:42:52 +0300
Message-ID: <1310409772-6289-1-git-send-email-ari.m.savolainen@gmail.com>
References: <alpine.LNX.2.00.1107111445360.11049@pobox.suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:42848 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758047Ab1GKSm6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 14:42:58 -0400
Received: by fxd18 with SMTP id 18so4246793fxd.11
        for <linux-input@vger.kernel.org>; Mon, 11 Jul 2011 11:42:57 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1107111445360.11049@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Microsoft comfort mouse 4500 report descriptor contains duplicate
usages for horizontal wheel. This patch fixes the wrong mapping
caused by that.

Signed-off-by: Ari Savolainen <ari.m.savolainen@gmail.com>

---
 drivers/hid/hid-ids.h       |    1 +
 drivers/hid/hid-microsoft.c |   26 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a756ee6..92de0d5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -472,6 +472,7 @@
 #define USB_DEVICE_ID_MS_LK6K		0x00f9
 #define USB_DEVICE_ID_MS_PRESENTER_8K_BT	0x0701
 #define USB_DEVICE_ID_MS_PRESENTER_8K_USB	0x0713
+#define USB_DEVICE_ID_MS_COMFORT_MOUSE_4500	0x076c
 
 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 0f6fc54..8f31362 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -23,11 +23,12 @@
 
 #include "hid-ids.h"
 
-#define MS_HIDINPUT	0x01
-#define MS_ERGONOMY	0x02
-#define MS_PRESENTER	0x04
-#define MS_RDESC	0x08
-#define MS_NOGET	0x10
+#define MS_HIDINPUT		0x01
+#define MS_ERGONOMY		0x02
+#define MS_PRESENTER		0x04
+#define MS_RDESC		0x08
+#define MS_NOGET		0x10
+#define MS_DUPLICATE_USAGES	0x20
 
 /*
  * Microsoft Wireless Desktop Receiver (Model 1028) has
@@ -109,6 +110,18 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
+static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+
+	if (quirks & MS_DUPLICATE_USAGES)
+		clear_bit(usage->code, *bit);
+
+	return 0;
+}
+
 static int ms_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -181,6 +194,8 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_PRESENTER },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0),
 		.driver_data = MS_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
+		.driver_data = MS_DUPLICATE_USAGES },
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
 		.driver_data = MS_PRESENTER },
@@ -193,6 +208,7 @@ static struct hid_driver ms_driver = {
 	.id_table = ms_devices,
 	.report_fixup = ms_report_fixup,
 	.input_mapping = ms_input_mapping,
+	.input_mapped = ms_input_mapped,
 	.event = ms_event,
 	.probe = ms_probe,
 };
-- 
1.7.4.1

The previous mail contained extra newlines inserted by gmail web
client. I'm resending the patch with "git send-email".

Ari
