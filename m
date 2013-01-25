From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 12/25] HID: multitouch: optimize Lumio panels
Date: Fri, 25 Jan 2013 14:22:57 +0100
Message-ID: <1359120190-18281-13-git-send-email-benjamin.tissoires@gmail.com>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Not very different in terms of processing time. However, this
uniformizes the handling of devices.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 8b07b6b..d66c4d7 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -120,6 +120,7 @@ struct mt_device {
 #define MT_CLS_INRANGE_CONTACTNUMBER		0x0009
 #define MT_CLS_ALWAYS_TRUE			0x000a
 #define MT_CLS_CONTACT_ID			0x0011
+#define MT_CLS_MINUS_ONE			0x0012
 
 /* vendor specific classes */
 #define MT_CLS_3M				0x0101
@@ -186,6 +187,10 @@ static struct mt_class mt_classes[] = {
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
 			MT_QUIRK_SLOT_IS_CONTACTID },
+	{ .name = MT_CLS_MINUS_ONE,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE },
 
 	/*
 	 * vendor specific classes
@@ -1101,10 +1106,10 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_LG_MULTITOUCH) },
 
 	/* Lumio panels */
-	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
+	{ .driver_data = MT_CLS_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_LUMIO,
 			USB_DEVICE_ID_CRYSTALTOUCH) },
-	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
+	{ .driver_data = MT_CLS_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_LUMIO,
 			USB_DEVICE_ID_CRYSTALTOUCH_DUAL) },
 
-- 
1.8.1
