From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 15/18] HID: wacom: generic: Introduce pad support
Date: Wed, 19 Oct 2016 18:03:51 -0700
Message-ID: <20161020010354.4049-15-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161020010354.4049-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35543 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755704AbcJTBFJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Oct 2016 21:05:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id s8so3835179pfj.2
        for <linux-input@vger.kernel.org>; Wed, 19 Oct 2016 18:05:09 -0700 (PDT)
In-Reply-To: <20161020010354.4049-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

As with usages for the pen, the Custom HID specificiation includes
usages for the pad. Here we add functions to map and handle most
of the pad usages present on the MobileStudio Pro.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 143 ++++++++++++++++++++++++++++++++++++++++++------
 drivers/hid/wacom_wac.h |  19 +++++++
 2 files changed, 146 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 3bb6dd6..70de1fa 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -41,6 +41,8 @@ MODULE_PARM_DESC(touch_arbitration, " on (Y) off (N)");
 static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 				int button_count, int mask);
 
+static int wacom_numbered_button_to_key(int n);
+
 /*
  * Percent of battery capacity for Graphire.
  * 8th value means AC online and show 100% capacity.
@@ -1447,12 +1449,16 @@ static int wacom_equivalent_usage(int usage)
 		int subpage = (usage & 0xFF00) << 8;
 		int subusage = (usage & 0xFF);
 
-		if (subpage == WACOM_HID_SP_DIGITIZER ||
+		if (subpage == WACOM_HID_SP_PAD ||
+		    subpage == WACOM_HID_SP_BUTTON ||
+		    subpage == WACOM_HID_SP_DIGITIZER ||
 		    subpage == WACOM_HID_SP_DIGITIZERINFO ||
 		    usage == WACOM_HID_WD_SENSE ||
 		    usage == WACOM_HID_WD_SERIALHI ||
 		    usage == WACOM_HID_WD_TOOLTYPE ||
-		    usage == WACOM_HID_WD_DISTANCE) {
+		    usage == WACOM_HID_WD_DISTANCE ||
+		    usage == WACOM_HID_WD_TOUCHRING ||
+		    usage == WACOM_HID_WD_TOUCHRINGSTATUS) {
 			return usage;
 		}
 
@@ -1509,6 +1515,98 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	}
 }
 
+static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
+		struct hid_field *field, struct hid_usage *usage)
+{
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
+	struct input_dev *input = wacom_wac->pad_input;
+	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
+
+	switch (equivalent_usage) {
+	case WACOM_HID_WD_ACCELEROMETER_X:
+		__set_bit(INPUT_PROP_ACCELEROMETER, input->propbit);
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 0);
+		break;
+	case WACOM_HID_WD_ACCELEROMETER_Y:
+		__set_bit(INPUT_PROP_ACCELEROMETER, input->propbit);
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 0);
+		break;
+	case WACOM_HID_WD_ACCELEROMETER_Z:
+		__set_bit(INPUT_PROP_ACCELEROMETER, input->propbit);
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_Z, 0);
+		break;
+	case WACOM_HID_WD_BUTTONHOME:
+	case WACOM_HID_WD_BUTTONUP:
+	case WACOM_HID_WD_BUTTONDOWN:
+	case WACOM_HID_WD_BUTTONLEFT:
+	case WACOM_HID_WD_BUTTONRIGHT:
+		wacom_map_usage(input, usage, field, EV_KEY,
+				wacom_numbered_button_to_key(features->numbered_buttons),
+				0);
+		features->numbered_buttons++;
+		break;
+	case WACOM_HID_WD_TOUCHRING:
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
+		break;
+	}
+
+	switch (equivalent_usage & 0xfffffff0) {
+	case WACOM_HID_WD_EXPRESSKEY00:
+		wacom_map_usage(input, usage, field, EV_KEY,
+				wacom_numbered_button_to_key(features->numbered_buttons),
+				0);
+		features->numbered_buttons++;
+		break;
+	}
+}
+
+static int wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field,
+		struct hid_usage *usage, __s32 value)
+{
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct input_dev *input = wacom_wac->pad_input;
+	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
+
+	if (wacom_equivalent_usage(field->physical) == HID_DG_TABLETFUNCTIONKEY) {
+		wacom_wac->hid_data.inrange_state |= value;
+	}
+
+	if (equivalent_usage != WACOM_HID_WD_TOUCHRINGSTATUS)
+		input_event(input, usage->type, usage->code, value);
+
+	return 0;
+}
+
+static void wacom_wac_pad_pre_report(struct hid_device *hdev,
+		struct hid_report *report)
+{
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+
+	wacom_wac->hid_data.inrange_state = 0;
+}
+
+static void wacom_wac_pad_report(struct hid_device *hdev,
+		struct hid_report *report)
+{
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct input_dev *input = wacom_wac->pad_input;
+	bool active = wacom_wac->hid_data.inrange_state != 0;
+
+	/*
+	 * don't report prox for events like accelerometer
+	 * or battery status
+	 */
+	if (wacom_equivalent_usage(report->field[0]->physical) == HID_DG_TABLETFUNCTIONKEY)
+		input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_ID : 0);
+
+	input_sync(input);
+}
+
 static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage)
 {
@@ -1946,10 +2044,11 @@ void wacom_wac_usage_mapping(struct hid_device *hdev,
 	/* currently, only direct devices have proper hid report descriptors */
 	features->device_type |= WACOM_DEVICETYPE_DIRECT;
 
-	if (WACOM_PEN_FIELD(field))
+	if (WACOM_PAD_FIELD(field))
+		return wacom_wac_pad_usage_mapping(hdev, field, usage);
+	else if (WACOM_PEN_FIELD(field))
 		return wacom_wac_pen_usage_mapping(hdev, field, usage);
-
-	if (WACOM_FINGER_FIELD(field))
+	else if (WACOM_FINGER_FIELD(field))
 		return wacom_wac_finger_usage_mapping(hdev, field, usage);
 }
 
@@ -1961,10 +2060,11 @@ int wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 	if (wacom->wacom_wac.features.type != HID_GENERIC)
 		return 0;
 
-	if (WACOM_PEN_FIELD(field))
+	if (WACOM_PAD_FIELD(field))
+		return wacom_wac_pad_event(hdev, field, usage, value);
+	else if (WACOM_PEN_FIELD(field))
 		return wacom_wac_pen_event(hdev, field, usage, value);
-
-	if (WACOM_FINGER_FIELD(field))
+	else if (WACOM_FINGER_FIELD(field))
 		return wacom_wac_finger_event(hdev, field, usage, value);
 
 	return 0;
@@ -1998,18 +2098,20 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 	if (wacom_wac->features.type != HID_GENERIC)
 		return;
 
-	if (WACOM_PEN_FIELD(field))
+	if (WACOM_PAD_FIELD(field))
+		wacom_wac_pad_pre_report(hdev, report);
+	else if (WACOM_PEN_FIELD(field))
 		wacom_wac_pen_pre_report(hdev, report);
-
-	if (WACOM_FINGER_FIELD(field))
+	else if (WACOM_FINGER_FIELD(field))
 		wacom_wac_finger_pre_report(hdev, report);
 
 	wacom_report_events(hdev, report);
 
-	if (WACOM_PEN_FIELD(field))
+	if (WACOM_PAD_FIELD(field))
+		return wacom_wac_pad_report(hdev, report);
+	else if (WACOM_PEN_FIELD(field))
 		return wacom_wac_pen_report(hdev, report);
-
-	if (WACOM_FINGER_FIELD(field))
+	else if (WACOM_FINGER_FIELD(field))
 		return wacom_wac_finger_report(hdev, report);
 }
 
