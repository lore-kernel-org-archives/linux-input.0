From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/3] HID: wacom - Bamboo pen-only tablet does not support PAD
Date: Tue, 18 Nov 2014 13:29:16 -0800
Message-ID: <1416346156-11346-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36142 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbaKRV31 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Nov 2014 16:29:27 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so1157699pab.19
        for <linux-input@vger.kernel.org>; Tue, 18 Nov 2014 13:29:27 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

Bamboo models do not support HID_DG_CONTACTMAX. Plus, Bamboo pen-only
has touch descriptor. This leads to some complications in the code.

This patch also fixes duplicated PAD interfeaces for Intuos Pen
models.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by:  Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
v2: updated with Benjamin's comments
---
 drivers/hid/wacom.h     |  2 +-
 drivers/hid/wacom_sys.c | 25 +++++++++++++++----------
 drivers/hid/wacom_wac.c |  9 +++++++--
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 0cc5344..7db4328 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -140,7 +140,7 @@ extern const struct hid_device_id wacom_ids[];
 
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
 void wacom_setup_device_quirks(struct wacom_features *features);
-int wacom_setup_input_capabilities(struct input_dev *input_dev,
+int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 				   struct wacom_wac *wacom_wac);
 int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 				       struct wacom_wac *wacom_wac);
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8593047..68b6cd6 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -192,9 +192,15 @@ static void wacom_usage_mapping(struct hid_device *hdev,
 	if (!pen && !finger)
 		return;
 
-	if (finger && !features->touch_max)
-		/* touch device at least supports one touch point */
-		features->touch_max = 1;
+	/*
+	 * Bamboo models do not support HID_DG_CONTACTMAX.
+	 * And, Bamboo Pen only descriptor contains touch.
+	 */
+	if (features->type != BAMBOO_PT) {
+		/* ISDv4 touch devices at least supports one touch point */
+		if (finger && !features->touch_max)
+			features->touch_max = 1;
+	}
 
 	switch (usage->hid) {
 	case HID_GD_X:
@@ -1151,13 +1157,12 @@ static int wacom_register_inputs(struct wacom *wacom)
 	if (!input_dev || !pad_input_dev)
 		return -EINVAL;
 
-	error = wacom_setup_input_capabilities(input_dev, wacom_wac);
-	if (error)
-		return error;
-
-	error = input_register_device(input_dev);
-	if (error)
-		return error;
+	error = wacom_setup_pentouch_input_capabilities(input_dev, wacom_wac);
+	if (!error) {
+		error = input_register_device(input_dev);
+		if (error)
+			return error;
+	}
 
 	error = wacom_setup_pad_input_capabilities(pad_input_dev, wacom_wac);
 	if (error) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 792569c..6bed92c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2029,7 +2029,7 @@ static void wacom_abs_set_axis(struct input_dev *input_dev,
 	}
 }
 
-int wacom_setup_input_capabilities(struct input_dev *input_dev,
+int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 				   struct wacom_wac *wacom_wac)
 {
 	struct wacom_features *features = &wacom_wac->features;
@@ -2243,6 +2243,9 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 				__clear_bit(ABS_X, input_dev->absbit);
 				__clear_bit(ABS_Y, input_dev->absbit);
 				__clear_bit(BTN_TOUCH, input_dev->keybit);
+
+				/* PAD is setup by wacom_setup_pad_input_capabilities later */
+				return 1;
 			}
 		} else if (features->device_type == BTN_TOOL_PEN) {
 			__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
@@ -2441,7 +2444,9 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	case INTUOSHT:
 	case BAMBOO_PT:
 		/* pad device is on the touch interface */
-		if (features->device_type != BTN_TOOL_FINGER)
+		if ((features->device_type != BTN_TOOL_FINGER) ||
+		    /* Bamboo Pen only tablet does not have pad */
+		    ((features->type == BAMBOO_PT) && !features->touch_max))
 			return -ENODEV;
 
 		__clear_bit(ABS_MISC, input_dev->absbit);
-- 
1.9.1

