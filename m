From: GeneralTouch <aroundight77@gmail.com>
Subject: [PATCH 1/1] hid:Fix problem on GeneralTouch multi-touchscreen
Date: Fri, 28 Sep 2012 10:18:59 +0800
Message-ID: <1348798739-2950-1-git-send-email-aroundight77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, yxhma <yxhma@163.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Xianhan Yu <aroundight77@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Xianhan Yu <aroundight77@gmail.com>

Fix the touch-up no response problem on GeneralTouch twofingers touchscreen and modify the driver for new GeneralTouch PWT touchscreen.

Signed-off-by: Xianhan Yu <aroundight77@gmail.com>
---
 drivers/hid/hid-ids.h        |    1 +
 drivers/hid/hid-multitouch.c |   20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1dcb76f..a6d5890 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -305,6 +305,7 @@
 
 #define USB_VENDOR_ID_GENERAL_TOUCH	0x0dfc
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0003
+#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS 0x0100
 
 #define USB_VENDOR_ID_GLAB		0x06c2
 #define USB_DEVICE_ID_4_PHIDGETSERVO_30	0x0038
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 59c8b5c..7aece16 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -115,6 +115,8 @@ struct mt_device {
 #define MT_CLS_EGALAX_SERIAL			0x0104
 #define MT_CLS_TOPSEED				0x0105
 #define MT_CLS_PANASONIC			0x0106
+#define MT_CLS_GENERALTOUCH_TWOFINGERS		0x0107
+#define MT_CLS_GENERALTOUCH_PWT_TENFINGERS	0x0108
 
 #define MT_DEFAULT_MAXCONTACT	10
 
@@ -215,7 +217,18 @@ static struct mt_class mt_classes[] = {
 	{ .name = MT_CLS_PANASONIC,
 		.quirks = MT_QUIRK_NOT_SEEN_MEANS_UP,
 		.maxcontacts = 4 },
-
+	{ .name	= MT_CLS_GENERALTOUCH_TWOFINGERS,
+		.quirks	= MT_QUIRK_NOT_SEEN_MEANS_UP |
+			MT_QUIRK_VALID_IS_INRANGE |
+			MT_QUIRK_SLOT_IS_CONTACTNUMBER,
+		.maxcontacts = 2
+	},
+	{ .name	= MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
+		.quirks	= MT_QUIRK_NOT_SEEN_MEANS_UP |
+			MT_QUIRK_SLOT_IS_CONTACTNUMBER,
+		.maxcontacts = 10
+	},
+
 	{ }
 };
 
@@ -893,9 +906,12 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_ELO_TS2515) },
 
 	/* GeneralTouch panel */
-	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
+	{ .driver_data = MT_CLS_GENERALTOUCH_TWOFINGERS,
 		MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
 			USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS) },
+	{ .driver_data = MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
+		MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
+			USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS) },
 
 	/* Gametel game controller */
 	{ .driver_data = MT_CLS_DEFAULT,
-- 
1.7.9.5
