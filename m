From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/5] HID: asus: Add T100CHI bluetooth keyboard dock touchpad support
Date: Sun,  2 Jul 2017 16:34:16 +0200
Message-ID: <20170702143416.23643-6-hdegoede@redhat.com>
References: <20170702143416.23643-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbdGBOe1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 2 Jul 2017 10:34:27 -0400
In-Reply-To: <20170702143416.23643-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Put the touchpad in native (absolute coordinate mode) and export it to
userspace as a touchpad rather then as a mouse.

Note this requires HID_QUIRK_MULTI_INPUT as the T100CHI keyboard dock
has all functionality on a single HID interface and userspace expects
touchpads to be on a separate input_dev. Without MULTI_INPUT userspace
will ignore the keyboard part of the keyboard/touchpad combo.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-asus.c | 74 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d5519479142f..b9804c7b9028 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -41,6 +41,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define T100_TPAD_INTF 2
 
+#define T100CHI_MOUSE_REPORT_ID 0x06
 #define FEATURE_REPORT_ID 0x0d
 #define INPUT_REPORT_ID 0x5d
 #define FEATURE_KBD_REPORT_ID 0x5a
@@ -117,6 +118,15 @@ static const struct asus_touchpad_info asus_t100ta_tp = {
 	.max_contacts = 5,
 };
 
+static const struct asus_touchpad_info asus_t100chi_tp = {
+	.max_x = 2640,
+	.max_y = 1320,
+	.res_x = 31, /* units/mm */
+	.res_y = 29, /* units/mm */
+	.contact_size = 3,
+	.max_contacts = 4,
+};
+
 static void asus_report_contact_down(struct asus_drvdata *drvdat,
 		int toolType, u8 *data)
 {
@@ -126,6 +136,12 @@ static void asus_report_contact_down(struct asus_drvdata *drvdat,
 	x = (data[0] & CONTACT_X_MSB_MASK) << 4 | data[1];
 	y = drvdat->tp->max_y - ((data[0] & CONTACT_Y_MSB_MASK) << 8 | data[2]);
 
+	input_report_abs(input, ABS_MT_POSITION_X, x);
+	input_report_abs(input, ABS_MT_POSITION_Y, y);
+
+	if (drvdat->tp->contact_size < 5)
+		return;
+
 	if (toolType == MT_TOOL_PALM) {
 		touch_major = MAX_TOUCH_MAJOR;
 		pressure = MAX_PRESSURE;
@@ -134,8 +150,6 @@ static void asus_report_contact_down(struct asus_drvdata *drvdat,
 		pressure = data[4] & CONTACT_PRESSURE_MASK;
 	}
 
-	input_report_abs(input, ABS_MT_POSITION_X, x);
-	input_report_abs(input, ABS_MT_POSITION_Y, y);
 	input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major);
 	input_report_abs(input, ABS_MT_PRESSURE, pressure);
 }
@@ -147,6 +161,9 @@ static void asus_report_tool_width(struct asus_drvdata *drvdat)
 	struct input_mt_slot *oldest;
 	int oldid, count, i;
 
+	if (drvdat->tp->contact_size < 5)
+		return;
+
 	oldest = NULL;
 	oldid = mt->trkid;
 	count = 0;
@@ -172,7 +189,7 @@ static void asus_report_tool_width(struct asus_drvdata *drvdat)
 
 static int asus_report_input(struct asus_drvdata *drvdat, u8 *data, int size)
 {
-	int i;
+	int i, toolType = MT_TOOL_FINGER;
 	u8 *contactData = data + 2;
 
 	if (size != 3 + drvdat->tp->contact_size * drvdat->tp->max_contacts)
@@ -180,7 +197,9 @@ static int asus_report_input(struct asus_drvdata *drvdat, u8 *data, int size)
 
 	for (i = 0; i < drvdat->tp->max_contacts; i++) {
 		bool down = !!(data[1] & BIT(i+3));
-		int toolType = contactData[3] & CONTACT_TOOL_TYPE_MASK ?
+
+		if (drvdat->tp->contact_size >= 5)
+			toolType = contactData[3] & CONTACT_TOOL_TYPE_MASK ?
 						MT_TOOL_PALM : MT_TOOL_FINGER;
 
 		input_mt_slot(drvdat->input, i);
@@ -359,6 +378,11 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	struct input_dev *input = hi->input;
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
 
+	/* T100CHI uses MULTI_INPUT, bind the touchpad to the mouse hid_input */
+	if (drvdata->quirks & QUIRK_T100CHI &&
+	    hi->report->id != T100CHI_MOUSE_REPORT_ID)
+		return 0;
+
 	if (drvdata->tp) {
 		int ret;
 
@@ -368,9 +392,15 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 				     drvdata->tp->max_y, 0, 0);
 		input_abs_set_res(input, ABS_MT_POSITION_X, drvdata->tp->res_x);
 		input_abs_set_res(input, ABS_MT_POSITION_Y, drvdata->tp->res_y);
-		input_set_abs_params(input, ABS_TOOL_WIDTH, 0, MAX_TOUCH_MAJOR, 0, 0);
-		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, MAX_TOUCH_MAJOR, 0, 0);
-		input_set_abs_params(input, ABS_MT_PRESSURE, 0, MAX_PRESSURE, 0, 0);
+
+		if (drvdata->tp->contact_size >= 5) {
+			input_set_abs_params(input, ABS_TOOL_WIDTH, 0,
+					     MAX_TOUCH_MAJOR, 0, 0);
+			input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0,
+					     MAX_TOUCH_MAJOR, 0, 0);
+			input_set_abs_params(input, ABS_MT_PRESSURE, 0,
+					      MAX_PRESSURE, 0, 0);
+		}
 
 		__set_bit(BTN_LEFT, input->keybit);
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
@@ -408,6 +438,26 @@ static int asus_input_mapping(struct hid_device *hdev,
 		return -1;
 	}
 
+	/*
+	 * Ignore a bunch of bogus collections in the T100CHI descriptor.
+	 * This avoids a bunch of non-functional hid_input devices getting
+	 * created because of the T100CHI using HID_QUIRK_MULTI_INPUT.
+	 */
+	if (drvdata->quirks & QUIRK_T100CHI) {
+		if (field->application == (HID_UP_GENDESK | 0x0080) ||
+		    usage->hid == (HID_UP_GENDEVCTRLS | 0x0024) ||
+		    usage->hid == (HID_UP_GENDEVCTRLS | 0x0025) ||
+		    usage->hid == (HID_UP_GENDEVCTRLS | 0x0026))
+			return -1;
+		/*
+		 * We use the hid_input for the mouse report for the touchpad,
+		 * keep the left button, to avoid the core removing it.
+		 */
+		if (field->application == HID_GD_MOUSE &&
+		    usage->hid != (HID_UP_BUTTON | 1))
+			return -1;
+	}
+
 	/* ASUS-specific keyboard hotkeys */
 	if ((usage->hid & HID_USAGE_PAGE) == 0xff310000) {
 		set_bit(EV_REP, hi->input->evbit);
@@ -532,6 +582,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+	if (drvdata->quirks & QUIRK_T100CHI) {
+		/*
+		 * All functionality is on a single HID interface and for
+		 * userspace the touchpad must be a separate input_dev.
+		 */
+		hdev->quirks |= HID_QUIRK_MULTI_INPUT |
+				HID_QUIRK_NO_EMPTY_INPUT;
+		drvdata->tp = &asus_t100chi_tp;
+	}
+
 	if (drvdata->quirks & QUIRK_NO_INIT_REPORTS)
 		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 
-- 
2.13.0

