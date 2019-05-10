From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 2/4] HID: wacom: generic: Correct pad syncing
Date: Fri, 10 May 2019 15:34:17 -0700
Message-ID: <1557527659-9417-1-git-send-email-aaron.skomra@wacom.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com, pinglinux@gmail.com, jason.gerecke@wacom.com
Cc: Aaron Armstrong Skomra <aaron.skomra@wacom.com>, "# v4 . 17+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Only sync the pad once per report, not once per collection.
Also avoid syncing the pad on battery reports.

Fixes: f8b6a74719b5 ("HID: wacom: generic: Support multiple tools per report")
Cc: <stable@vger.kernel.org> # v4.17+
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_wac.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 10cce2ca6301..e172c7dda68c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2121,14 +2121,12 @@ static void wacom_wac_pad_report(struct hid_device *hdev,
 	bool active = wacom_wac->hid_data.inrange_state != 0;
 
 	/* report prox for expresskey events */
-	if ((wacom_equivalent_usage(field->physical) == HID_DG_TABLETFUNCTIONKEY) &&
-	    wacom_wac->hid_data.pad_input_event_flag) {
+	if (wacom_wac->hid_data.pad_input_event_flag) {
 		input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_ID : 0);
 		input_sync(input);
 		if (!active)
 			wacom_wac->hid_data.pad_input_event_flag = false;
 	}
-
 }
 
 static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
@@ -2704,9 +2702,7 @@ static int wacom_wac_collection(struct hid_device *hdev, struct hid_report *repo
 	if (report->type != HID_INPUT_REPORT)
 		return -1;
 
-	if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
-		wacom_wac_pad_report(hdev, report, field);
-	else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
+	if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
 		wacom_wac_pen_report(hdev, report);
 	else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_input)
 		wacom_wac_finger_report(hdev, report);
@@ -2720,7 +2716,7 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct hid_field *field;
 	bool pad_in_hid_field = false, pen_in_hid_field = false,
-		finger_in_hid_field = false;
+		finger_in_hid_field = false, true_pad = false;
 	int r;
 	int prev_collection = -1;
 
@@ -2736,6 +2732,8 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 			pen_in_hid_field = true;
 		if (WACOM_FINGER_FIELD(field))
 			finger_in_hid_field = true;
+		if (wacom_equivalent_usage(field->physical) == HID_DG_TABLETFUNCTIONKEY)
+			true_pad = true;
 	}
 
 	wacom_wac_battery_pre_report(hdev, report);
@@ -2759,6 +2757,9 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 	}
 
 	wacom_wac_battery_report(hdev, report);
+
+	if (true_pad && wacom->wacom_wac.pad_input)
+		wacom_wac_pad_report(hdev, report, field);
 }
 
 static int wacom_bpt_touch(struct wacom_wac *wacom)
-- 
2.7.4
