From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 10/19] HID: wacom: generic: Add support for vendor-defined "Sense" usage
Date: Thu,  6 Oct 2016 14:22:22 -0700
Message-ID: <20161006212231.31440-11-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33932 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935088AbcJFVW4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:22:56 -0400
Received: by mail-qt0-f194.google.com with SMTP id f6so835522qtd.1
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:22:56 -0700 (PDT)
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

Wacom's professional tablets beginning with the Intuos4 are capable of
reporting an intermediate degree of proximity where the pen is no longer
close enough to communicate with ("in prox"), but still close enough to
be sensed ("in range"). This additional state is particularly useful for
performing palm rejection as it allows the driver to disable the touch
sensor while the pen is a greater distance from the tablet.

Like other professional tablets, the new MobileStudio Pro also reports
this intermeidate "in range" proximity state. Its descriptor assigns
usage 0xff0d0036 to this bit. Normally 'wacom_equivalent_usage' would
translate this to the standard HID "Quality" usage, but since this has
a different meaning we have it explicitly ignore the usage and define
it ourselves as "Sense" (since "In Range" is already defined by the
HID standard and interpreted by our driver as meaning "in prox").

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 26 +++++++++++++++++++++++---
 drivers/hid/wacom_wac.h |  3 +++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 009c25d..0e8c99a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1443,6 +1443,7 @@ static int wacom_equivalent_usage(int usage)
 
 		if (subpage == WACOM_HID_SP_DIGITIZER ||
 		    subpage == WACOM_HID_SP_DIGITIZERINFO ||
+		    usage == WACOM_HID_WD_SENSE ||
 		    usage == WACOM_HID_WD_DISTANCE) {
 			return usage;
 		}
@@ -1493,6 +1494,7 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
 	struct input_dev *input = wacom_wac->pen_input;
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
@@ -1539,6 +1541,10 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 	case HID_DG_TOOLSERIALNUMBER:
 		wacom_map_usage(input, usage, field, EV_MSC, MSC_SERIAL, 0);
 		break;
+	case WACOM_HID_WD_SENSE:
+		features->quirks |= WACOM_QUIRK_SENSE;
+		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
+		break;
 	case WACOM_HID_WD_FINGERWHEEL:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
 		break;
@@ -1550,6 +1556,7 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
 	struct input_dev *input = wacom_wac->pen_input;
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
@@ -1564,6 +1571,8 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		break;
 	case HID_DG_INRANGE:
 		wacom_wac->hid_data.inrange_state = value;
+		if (!(features->quirks & WACOM_QUIRK_SENSE))
+			wacom_wac->hid_data.sense_state = value;
 		return 0;
 	case HID_DG_INVERT:
 		wacom_wac->hid_data.invert_state = value;
@@ -1572,6 +1581,9 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 	case HID_DG_TIPSWITCH:
 		wacom_wac->hid_data.tipswitch |= value;
 		return 0;
+	case WACOM_HID_WD_SENSE:
+		wacom_wac->hid_data.sense_state = value;
+		return 0;
 	}
 
 	/* send pen events only when touch is up or forced out
@@ -1580,6 +1592,10 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 	if (!usage->type || delay_pen_events(wacom_wac))
 		return 0;
 
+	/* send pen events only when the pen is in/entering/leaving proximity */
+	if (!wacom_wac->hid_data.inrange_state && !wacom_wac->tool[0])
+		return 0;
+
 	input_event(input, usage->type, usage->code, value);
 
 	return 0;
@@ -1598,16 +1614,17 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct input_dev *input = wacom_wac->pen_input;
 	bool prox = wacom_wac->hid_data.inrange_state;
+	bool range = wacom_wac->hid_data.sense_state;
 
-	if (!wacom_wac->shared->stylus_in_proximity) /* first in prox */
+	if (!wacom_wac->tool[0] && prox) /* first in prox */
 		/* Going into proximity select tool */
 		wacom_wac->tool[0] = wacom_wac->hid_data.invert_state ?
 						BTN_TOOL_RUBBER : BTN_TOOL_PEN;
 
 	/* keep pen state for touch events */
-	wacom_wac->shared->stylus_in_proximity = prox;
+	wacom_wac->shared->stylus_in_proximity = range;
 
-	if (!delay_pen_events(wacom_wac)) {
+	if (!delay_pen_events(wacom_wac) && wacom_wac->tool[0]) {
 		input_report_key(input, BTN_TOUCH,
 				wacom_wac->hid_data.tipswitch);
 		input_report_key(input, wacom_wac->tool[0], prox);
@@ -1616,6 +1633,9 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 
 		input_sync(input);
 	}
+
+	if (!prox)
+		wacom_wac->tool[0] = 0;
 }
 
 static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 18cae38..e8779c7 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -74,6 +74,7 @@
 
 /* device quirks */
 #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
+#define WACOM_QUIRK_SENSE		0x0002
 #define WACOM_QUIRK_BATTERY		0x0008
 
 /* device types */
@@ -88,6 +89,7 @@
 #define WACOM_HID_SP_DIGITIZER          0x000d0000
 #define WACOM_HID_SP_DIGITIZERINFO      0x00100000
 #define WACOM_HID_WD_DIGITIZER          (WACOM_HID_UP_WACOMDIGITIZER | 0x01)
+#define WACOM_HID_WD_SENSE              (WACOM_HID_UP_WACOMDIGITIZER | 0x36)
 #define WACOM_HID_WD_DISTANCE           (WACOM_HID_UP_WACOMDIGITIZER | 0x0132)
 #define WACOM_HID_WD_FINGERWHEEL        (WACOM_HID_UP_WACOMDIGITIZER | 0x0d03)
 #define WACOM_HID_WD_DATAMODE           (WACOM_HID_UP_WACOMDIGITIZER | 0x1002)
@@ -213,6 +215,7 @@ struct wacom_shared {
 struct hid_data {
 	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
 	__s16 inputmode_index;	/* InputMode HID feature index in the report */
+	bool sense_state;
 	bool inrange_state;
 	bool invert_state;
 	bool tipswitch;
-- 
2.10.0

