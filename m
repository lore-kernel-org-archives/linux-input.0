From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 07/12] HID: input: enable Totem on the Dell Canvas 27
Date: Fri, 13 Jul 2018 16:13:49 +0200
Message-ID: <20180713141354.7286-8-benjamin.tissoires@redhat.com>
References: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

The Dell Canvas 27 has a tool that can be put on the surface and acts
as a dial. The firmware processes the detection of the tool and forward
regular HID reports with X, Y, Azimuth, rotation, width/height.

The firmware also exports Contact ID, Countact Count which may hint that
several totems can be used at the same time (the FW only supports one).

We can tell that MT_TOOL_DIAL will be reported by setting the min/max
of ABS_MT_TOOL_TYPE to MT_TOOL_DIAL.

This tool is aimed at being used by the system and not the applications,
so the user space processing should not go through the regular touch
inputs.
We set INPUT_PROP_DIRECT which applies ID_INPUT_TOUCHSCREEN to this new
type of devices, but we will counter this for the time being with the
special udev hwdb entry mentioned above.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1511846

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v4
no changes in v3

changes in v2:
- manually declare ABS_MT_TOOL_TYPE and set its min/max to MT_TOOL_DIAL
  to explain which tool it will set
---
 drivers/hid/hid-input.c      |  3 +++
 drivers/hid/hid-multitouch.c | 48 +++++++++++++++++++++++++++++++-------------
 include/linux/hid.h          |  6 ++++++
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index ab93dd5927c3..4e94ea3e280a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1550,6 +1550,9 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 		case HID_GD_WIRELESS_RADIO_CTLS:
 			suffix = "Wireless Radio Control";
 			break;
+		case HID_GD_SYSTEM_MULTIAXIS:
+			suffix = "System Multi Axis";
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 346e9caef6f3..a4a274ebfbef 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -665,7 +665,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	/*
 	 * Model touchscreens providing buttons as touchpads.
 	 */
-	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
+	if (field->application == HID_DG_TOUCHSCREEN &&
+	    (usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
 		app->mt_flags |= INPUT_MT_POINTER;
 		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
 	}
@@ -692,6 +693,19 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 
 			set_abs(hi->input, code, field, cls->sn_move);
 
+			/*
+			 * A system multi-axis that exports X and Y has a high
+			 * chance of being used directly on a surface
+			 */
+			if (field->application == HID_GD_SYSTEM_MULTIAXIS) {
+				__set_bit(INPUT_PROP_DIRECT,
+					  hi->input->propbit);
+				input_set_abs_params(hi->input,
+						     ABS_MT_TOOL_TYPE,
+						     MT_TOOL_DIAL,
+						     MT_TOOL_DIAL, 0, 0);
+			}
+
 			return 1;
 		case HID_GD_Y:
 			if (prev_usage && (prev_usage->hid == usage->hid)) {
@@ -725,7 +739,9 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			MT_STORE_FIELD(confidence_state);
 			return 1;
 		case HID_DG_TIPSWITCH:
-			input_set_capability(hi->input, EV_KEY, BTN_TOUCH);
+			if (field->application != HID_GD_SYSTEM_MULTIAXIS)
+				input_set_capability(hi->input,
+						     EV_KEY, BTN_TOUCH);
 			MT_STORE_FIELD(tip_state);
 			return 1;
 		case HID_DG_CONTACTID:
@@ -802,6 +818,10 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		    field->application == HID_DG_TOUCHPAD &&
 		    (usage->hid & HID_USAGE) > 1)
 			code--;
+
+		if (field->application == HID_GD_SYSTEM_MULTIAXIS)
+			code = BTN_0  + ((usage->hid - 1) & HID_USAGE);
+
 		hid_map_usage(hi, usage, bit, max, EV_KEY, code);
 		input_set_capability(hi->input, EV_KEY, code);
 		return 1;
@@ -899,6 +919,7 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 	bool inrange_state = false;
 	int active;
 	int slotnum;
+	int tool = MT_TOOL_FINGER;
 
 	if (!slot)
 		return -EINVAL;
@@ -939,8 +960,11 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 
 	active = (*slot->tip_state || inrange_state) && confidence_state;
 
+	if (app->application == HID_GD_SYSTEM_MULTIAXIS)
+		tool = MT_TOOL_DIAL;
+
 	input_mt_slot(input, slotnum);
-	input_mt_report_slot_state(input, MT_TOOL_FINGER, active);
+	input_mt_report_slot_state(input, tool, active);
 	if (active) {
 		/* this finger is in proximity of the sensor */
 		int wide = (*slot->w > *slot->h);
@@ -1203,6 +1227,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	    field->application != HID_GD_SYSTEM_CONTROL &&
 	    field->application != HID_CP_CONSUMER_CONTROL &&
 	    field->application != HID_GD_WIRELESS_RADIO_CTLS &&
+	    field->application != HID_GD_SYSTEM_MULTIAXIS &&
 	    !(field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
 	      application->quirks & MT_QUIRK_ASUS_CUSTOM_UP))
 		return -1;
@@ -1230,9 +1255,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 1;
 	}
 
-	if (rdata->is_mt_collection &&
-	    (field->application == HID_DG_TOUCHSCREEN ||
-	     field->application == HID_DG_TOUCHPAD))
+	if (rdata->is_mt_collection)
 		return mt_touch_input_mapping(hdev, hi, field, usage, bit, max,
 					      application);
 
@@ -1244,15 +1267,11 @@ static int mt_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	/*
-	 * some egalax touchscreens have "application == HID_DG_TOUCHSCREEN"
-	 * for the stylus.
-	 */
-	if (field->physical == HID_DG_STYLUS)
-		return 0;
+	struct mt_device *td = hid_get_drvdata(hdev);
+	struct mt_report_data *rdata;
 
-	if (field->application == HID_DG_TOUCHSCREEN ||
-	    field->application == HID_DG_TOUCHPAD) {
+	rdata = mt_find_report_data(td, field->report);
+	if (rdata && rdata->is_mt_collection) {
 		/* We own these mappings, tell hid-input to ignore them */
 		return -1;
 	}
@@ -1460,6 +1479,7 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		case HID_GD_SYSTEM_CONTROL:
 		case HID_CP_CONSUMER_CONTROL:
 		case HID_GD_WIRELESS_RADIO_CTLS:
+		case HID_GD_SYSTEM_MULTIAXIS:
 			/* already handled by hid core */
 			break;
 		case HID_DG_TOUCHSCREEN:
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 773bcb1d4044..2e4498d52a2f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -190,6 +190,12 @@ struct hid_item {
  * http://www.usb.org/developers/hidpage/HUTRR40RadioHIDUsagesFinal.pdf
  */
 #define HID_GD_WIRELESS_RADIO_CTLS	0x0001000c
+/*
+ * System Multi-Axis, see:
+ * http://www.usb.org/developers/hidpage/HUTRR62_-_Generic_Desktop_CA_for_System_Multi-Axis_Controllers.txt
+ */
+#define HID_GD_SYSTEM_MULTIAXIS	0x0001000e
+
 #define HID_GD_X		0x00010030
 #define HID_GD_Y		0x00010031
 #define HID_GD_Z		0x00010032
-- 
2.14.3
