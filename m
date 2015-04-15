From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/4] HID: wacom: move all quirks to wacom_setup_device_quirks
Date: Wed, 15 Apr 2015 16:53:54 -0700
Message-ID: <1429142034-16832-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35911 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719AbbDOXyA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 19:54:00 -0400
Received: by pdea3 with SMTP id a3so69980691pde.3
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2015 16:53:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

It makes probe routine easy to follow.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom.h     |  2 +-
 drivers/hid/wacom_sys.c | 39 +--------------------------------------
 drivers/hid/wacom_wac.c | 30 +++++++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index ad7318d..0f189c2 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -132,7 +132,7 @@ static inline void wacom_schedule_work(struct wacom_wac *wacom_wac)
 extern const struct hid_device_id wacom_ids[];
 
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
-void wacom_setup_device_quirks(struct wacom_features *features);
+void wacom_setup_device_quirks(struct wacom *wacom);
 int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 				   struct wacom_wac *wacom_wac);
 int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4c5d924..ca30eab 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1504,44 +1504,7 @@ static int wacom_probe(struct hid_device *hdev,
 	/* Retrieve the physical and logical size for touch devices */
 	wacom_retrieve_hid_descriptor(hdev, features);
 
-	/*
-	 * Intuos5 has no useful data about its touch interface in its
-	 * HID descriptor. If this is the touch interface (PacketSize
-	 * of WACOM_PKGLEN_BBTOUCH3), override the table values.
-	 */
-	if (features->type >= INTUOS5S && features->type <= INTUOSHT) {
-		if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
-			features->device_type = BTN_TOOL_FINGER;
-
-			features->x_max = 4096;
-			features->y_max = 4096;
-		} else {
-			features->device_type = BTN_TOOL_PEN;
-		}
-	}
-
-	/*
-	 * Same thing for Bamboo 3rd gen.
-	 */
-	if ((features->type == BAMBOO_PT) &&
-	    (features->pktlen == WACOM_PKGLEN_BBTOUCH3) &&
-	    (features->device_type == BTN_TOOL_PEN)) {
-		features->device_type = BTN_TOOL_FINGER;
-
-		features->x_max = 4096;
-		features->y_max = 4096;
-	}
-
-	/*
-	 * Same thing for Bamboo PAD
-	 */
-	if (features->type == BAMBOO_PAD)
-		features->device_type = BTN_TOOL_FINGER;
-
-	if (hdev->bus == BUS_BLUETOOTH)
-		features->quirks |= WACOM_QUIRK_BATTERY;
-
-	wacom_setup_device_quirks(features);
+	wacom_setup_device_quirks(wacom);
 
 	/* set unit to "100th of a mm" for devices not reported by HID */
 	if (!features->unit) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 69c7df7..952ed4c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2164,8 +2164,9 @@ static void wacom_setup_intuos(struct wacom_wac *wacom_wac)
 	input_set_abs_params(input_dev, ABS_THROTTLE, -1023, 1023, 0, 0);
 }
 
-void wacom_setup_device_quirks(struct wacom_features *features)
+void wacom_setup_device_quirks(struct wacom *wacom)
 {
+	struct wacom_features *features = &wacom->wacom_wac.features;
 
 	/* touch device found but size is not defined. use default */
 	if (features->device_type == BTN_TOOL_FINGER && !features->x_max) {
@@ -2173,6 +2174,33 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 		features->y_max = 1023;
 	}
 
+	/*
+	 * Intuos5/Pro and Bamboo 3rd gen have no useful data about its
+	 * touch interface in its HID descriptor. If this is the touch
+	 * interface (PacketSize of WACOM_PKGLEN_BBTOUCH3), override the
+	 * tablet values.
+	 */
+	if ((features->type >= INTUOS5S && features->type <= INTUOSHT) ||
+		(features->type == BAMBOO_PT)) {
+		if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
+			features->device_type = BTN_TOOL_FINGER;
+
+			features->x_max = 4096;
+			features->y_max = 4096;
+		} else {
+			features->device_type = BTN_TOOL_PEN;
+		}
+	}
+
+	/*
+	 * Same thing for Bamboo PAD
+	 */
+	if (features->type == BAMBOO_PAD)
+		features->device_type = BTN_TOOL_FINGER;
+
+	if (wacom->hdev->bus == BUS_BLUETOOTH)
+		features->quirks |= WACOM_QUIRK_BATTERY;
+
 	/* quirk for bamboo touch with 2 low res touches */
 	if (features->type == BAMBOO_PT &&
 	    features->pktlen == WACOM_PKGLEN_BBTOUCH) {
-- 
1.9.1

