From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] HID: sony: Cache the output report for the Dualshock 4
Date: Fri, 17 Jan 2014 11:42:16 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1401171135240.7355@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:49113 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbaAQQmT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 11:42:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Retrieve and cache the output report for the Dualshock 4 in sony_probe()
instead of repeatedly walking the report list in the worker function.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---

 Apply against jikos/hid.git/for-3.14/sony

 drivers/hid/hid-sony.c | 63 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index edffe2c..4d5f6d1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -298,6 +298,7 @@ static const unsigned int buzz_keymap[] = {
 struct sony_sc {
 	struct hid_device *hdev;
 	struct led_classdev *leds[MAX_LEDS];
+	struct hid_report *output_report;
 	unsigned long quirks;
 	struct work_struct state_worker;
 
@@ -743,26 +744,9 @@ static void dualshock4_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	struct hid_device *hdev = sc->hdev;
-	struct list_head *head, *list;
-	struct hid_report *report;
-	__s32 *value;
-
-	list = &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
-
-	list_for_each(head, list) {
-		report = list_entry(head, struct hid_report, list);
-
-		/* Report 5 is used to send data to the controller via USB */
-		if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && report->id == 5)
-			break;
-	}
-
-	if (head == list) {
-		hid_err(hdev, "Dualshock 4 output report not found\n");
-		return;
-	}
+	struct hid_report *report = sc->output_report;
+	__s32 *value = report->field[0]->value;
 
-	value = report->field[0]->value;
 	value[0] = 0x03;
 
 #ifdef CONFIG_SONY_FF
@@ -822,6 +806,37 @@ static void sony_destroy_ff(struct hid_device *hdev)
 }
 #endif
 
+static int sony_set_output_report(struct sony_sc *sc, int req_id, int req_size)
+{
+	struct list_head *head, *list;
+	struct hid_report *report;
+	struct hid_device *hdev = sc->hdev;
+
+	list = &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
+
+	list_for_each(head, list) {
+		report = list_entry(head, struct hid_report, list);
+
+		if (report->id == req_id) {
+			if (report->size != req_size) {
+				hid_err(hdev, "Requested size of output report 0x%02x (%i bits) does not match actual size (%i bits)\n",
+					req_id, req_size, report->size);
+				return -1;
+			}
+			sc->output_report = report;
+			break;
+		}
+	}
+
+	if (head == list) {
+		hid_err(hdev, "Unable to locate output report 0x%02x\n",
+			req_id);
+		return -1;
+	}
+
+	return 0;
+}
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -858,6 +873,16 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
+	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+		/* Report 0x05 (31 bytes) is used to send data to the controller via USB */
+		ret = sony_set_output_report(sc, 0x05, 248);
+	} else {
+		ret = 0;
+	}
+
+	if (ret < 0)
+		goto err_stop;
+
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
-- 
1.8.3.2

