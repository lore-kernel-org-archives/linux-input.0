From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/4] HID: multitouch: simplify the application retrieval
Date: Tue,  4 Sep 2018 15:31:15 +0200
Message-ID: <20180904133115.5111-5-benjamin.tissoires@redhat.com>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Now that the application is simply stored in struct hid_input, we can
overwrite it in mt_input_mapping() for the faulty egalax and have a
simpler suffix processing in mt_input_configured()

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 72 ++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index da954f3f4da7..f7c6de2b6730 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1319,6 +1319,13 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return mt_touch_input_mapping(hdev, hi, field, usage, bit, max,
 					      application);
 
+	/*
+	 * some egalax touchscreens have "application == DG_TOUCHSCREEN"
+	 * for the stylus. Overwrite the hid_input application
+	 */
+	if (field->physical == HID_DG_STYLUS)
+		hi->application = HID_DG_STYLUS;
+
 	/* let hid-core decide for the others */
 	return 0;
 }
@@ -1507,14 +1514,12 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	struct mt_device *td = hid_get_drvdata(hdev);
 	char *name;
 	const char *suffix = NULL;
-	unsigned int application = 0;
 	struct mt_report_data *rdata;
 	struct mt_application *mt_application = NULL;
 	struct hid_report *report;
 	int ret;
 
 	list_for_each_entry(report, &hi->reports, hidinput_list) {
-		application = report->application;
 		rdata = mt_find_report_data(td, report);
 		if (!rdata) {
 			hid_err(hdev, "failed to allocate data for report\n");
@@ -1529,46 +1534,33 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 			if (ret)
 				return ret;
 		}
-
-		/*
-		 * some egalax touchscreens have "application == DG_TOUCHSCREEN"
-		 * for the stylus. Check this first, and then rely on
-		 * the application field.
-		 */
-		if (report->field[0]->physical == HID_DG_STYLUS) {
-			suffix = "Pen";
-			/* force BTN_STYLUS to allow tablet matching in udev */
-			__set_bit(BTN_STYLUS, hi->input->keybit);
-		}
 	}
 
-	if (!suffix) {
-		switch (application) {
-		case HID_GD_KEYBOARD:
-		case HID_GD_KEYPAD:
-		case HID_GD_MOUSE:
-		case HID_DG_TOUCHPAD:
-		case HID_GD_SYSTEM_CONTROL:
-		case HID_CP_CONSUMER_CONTROL:
-		case HID_GD_WIRELESS_RADIO_CTLS:
-		case HID_GD_SYSTEM_MULTIAXIS:
-			/* already handled by hid core */
-			break;
-		case HID_DG_TOUCHSCREEN:
-			/* we do not set suffix = "Touchscreen" */
-			hi->input->name = hdev->name;
-			break;
-		case HID_DG_STYLUS:
-			/* force BTN_STYLUS to allow tablet matching in udev */
-			__set_bit(BTN_STYLUS, hi->input->keybit);
-			break;
-		case HID_VD_ASUS_CUSTOM_MEDIA_KEYS:
-			suffix = "Custom Media Keys";
-			break;
-		default:
-			suffix = "UNKNOWN";
-			break;
-		}
+	switch (hi->application) {
+	case HID_GD_KEYBOARD:
+	case HID_GD_KEYPAD:
+	case HID_GD_MOUSE:
+	case HID_DG_TOUCHPAD:
+	case HID_GD_SYSTEM_CONTROL:
+	case HID_CP_CONSUMER_CONTROL:
+	case HID_GD_WIRELESS_RADIO_CTLS:
+	case HID_GD_SYSTEM_MULTIAXIS:
+		/* already handled by hid core */
+		break;
+	case HID_DG_TOUCHSCREEN:
+		/* we do not set suffix = "Touchscreen" */
+		hi->input->name = hdev->name;
+		break;
+	case HID_DG_STYLUS:
+		/* force BTN_STYLUS to allow tablet matching in udev */
+		__set_bit(BTN_STYLUS, hi->input->keybit);
+		break;
+	case HID_VD_ASUS_CUSTOM_MEDIA_KEYS:
+		suffix = "Custom Media Keys";
+		break;
+	default:
+		suffix = "UNKNOWN";
+		break;
 	}
 
 	if (suffix) {
-- 
2.14.3
