From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH v2 7/9] HID: multitouch: fix protocol for Cando 2087:0a02
Date: Thu, 31 Jan 2013 17:22:29 +0100
Message-ID: <1359649351-11092-8-git-send-email-benjamin.tissoires@gmail.com>
References: <1359649351-11092-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359649351-11092-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Cando 2087:0a02 was broken, this fixes it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 71daf57..f106e90 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -115,6 +115,7 @@ struct mt_device {
 #define MT_CLS_DUAL_NSMU_CONTACTID		0x0008
 #define MT_CLS_INRANGE_CONTACTNUMBER		0x0009
 #define MT_CLS_ALWAYS_TRUE			0x000a
+#define MT_CLS_DUAL_CONTACT_NUMBER		0x0010
 
 /* vendor specific classes */
 #define MT_CLS_3M				0x0101
@@ -177,6 +178,11 @@ static struct mt_class mt_classes[] = {
 	{ .name = MT_CLS_ALWAYS_TRUE,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE },
+	{ .name = MT_CLS_DUAL_CONTACT_NUMBER,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_SLOT_IS_CONTACTNUMBER,
+		.maxcontacts = 2 },
 
 	/*
 	 * vendor specific classes
@@ -947,7 +953,7 @@ static const struct hid_device_id mt_devices[] = {
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
