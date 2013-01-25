From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 17/25] HID: multitouch: fix protocol for Cando 2087:0a02
Date: Fri, 25 Jan 2013 14:23:02 +0100
Message-ID: <1359120190-18281-18-git-send-email-benjamin.tissoires@gmail.com>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Cando 2087:0a02 was broken, this fixes it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6db423f..9d8228a 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -122,6 +122,7 @@ struct mt_device {
 #define MT_CLS_CONTACT_ID			0x0011
 #define MT_CLS_MINUS_ONE			0x0012
 #define MT_CLS_DUAL_CONTACT_ID			0x0013
+#define MT_CLS_DUAL_CONTACT_NUMBER		0x0014
 
 /* vendor specific classes */
 #define MT_CLS_3M				0x0101
@@ -197,6 +198,11 @@ static struct mt_class mt_classes[] = {
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
 			MT_QUIRK_SLOT_IS_CONTACTID,
 		.maxcontacts = 2 },
+	{ .name = MT_CLS_DUAL_CONTACT_NUMBER,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_SLOT_IS_CONTACTNUMBER,
+		.maxcontacts = 2 },
 
 	/*
 	 * vendor specific classes
@@ -969,7 +975,7 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
 		MT_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
-	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
+	{ .driver_data = MT_CLS_DUAL_CONTACT_NUMBER,
 		MT_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_MULTI_TOUCH_10_1) },
 	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
-- 
1.8.1
