From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 6/8] HID: wacom: generic: add vendor defined touch
Date: Wed, 25 Jan 2017 12:08:40 -0800
Message-ID: <1485374922-3417-7-git-send-email-skomra@gmail.com>
References: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33537 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbdAYUJi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 15:09:38 -0500
Received: by mail-pg0-f65.google.com with SMTP id 194so20547696pgd.0
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 12:09:38 -0800 (PST)
In-Reply-To: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, benjamin.tissoires@redhat.com, pinglinux@gmail.com, killertofu@gmail.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>, Aaron Skomra <aaron.skomra@wacom.com>

Add vendor defined touch to support the second generation
Intuos Pro. Previously all generic Wacom devices used
true HID to report their touch.

Signed-off-by: Aaron Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom.h     |  1 +
 drivers/hid/wacom_sys.c | 13 ++++++++++---
 drivers/hid/wacom_wac.c | 22 +++++++++++++++++-----
 drivers/hid/wacom_wac.h | 16 +++++++++++++++-
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 8d8fe30..0e7b840 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -219,4 +219,5 @@ enum led_brightness wacom_leds_brightness_get(struct wacom_led *led);
 struct wacom_led *wacom_led_find(struct wacom *wacom, unsigned int group,
 				 unsigned int id);
 struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur);
+int wacom_equivalent_usage(int usage);
 #endif
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4a70783..a4884e7 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -112,11 +112,12 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_features *features = &wacom->wacom_wac.features;
 	struct hid_data *hid_data = &wacom->wacom_wac.hid_data;
+	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	u8 *data;
 	int ret;
 	int n;
 
