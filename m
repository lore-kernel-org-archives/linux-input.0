From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 2/2] HID: google: Detect base folded usage instead of hard-coding whiskers
Date: Thu,  3 Oct 2019 11:18:00 +0800
Message-ID: <20191003031800.120237-2-drinkcat@chromium.org>
References: <20191003031800.120237-1-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191003031800.120237-1-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dtor@chromium.org, ikjn@chromium.org
List-Id: linux-input@vger.kernel.org

Some other hammer-like device will emit a similar code, let's look for
the folded event in HID usage table, instead of hard-coding whiskers
in many places.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 53 ++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index a52535ebc6fe92c..2aa4ed157aec875 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -370,7 +370,7 @@ static void hammer_unregister_leds(struct hid_device *hdev)
 
 #define HID_UP_GOOGLEVENDOR	0xffd10000
 #define HID_VD_KBD_FOLDED	0x00000019
-#define WHISKERS_KBD_FOLDED	(HID_UP_GOOGLEVENDOR | HID_VD_KBD_FOLDED)
+#define HID_USAGE_KBD_FOLDED	(HID_UP_GOOGLEVENDOR | HID_VD_KBD_FOLDED)
 
 /* HID usage for keyboard backlight (Alphanumeric display brightness) */
 #define HID_AD_BRIGHTNESS	0x00140046
@@ -380,8 +380,7 @@ static int hammer_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 				struct hid_usage *usage,
 				unsigned long **bit, int *max)
 {
-	if (hdev->product == USB_DEVICE_ID_GOOGLE_WHISKERS &&
-	    usage->hid == WHISKERS_KBD_FOLDED) {
+	if (usage->hid == HID_USAGE_KBD_FOLDED) {
 		/*
 		 * We do not want to have this usage mapped as it will get
 		 * mixed in with "base attached" signal and delivered over
@@ -398,8 +397,7 @@ static int hammer_event(struct hid_device *hid, struct hid_field *field,
 {
 	unsigned long flags;
 
-	if (hid->product == USB_DEVICE_ID_GOOGLE_WHISKERS &&
-	    usage->hid == WHISKERS_KBD_FOLDED) {
+	if (usage->hid == HID_USAGE_KBD_FOLDED) {
 		spin_lock_irqsave(&cbas_ec_lock, flags);
 
 		/*
@@ -424,33 +422,22 @@ static int hammer_event(struct hid_device *hid, struct hid_field *field,
 	return 0;
 }
 
-static bool hammer_is_keyboard_interface(struct hid_device *hdev)
+static bool hammer_has_usage(struct hid_device *hdev, unsigned int report_type,
+			unsigned application, unsigned usage)
 {
-	struct hid_report_enum *re = &hdev->report_enum[HID_INPUT_REPORT];
-	struct hid_report *report;
-
-	list_for_each_entry(report, &re->report_list, list)
-		if (report->application == HID_GD_KEYBOARD)
-			return true;
-
-	return false;
-}
-
-static bool hammer_has_backlight_control(struct hid_device *hdev)
-{
-	struct hid_report_enum *re = &hdev->report_enum[HID_OUTPUT_REPORT];
+	struct hid_report_enum *re = &hdev->report_enum[report_type];
 	struct hid_report *report;
 	int i, j;
 
 	list_for_each_entry(report, &re->report_list, list) {
-		if (report->application != HID_GD_KEYBOARD)
+		if (report->application != application)
 			continue;
 
 		for (i = 0; i < report->maxfield; i++) {
 			struct hid_field *field = report->field[i];
 
 			for (j = 0; j < field->maxusage; j++)
-				if (field->usage[j].hid == HID_AD_BRIGHTNESS)
+				if (field->usage[j].hid == usage)
 					return true;
 		}
 	}
@@ -458,6 +445,18 @@ static bool hammer_has_backlight_control(struct hid_device *hdev)
 	return false;
 }
 
+static bool hammer_has_folded_event(struct hid_device *hdev)
+{
+	return hammer_has_usage(hdev, HID_INPUT_REPORT,
+				HID_GD_KEYBOARD, HID_USAGE_KBD_FOLDED);
+}
+
+static bool hammer_has_backlight_control(struct hid_device *hdev)
+{
+	return hammer_has_usage(hdev, HID_OUTPUT_REPORT,
+				HID_GD_KEYBOARD, HID_AD_BRIGHTNESS);
+}
+
 static int hammer_probe(struct hid_device *hdev,
 			const struct hid_device_id *id)
 {
@@ -473,12 +472,11 @@ static int hammer_probe(struct hid_device *hdev,
 
 	/*
 	 * We always want to poll for, and handle tablet mode events from
-	 * Whiskers, even when nobody has opened the input device. This also
-	 * prevents the hid core from dropping early tablet mode events from
-	 * the device.
+	 * devices that have folded usage, even when nobody has opened the input
+	 * device. This also prevents the hid core from dropping early tablet
+	 * mode events from the device.
 	 */
-	if (hdev->product == USB_DEVICE_ID_GOOGLE_WHISKERS &&
-	    hammer_is_keyboard_interface(hdev)) {
+	if (hammer_has_folded_event(hdev)) {
 		hdev->quirks |= HID_QUIRK_ALWAYS_POLL;
 		error = hid_hw_open(hdev);
 		if (error)
@@ -500,8 +498,7 @@ static void hammer_remove(struct hid_device *hdev)
 {
 	unsigned long flags;
 
-	if (hdev->product == USB_DEVICE_ID_GOOGLE_WHISKERS &&
-			hammer_is_keyboard_interface(hdev)) {
+	if (hammer_has_folded_event(hdev)) {
 		hid_hw_close(hdev);
 
 		/*
-- 
2.23.0.444.g18eeb5a265-goog