@@ -2583,6 +2685,8 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	struct wacom_features *features = &wacom->wacom_wac.features;
 
 	/* The pen and pad share the same interface on most devices */
+	if (features->numbered_buttons > 0)
+		features->device_type |= WACOM_DEVICETYPE_PAD;
 	if (features->type == GRAPHIRE_BT || features->type == WACOM_G4 ||
 	    features->type == DTUS ||
 	    (features->type >= INTUOS3S && features->type <= WACOM_MO)) {
@@ -3104,8 +3208,12 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	__set_bit(ABS_MISC, input_dev->absbit);
 
 	/* kept for making legacy xf86-input-wacom accepting the pad */
-	input_set_abs_params(input_dev, ABS_X, 0, 1, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, 1, 0, 0);
+	if (!(input_dev->absinfo && (input_dev->absinfo[ABS_X].minimum ||
+	      input_dev->absinfo[ABS_X].maximum)))
+		input_set_abs_params(input_dev, ABS_X, 0, 1, 0, 0);
+	if (!(input_dev->absinfo && (input_dev->absinfo[ABS_Y].minimum ||
+	      input_dev->absinfo[ABS_Y].maximum)))
+		input_set_abs_params(input_dev, ABS_Y, 0, 1, 0, 0);
 
 	/* kept for making udev and libwacom accepting the pad */
 	__set_bit(BTN_STYLUS, input_dev->keybit);
@@ -3225,6 +3333,9 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
 		break;
 
+	case HID_GENERIC:
+		break;
+
 	default:
 		/* no pad supported */
 		return -ENODEV;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index b4c3c64..1f7c4a8 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -86,19 +86,34 @@
 #define WACOM_DEVICETYPE_DIRECT         0x0010
 
 #define WACOM_HID_UP_WACOMDIGITIZER     0xff0d0000
+#define WACOM_HID_SP_PAD                0x00040000
+#define WACOM_HID_SP_BUTTON             0x00090000
 #define WACOM_HID_SP_DIGITIZER          0x000d0000
 #define WACOM_HID_SP_DIGITIZERINFO      0x00100000
 #define WACOM_HID_WD_DIGITIZER          (WACOM_HID_UP_WACOMDIGITIZER | 0x01)
 #define WACOM_HID_WD_SENSE              (WACOM_HID_UP_WACOMDIGITIZER | 0x36)
+#define WACOM_HID_WD_DIGITIZERFNKEYS    (WACOM_HID_UP_WACOMDIGITIZER | 0x39)
 #define WACOM_HID_WD_SERIALHI           (WACOM_HID_UP_WACOMDIGITIZER | 0x5c)
 #define WACOM_HID_WD_TOOLTYPE           (WACOM_HID_UP_WACOMDIGITIZER | 0x77)
 #define WACOM_HID_WD_DISTANCE           (WACOM_HID_UP_WACOMDIGITIZER | 0x0132)
+#define WACOM_HID_WD_TOUCHRING          (WACOM_HID_UP_WACOMDIGITIZER | 0x0138)
+#define WACOM_HID_WD_TOUCHRINGSTATUS    (WACOM_HID_UP_WACOMDIGITIZER | 0x0139)
+#define WACOM_HID_WD_ACCELEROMETER_X    (WACOM_HID_UP_WACOMDIGITIZER | 0x0401)
+#define WACOM_HID_WD_ACCELEROMETER_Y    (WACOM_HID_UP_WACOMDIGITIZER | 0x0402)
+#define WACOM_HID_WD_ACCELEROMETER_Z    (WACOM_HID_UP_WACOMDIGITIZER | 0x0403)
+#define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
+#define WACOM_HID_WD_BUTTONHOME         (WACOM_HID_UP_WACOMDIGITIZER | 0x0990)
+#define WACOM_HID_WD_BUTTONUP           (WACOM_HID_UP_WACOMDIGITIZER | 0x0991)
+#define WACOM_HID_WD_BUTTONDOWN         (WACOM_HID_UP_WACOMDIGITIZER | 0x0992)
+#define WACOM_HID_WD_BUTTONLEFT         (WACOM_HID_UP_WACOMDIGITIZER | 0x0993)
+#define WACOM_HID_WD_BUTTONRIGHT        (WACOM_HID_UP_WACOMDIGITIZER | 0x0994)
 #define WACOM_HID_WD_FINGERWHEEL        (WACOM_HID_UP_WACOMDIGITIZER | 0x0d03)
 #define WACOM_HID_WD_OFFSETLEFT         (WACOM_HID_UP_WACOMDIGITIZER | 0x0d30)
 #define WACOM_HID_WD_OFFSETTOP          (WACOM_HID_UP_WACOMDIGITIZER | 0x0d31)
 #define WACOM_HID_WD_OFFSETRIGHT        (WACOM_HID_UP_WACOMDIGITIZER | 0x0d32)
 #define WACOM_HID_WD_OFFSETBOTTOM       (WACOM_HID_UP_WACOMDIGITIZER | 0x0d33)
 #define WACOM_HID_WD_DATAMODE           (WACOM_HID_UP_WACOMDIGITIZER | 0x1002)
+#define WACOM_HID_WD_DIGITIZERINFO      (WACOM_HID_UP_WACOMDIGITIZER | 0x1013)
 #define WACOM_HID_UP_G9                 0xff090000
 #define WACOM_HID_G9_PEN                (WACOM_HID_UP_G9 | 0x02)
 #define WACOM_HID_G9_TOUCHSCREEN        (WACOM_HID_UP_G9 | 0x11)
@@ -106,6 +121,10 @@
 #define WACOM_HID_G11_PEN               (WACOM_HID_UP_G11 | 0x02)
 #define WACOM_HID_G11_TOUCHSCREEN       (WACOM_HID_UP_G11 | 0x11)
 
+#define WACOM_PAD_FIELD(f)	(((f)->physical == HID_DG_TABLETFUNCTIONKEY) || \
+				 ((f)->physical == WACOM_HID_WD_DIGITIZERFNKEYS) || \
+				 ((f)->physical == WACOM_HID_WD_DIGITIZERINFO))
+
 #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
 				 ((f)->physical == HID_DG_STYLUS) || \
 				 ((f)->physical == HID_DG_PEN) || \
-- 
2.10.0