-	switch (usage->hid) {
+	switch (equivalent_usage) {
 	case HID_DG_CONTACTMAX:
 		/* leave touch_max as is if predefined */
 		if (!features->touch_max) {
@@ -325,8 +326,14 @@ static void wacom_post_parse_hid(struct hid_device *hdev,
 	if (features->type == HID_GENERIC) {
 		/* Any last-minute generic device setup */
 		if (features->touch_max > 1) {
-			input_mt_init_slots(wacom_wac->touch_input, wacom_wac->features.touch_max,
-				    INPUT_MT_DIRECT);
+			if (features->device_type & WACOM_DEVICETYPE_DIRECT)
+				input_mt_init_slots(wacom_wac->touch_input,
+						    wacom_wac->features.touch_max,
+						    INPUT_MT_DIRECT);
+			else
+				input_mt_init_slots(wacom_wac->touch_input,
+						    wacom_wac->features.touch_max,
+						    INPUT_MT_POINTER);
 		}
 	}
 }
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 636c4a1..2eeaa05 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1599,7 +1599,7 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 	return 0;
 }
 
-static int wacom_equivalent_usage(int usage)
+int wacom_equivalent_usage(int usage)
 {
 	if ((usage & HID_USAGE_PAGE) == WACOM_HID_UP_WACOMDIGITIZER) {
 		int subpage = (usage & 0xFF00) << 8;
@@ -1626,6 +1626,16 @@ static int wacom_equivalent_usage(int usage)
 		return subpage | subusage;
 	}
 
+	if ((usage & HID_USAGE_PAGE) == WACOM_HID_UP_WACOMTOUCH) {
+		int subpage = (usage & 0xFF00) << 8;
+		int subusage = (usage & 0xFF);
+
+		if (subpage == HID_UP_UNDEFINED)
+			subpage = WACOM_HID_SP_DIGITIZER;
+
+		return subpage | subusage;
+	}
+
 	return usage;
 }
 
@@ -2218,8 +2228,10 @@ static void wacom_wac_finger_pre_report(struct hid_device *hdev,
 
 		for (j = 0; j < field->maxusage; j++) {
 			struct hid_usage *usage = &field->usage[j];
+			unsigned int equivalent_usage =
+				wacom_equivalent_usage(usage->hid);
 
-			switch (usage->hid) {
+			switch (equivalent_usage) {
 			case HID_GD_X:
 			case HID_GD_Y:
 			case HID_DG_WIDTH:
@@ -2228,7 +2240,7 @@ static void wacom_wac_finger_pre_report(struct hid_device *hdev,
 			case HID_DG_INRANGE:
 			case HID_DG_INVERT:
 			case HID_DG_TIPSWITCH:
-				hid_data->last_slot_field = usage->hid;
+				hid_data->last_slot_field = equivalent_usage;
 				break;
 			case HID_DG_CONTACTCOUNT:
 				hid_data->cc_report = report->id;
@@ -2283,8 +2295,8 @@ void wacom_wac_usage_mapping(struct hid_device *hdev,
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct wacom_features *features = &wacom_wac->features;
 
-	/* currently, only direct devices have proper hid report descriptors */
-	features->device_type |= WACOM_DEVICETYPE_DIRECT;
+	if (WACOM_DIRECT_DEVICE(field))
+		features->device_type |= WACOM_DEVICETYPE_DIRECT;
 
 	if (WACOM_PAD_FIELD(field))
 		wacom_wac_pad_usage_mapping(hdev, field, usage);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index dac95ba..da38f77 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -101,6 +101,7 @@
 #define WACOM_HID_SP_DIGITIZER          0x000d0000
 #define WACOM_HID_SP_DIGITIZERINFO      0x00100000
 #define WACOM_HID_WD_DIGITIZER          (WACOM_HID_UP_WACOMDIGITIZER | 0x01)
+#define WACOM_HID_WD_PEN                (WACOM_HID_UP_WACOMDIGITIZER | 0x02)
 #define WACOM_HID_WD_SENSE              (WACOM_HID_UP_WACOMDIGITIZER | 0x36)
 #define WACOM_HID_WD_DIGITIZERFNKEYS    (WACOM_HID_UP_WACOMDIGITIZER | 0x39)
 #define WACOM_HID_WD_SERIALHI           (WACOM_HID_UP_WACOMDIGITIZER | 0x5c)
@@ -137,6 +138,12 @@
 #define WACOM_HID_UP_G11                0xff110000
 #define WACOM_HID_G11_PEN               (WACOM_HID_UP_G11 | 0x02)
 #define WACOM_HID_G11_TOUCHSCREEN       (WACOM_HID_UP_G11 | 0x11)
+#define WACOM_HID_UP_WACOMTOUCH         0xff000000
+#define WACOM_HID_WT_TOUCHSCREEN        (WACOM_HID_UP_WACOMTOUCH | 0x04)
+#define WACOM_HID_WT_TOUCHPAD           (WACOM_HID_UP_WACOMTOUCH | 0x05)
+#define WACOM_HID_WT_CONTACTMAX         (WACOM_HID_UP_WACOMTOUCH | 0x55)
+#define WACOM_HID_WT_X                  (WACOM_HID_UP_WACOMTOUCH | 0x130)
+#define WACOM_HID_WT_Y                  (WACOM_HID_UP_WACOMTOUCH | 0x131)
 
 #define WACOM_PAD_FIELD(f)	(((f)->physical == HID_DG_TABLETFUNCTIONKEY) || \
 				 ((f)->physical == WACOM_HID_WD_DIGITIZERFNKEYS) || \
@@ -154,7 +161,14 @@
 				 ((f)->physical == HID_DG_FINGER) || \
 				 ((f)->application == HID_DG_TOUCHSCREEN) || \
 				 ((f)->application == WACOM_HID_G9_TOUCHSCREEN) || \
-				 ((f)->application == WACOM_HID_G11_TOUCHSCREEN))
+				 ((f)->application == WACOM_HID_G11_TOUCHSCREEN) || \
+				 ((f)->application == WACOM_HID_WT_TOUCHPAD) || \
+				 ((f)->application == HID_DG_TOUCHPAD))
+
+#define WACOM_DIRECT_DEVICE(f)	(((f)->application == HID_DG_TOUCHSCREEN) || \
+				 ((f)->application == WACOM_HID_WT_TOUCHSCREEN) || \
+				 ((f)->application == HID_DG_PEN) || \
+				 ((f)->application == WACOM_HID_WD_PEN))
 
 enum {
 	PENPARTNER = 0,
-- 
2.7.4

