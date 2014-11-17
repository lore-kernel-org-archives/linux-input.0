From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom - Bamboo pen only tablet does not support PAD
Date: Mon, 17 Nov 2014 13:45:55 -0800
Message-ID: <1416260755-13635-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:59947 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbaKQVqI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Nov 2014 16:46:08 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so8274194pad.17
        for <linux-input@vger.kernel.org>; Mon, 17 Nov 2014 13:46:06 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Bamboo models do not support HID_DG_CONTACTMAX. We should not rely
on that description to decide touch_max for them. Plus, no Bamboo
device supports single touch.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_sys.c |  4 ++--
 drivers/hid/wacom_wac.c | 30 ++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8593047..46147b4 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -192,8 +192,8 @@ static void wacom_usage_mapping(struct hid_device *hdev,
 	if (!pen && !finger)
 		return;
 
-	if (finger && !features->touch_max)
-		/* touch device at least supports one touch point */
+	if (finger && !features->touch_max && (features->type != BAMBOO_PT))
+		/* ISDv4 touch devices at least supports one touch point */
 		features->touch_max = 1;
 
 	switch (usage->hid) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 586b240..fc9b492 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2402,7 +2402,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPS:
 		/* touch interface does not have the pad device */
 		if (features->device_type != BTN_TOOL_PEN)
-			return 1;
+			goto no_pad;
 
 		for (i = 0; i < 7; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
@@ -2447,22 +2447,36 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	case BAMBOO_PT:
 		/* pad device is on the touch interface */
 		if (features->device_type != BTN_TOOL_FINGER)
-			return 1;
+			goto no_pad;
 
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
-		__set_bit(BTN_LEFT, input_dev->keybit);
-		__set_bit(BTN_FORWARD, input_dev->keybit);
-		__set_bit(BTN_BACK, input_dev->keybit);
-		__set_bit(BTN_RIGHT, input_dev->keybit);
+		/* Bamboo Pen only tablet does not have pad */
+		if ((features->type != BAMBOO_PT) || 
+		    ((features->type == BAMBOO_PT) && features->touch_max)) {
+			__set_bit(BTN_LEFT, input_dev->keybit);
+			__set_bit(BTN_FORWARD, input_dev->keybit);
+			__set_bit(BTN_BACK, input_dev->keybit);
+			__set_bit(BTN_RIGHT, input_dev->keybit);
+		} else
+			goto no_pad;
 
 		break;
 
 	default:
-		/* no pad supported */
-		return 1;
+		goto no_pad;
 	}
 	return 0;
+
+no_pad:
+	input_dev->evbit[0] &= ~BIT_MASK(EV_KEY) & ~BIT_MASK(EV_ABS);
+	__clear_bit(ABS_MISC, input_dev->absbit);
+	__clear_bit(ABS_X, input_dev->absbit);
+	__clear_bit(ABS_Y, input_dev->absbit);
+	__clear_bit(BTN_STYLUS, input_dev->keybit);
+	
+	return 1;
+
 }
 
 static const struct wacom_features wacom_features_0x00 =
-- 
1.9.1

