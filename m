From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 14/18] HID: wacom: generic: Add support for sensor offsets
Date: Fri,  7 Oct 2016 15:16:49 -0700
Message-ID: <20161007221653.26941-14-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161007221653.26941-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36632 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757436AbcJGWSB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 18:18:01 -0400
Received: by mail-qk0-f195.google.com with SMTP id z190so3303436qkc.3
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 15:17:24 -0700 (PDT)
In-Reply-To: <20161007221653.26941-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Many of Wacom's display tablets include an "outbound" area where pen
digitizing is possible but outside of the display area. To accommodate
such sensors in the HID_GENERIC codepath, we add support for the
necessary vendor-defined HID feature usages and adjust the min/max
values of the X and Y axes accordingly, similar to what is done in
the non-generic codepath.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
Changes from v1:
 * Use input_get_drvdata instead of hid_get_drvdata. This removes the
   need for a "Pass 'hdev' to 'wacom_map_usage'" patch, which is no
   longer part of the v2 set.

 drivers/hid/wacom_sys.c | 38 ++++++++++++++++++++++++++++++--------
 drivers/hid/wacom_wac.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/hid/wacom_wac.h |  4 ++++
 3 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index b2e2471..b9779bc 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -122,6 +122,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 	struct hid_data *hid_data = &wacom->wacom_wac.hid_data;
 	u8 *data;
 	int ret;
+	int n;
 
 	switch (usage->hid) {
 	case HID_DG_CONTACTMAX:
@@ -180,6 +181,27 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 			wacom->wacom_wac.mode_value = 0;
 		}
 		break;
+	case WACOM_HID_WD_OFFSETLEFT:
+	case WACOM_HID_WD_OFFSETTOP:
+	case WACOM_HID_WD_OFFSETRIGHT:
+	case WACOM_HID_WD_OFFSETBOTTOM:
+		/* read manually */
+		n = hid_report_len(field->report);
+		data = hid_alloc_report_buf(field->report, GFP_KERNEL);
+		if (!data)
+			break;
+		data[0] = field->report->id;
+		ret = wacom_get_report(hdev, HID_FEATURE_REPORT,
+					data, n, WAC_CMD_RETRIES);
+		if (ret == n) {
+			ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT,
+						   data, n, 0);
+		} else {
+			hid_warn(hdev, "%s: could not retrieve sensor offsets\n",
+				 __func__);
+		}
+		kfree(data);
+		break;
 	}
 }
 
@@ -718,11 +740,6 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 		return retval;
 	}
 
-	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
-		wacom_wac->shared->touch = hdev;
-	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
-		wacom_wac->shared->pen = hdev;
-
 out:
 	mutex_unlock(&wacom_udev_list_lock);
 	return retval;
@@ -2019,6 +2036,10 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	if (error)
 		goto fail;
 
+	error = wacom_add_shared_data(hdev);
+	if (error)
+		goto fail;
+
 	/*
 	 * Bamboo Pad has a generic hid handling for the Pen, and we switch it
 	 * into debug mode for the touch part.
@@ -2059,9 +2080,10 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	wacom_update_name(wacom, wireless ? " (WL)" : "");
 
-	error = wacom_add_shared_data(hdev);
-	if (error)
-		goto fail;
+	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
+		wacom_wac->shared->touch = hdev;
+	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
+		wacom_wac->shared->pen = hdev;
 
 	if (!(features->device_type & WACOM_DEVICETYPE_WL_MONITOR) &&
 	     (features->quirks & WACOM_QUIRK_BATTERY)) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index df751f2..d4a1d33 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1468,6 +1468,9 @@ static int wacom_equivalent_usage(int usage)
 static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 		struct hid_field *field, __u8 type, __u16 code, int fuzz)
 {
+	struct wacom *wacom = input_get_drvdata(input);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
 	int fmin = field->logical_minimum;
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
@@ -1477,6 +1480,15 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 		resolution_code = ABS_RZ;
 	}
 
+	if (equivalent_usage == HID_GD_X) {
+		fmin += features->offset_left;
+		fmax -= features->offset_right;
+	}
+	if (equivalent_usage == HID_GD_Y) {
+		fmin += features->offset_top;
+		fmax -= features->offset_bottom;
+	}
+
 	usage->type = type;
 	usage->code = code;
 
@@ -1629,6 +1641,34 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		 */
 		wacom_wac->id[0] |= value;
 		return 0;
+	case WACOM_HID_WD_OFFSETLEFT:
+		if (features->offset_left && value != features->offset_left)
+			hid_warn(hdev, "%s: overriding exising left offset "
+				 "%d -> %d\n", __func__, value,
+				 features->offset_left);
+		features->offset_left = value;
+		return 0;
+	case WACOM_HID_WD_OFFSETRIGHT:
+		if (features->offset_right && value != features->offset_right)
+			hid_warn(hdev, "%s: overriding exising right offset "
+				 "%d -> %d\n", __func__, value,
+				 features->offset_right);
+		features->offset_right = value;
+		return 0;
+	case WACOM_HID_WD_OFFSETTOP:
+		if (features->offset_top && value != features->offset_top)
+			hid_warn(hdev, "%s: overriding exising top offset "
+				 "%d -> %d\n", __func__, value,
+				 features->offset_top);
+		features->offset_top = value;
+		return 0;
+	case WACOM_HID_WD_OFFSETBOTTOM:
+		if (features->offset_bottom && value != features->offset_bottom)
+			hid_warn(hdev, "%s: overriding exising bottom offset "
+				 "%d -> %d\n", __func__, value,
+				 features->offset_bottom);
+		features->offset_bottom = value;
+		return 0;
 	}
 
 	/* send pen events only when touch is up or forced out
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 81ae478..93df1de 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -94,6 +94,10 @@
 #define WACOM_HID_WD_TOOLTYPE           (WACOM_HID_UP_WACOMDIGITIZER | 0x77)
 #define WACOM_HID_WD_DISTANCE           (WACOM_HID_UP_WACOMDIGITIZER | 0x0132)
 #define WACOM_HID_WD_FINGERWHEEL        (WACOM_HID_UP_WACOMDIGITIZER | 0x0d03)
+#define WACOM_HID_WD_OFFSETLEFT         (WACOM_HID_UP_WACOMDIGITIZER | 0x0d30)
+#define WACOM_HID_WD_OFFSETTOP          (WACOM_HID_UP_WACOMDIGITIZER | 0x0d31)
+#define WACOM_HID_WD_OFFSETRIGHT        (WACOM_HID_UP_WACOMDIGITIZER | 0x0d32)
+#define WACOM_HID_WD_OFFSETBOTTOM       (WACOM_HID_UP_WACOMDIGITIZER | 0x0d33)
 #define WACOM_HID_WD_DATAMODE           (WACOM_HID_UP_WACOMDIGITIZER | 0x1002)
 #define WACOM_HID_UP_G9                 0xff090000
 #define WACOM_HID_G9_PEN                (WACOM_HID_UP_G9 | 0x02)
-- 
2.10.0

