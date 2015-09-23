From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] HID: wacom: Cleanup unsupported device_type for BAMBOO_PT
Date: Wed, 23 Sep 2015 09:59:10 -0700
Message-ID: <1443027550-7269-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35600 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbbIWQ7Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2015 12:59:16 -0400
Received: by pacfv12 with SMTP id fv12so46106085pac.2
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2015 09:59:15 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, aaron.skomra@wacom.com, Ping Cheng <pingc@wacom.com>

Not all Bamboo support both pen and touch. Make sure we deal with
pen only and touch only devices properly.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Tested-By: Aaron Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_sys.c | 49 ++++++++++++++++++++++++++++++++++---------------
 drivers/hid/wacom_wac.c | 31 +++++++++++++++++--------------
 drivers/hid/wacom_wac.h |  4 +++-
 3 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 9a4912c..f4ba6a0 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -211,7 +211,7 @@ static void wacom_usage_mapping(struct hid_device *hdev,
 	 * Bamboo models do not support HID_DG_CONTACTMAX.
 	 * And, Bamboo Pen only descriptor contains touch.
 	 */
-	if (features->type != BAMBOO_PT) {
+	if (features->type > BAMBOO_PT) {
 		/* ISDv4 touch devices at least supports one touch point */
 		if (finger && !features->touch_max)
 			features->touch_max = 1;
@@ -222,7 +222,8 @@ static void wacom_usage_mapping(struct hid_device *hdev,
 		features->x_max = field->logical_maximum;
 		if (finger) {
 			features->x_phy = field->physical_maximum;
-			if (features->type != BAMBOO_PT) {
+			if ((features->type != BAMBOO_PT) &&
+			    (features->type != BAMBOO_TOUCH)) {
 				features->unit = field->unit;
 				features->unitExpo = field->unit_exponent;
 			}
@@ -232,7 +233,8 @@ static void wacom_usage_mapping(struct hid_device *hdev,
 		features->y_max = field->logical_maximum;
 		if (finger) {
 			features->y_phy = field->physical_maximum;
-			if (features->type != BAMBOO_PT) {
+			if ((features->type != BAMBOO_PT) &&
+			    (features->type != BAMBOO_TOUCH)) {
 				features->unit = field->unit;
 				features->unitExpo = field->unit_exponent;
 			}
@@ -1547,15 +1549,16 @@ static void wacom_wireless_work(struct work_struct *work)
 		wacom_wac1->features =
 			*((struct wacom_features *)id->driver_data);
 		wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PEN;
-		if (wacom_wac1->features.type != INTUOSHT &&
-		    wacom_wac1->features.type != BAMBOO_PT)
-			wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PAD;
 		wacom_set_default_phy(&wacom_wac1->features);
 		wacom_calculate_res(&wacom_wac1->features);
 		snprintf(wacom_wac1->pen_name, WACOM_NAME_MAX, "%s (WL) Pen",
 			 wacom_wac1->features.name);
-		snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
-			 wacom_wac1->features.name);
+		if (wacom_wac1->features.type < BAMBOO_PEN ||
+		    wacom_wac1->features.type > BAMBOO_PT) {
+			snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
+				 wacom_wac1->features.name);
+			wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PAD;
+		}
 		wacom_wac1->shared->touch_max = wacom_wac1->features.touch_max;
 		wacom_wac1->shared->type = wacom_wac1->features.type;
 		wacom_wac1->pid = wacom_wac->pid;
@@ -1575,13 +1578,14 @@ static void wacom_wireless_work(struct work_struct *work)
 			wacom_calculate_res(&wacom_wac2->features);
 			snprintf(wacom_wac2->touch_name, WACOM_NAME_MAX,
 				 "%s (WL) Finger",wacom_wac2->features.name);
-			snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
-				 "%s (WL) Pad",wacom_wac2->features.name);
 			if (wacom_wac1->features.touch_max)
 				wacom_wac2->features.device_type |= WACOM_DEVICETYPE_TOUCH;
-			if (wacom_wac1->features.type == INTUOSHT ||
-			    wacom_wac1->features.type == BAMBOO_PT)
+			if (wacom_wac1->features.type >= INTUOSHT &&
+			    wacom_wac1->features.type <= BAMBOO_PT) {
+				snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
+					 "%s (WL) Pad",wacom_wac2->features.name);
 				wacom_wac2->features.device_type |= WACOM_DEVICETYPE_PAD;
+			}
 			wacom_wac2->pid = wacom_wac->pid;
 			error = wacom_allocate_inputs(wacom2) ||
 				wacom_register_inputs(wacom2);
@@ -1772,6 +1776,24 @@ static int wacom_probe(struct hid_device *hdev,
 		features->device_type |= WACOM_DEVICETYPE_PEN;
 	}
 
+	/* Note that if query fails it is not a hard failure */
+	wacom_query_tablet_data(hdev, features);
+
+	/* touch only Bamboo doesn't support pen */
+	if ((features->type == BAMBOO_TOUCH) &&
+	    (features->device_type & WACOM_DEVICETYPE_PEN)) {
+		error = -ENODEV;
+		goto fail_shared_data;
+	}
+
+	/* pen only Bamboo neither support touch nor pad */
+	if ((features->type == BAMBOO_PEN) &&
+	    ((features->device_type & WACOM_DEVICETYPE_TOUCH) ||
+	    (features->device_type & WACOM_DEVICETYPE_PAD))) {
+		error = -ENODEV;
+		goto fail_shared_data;
+	}
+
 	wacom_calculate_res(features);
 
 	wacom_update_name(wacom);
@@ -1809,9 +1831,6 @@ static int wacom_probe(struct hid_device *hdev,
 		goto fail_hw_start;
 	}
 
-	/* Note that if query fails it is not a hard failure */
-	wacom_query_tablet_data(hdev, features);
-
 	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
 		error = hid_hw_open(hdev);
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0215ab62..af734ef 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2300,6 +2300,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case BAMBOO_PT:
+	case BAMBOO_PEN:
+	case BAMBOO_TOUCH:
 	case INTUOSHT:
 		if (wacom_wac->data[0] == WACOM_REPORT_USB)
 			sync = wacom_status_irq(wacom_wac, len);
@@ -2387,9 +2389,8 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 
 	/* The pen and pad share the same interface on most devices */
 	if (features->type == GRAPHIRE_BT || features->type == WACOM_G4 ||
-	    features->type == DTUS || features->type == WACOM_MO ||
-	    (features->type >= INTUOS3S && features->type <= WACOM_13HD && 
-	     features->type != INTUOSHT)) {
+	    features->type == DTUS ||
+	    (features->type >= INTUOS3S && features->type <= WACOM_MO)) {
 		if (features->device_type & WACOM_DEVICETYPE_PEN)
 			features->device_type |= WACOM_DEVICETYPE_PAD;
 	}
@@ -2406,12 +2407,12 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	 * interface (PacketSize of WACOM_PKGLEN_BBTOUCH3), override the
 	 * tablet values.
 	 */
-	if ((features->type >= INTUOS5S && features->type <= INTUOSHT) ||
-		(features->type == BAMBOO_PT)) {
+	if ((features->type >= INTUOS5S && features->type <= INTUOSPL) ||
+		(features->type >= INTUOSHT && features->type <= BAMBOO_PT)) {
 		if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
 			if (features->touch_max)
 				features->device_type |= WACOM_DEVICETYPE_TOUCH;
-			if (features->type == BAMBOO_PT || features->type == INTUOSHT)
+			if (features->type >= INTUOSHT || features->type <= BAMBOO_PT)
 				features->device_type |= WACOM_DEVICETYPE_PAD;
 
 			features->x_max = 4096;
@@ -2598,6 +2599,7 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 
 	case INTUOSHT:
 	case BAMBOO_PT:
+	case BAMBOO_PEN:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
@@ -2693,6 +2695,7 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case BAMBOO_PT:
+	case BAMBOO_TOUCH:
 		if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
 			input_set_abs_params(input_dev,
 				     ABS_MT_TOUCH_MAJOR,
@@ -2845,6 +2848,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 
 	case INTUOSHT:
 	case BAMBOO_PT:
+	case BAMBOO_TOUCH:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
 		__set_bit(BTN_LEFT, input_dev->keybit);
@@ -3235,11 +3239,10 @@ static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8", 20320, 16240, 1023, 31,
 	  INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x84 =
-	{ "Wacom Wireless Receiver", 0, 0, 0, 0,
-	  WIRELESS, 0, 0, .touch_max = 16 };
+	{ "Wacom Wireless Receiver", .type = WIRELESS, .touch_max = 16 };
 static const struct wacom_features wacom_features_0xD0 =
 	{ "Wacom Bamboo 2FG", 14720, 9200, 1023, 31,
-	  BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 2 };
+	  BAMBOO_TOUCH, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 2 };
 static const struct wacom_features wacom_features_0xD1 =
 	{ "Wacom Bamboo 2FG 4x5", 14720, 9200, 1023, 31,
 	  BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 2 };
@@ -3251,10 +3254,10 @@ static const struct wacom_features wacom_features_0xD3 =
 	  BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 2 };
 static const struct wacom_features wacom_features_0xD4 =
 	{ "Wacom Bamboo Pen", 14720, 9200, 1023, 31,
-	  BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  BAMBOO_PEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD5 =
 	{ "Wacom Bamboo Pen 6x8", 21648, 13700, 1023, 31,
-	  BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  BAMBOO_PEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD6 =
 	{ "Wacom BambooPT 2FG 4x5", 14720, 9200, 1023, 31,
 	  BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 2 };
@@ -3281,7 +3284,7 @@ static const struct wacom_features wacom_features_0xDF =
 	  BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 16 };
 static const struct wacom_features wacom_features_0x300 =
 	{ "Wacom Bamboo One S", 14720, 9225, 1023, 31,
-	  BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  BAMBOO_PEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x301 =
 	{ "Wacom Bamboo One M", 21648, 13530, 1023, 31,
 	  BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -3329,8 +3332,8 @@ static const struct wacom_features wacom_features_0x323 =
 	  INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x331 =
-	{ "Wacom Express Key Remote", 0, 0, 0, 0,
-	  REMOTE, 0, 0, 18, .check_for_hid_type = true,
+	{ "Wacom Express Key Remote", .type = REMOTE,
+	  .numbered_buttons = 18, .check_for_hid_type = true,
 	  .hid_type = HID_TYPE_USBNONE };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 1e270d4..3f24520 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -117,7 +117,6 @@ enum {
 	INTUOSPS,
 	INTUOSPM,
 	INTUOSPL,
-	INTUOSHT,
 	WACOM_21UX2,
 	WACOM_22HD,
 	DTK,
@@ -129,6 +128,9 @@ enum {
 	WACOM_13HD,
 	WACOM_MO,
 	WIRELESS,
+	BAMBOO_PEN,
+	INTUOSHT,
+	BAMBOO_TOUCH,
 	BAMBOO_PT,
 	WACOM_24HDT,
 	WACOM_27QHDT,
-- 
1.9.1

