From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] HID: ACRUX - handle gamepads with different report layout
Date: Thu,  4 Aug 2011 00:25:57 -0700
Message-ID: <1312442757-31241-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1312442757-31241-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:38583 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab1HDHbW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Aug 2011 03:31:22 -0400
Received: by iye16 with SMTP id 16so1206847iye.1
        for <linux-input@vger.kernel.org>; Thu, 04 Aug 2011 00:31:21 -0700 (PDT)
In-Reply-To: <1312442757-31241-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Sergei Kolzun <x0r@dv-life.ru>

From: Sergei Kolzun <x0r@dv-life.ru>

There are gamepads that share the same VID and PID but have different
report structure - instead of having 4 fields with one value they have
one field that can hold all 4 values. Make the driver cope with devices
using both styles.

Signed-off-by: Sergei Kolzun <x0r@dv-life.ru>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/hid/hid-axff.c |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-axff.c b/drivers/hid/hid-axff.c
index b455428..ef32aef 100644
--- a/drivers/hid/hid-axff.c
+++ b/drivers/hid/hid-axff.c
@@ -6,7 +6,7 @@
  * Xbox 360 controller.
  *
  * 1a34:0802 "ACRUX USB GAMEPAD 8116"
- *  - tested with a EXEQ EQ-PCU-02090 game controller.
+ *  - tested with an EXEQ EQ-PCU-02090 game controller.
  *
  * Copyright (c) 2010 Sergei Kolzun <x0r@dv-life.ru>
  */
@@ -45,7 +45,10 @@ static int axff_play(struct input_dev *dev, void *data, struct ff_effect *effect
 {
 	struct hid_device *hid = input_get_drvdata(dev);
 	struct axff_device *axff = data;
+	struct hid_report *report = axff->report;
+	int field_count = 0;
 	int left, right;
+	int i, j;
 
 	left = effect->u.rumble.strong_magnitude;
 	right = effect->u.rumble.weak_magnitude;
@@ -55,10 +58,14 @@ static int axff_play(struct input_dev *dev, void *data, struct ff_effect *effect
 	left = left * 0xff / 0xffff;
 	right = right * 0xff / 0xffff;
 
-	axff->report->field[0]->value[0] = left;
-	axff->report->field[1]->value[0] = right;
-	axff->report->field[2]->value[0] = left;
-	axff->report->field[3]->value[0] = right;
+	for (i = 0; i < report->maxfield; i++) {
+		for (j = 0; j < report->field[i]->report_count; j++) {
+			report->field[i]->value[j] =
+				field_count % 2 ? right : left;
+			field_count++;
+		}
+	}
+
 	dbg_hid("running with 0x%02x 0x%02x", left, right);
 	usbhid_submit_report(hid, axff->report, USB_DIR_OUT);
 
@@ -72,6 +79,8 @@ static int axff_init(struct hid_device *hid)
 	struct hid_input *hidinput = list_first_entry(&hid->inputs, struct hid_input, list);
 	struct list_head *report_list =&hid->report_enum[HID_OUTPUT_REPORT].report_list;
 	struct input_dev *dev = hidinput->input;
+	int field_count = 0;
+	int i, j;
 	int error;
 
 	if (list_empty(report_list)) {
@@ -80,9 +89,16 @@ static int axff_init(struct hid_device *hid)
 	}
 
 	report = list_first_entry(report_list, struct hid_report, list);
+	for (i = 0; i < report->maxfield; i++) {
+		for (j = 0; j < report->field[i]->report_count; j++) {
+			report->field[i]->value[j] = 0x00;
+			field_count++;
+		}
+	}
 
-	if (report->maxfield < 4) {
-		hid_err(hid, "no fields in the report: %d\n", report->maxfield);
+	if (field_count < 4) {
+		hid_err(hid, "not enough fields in the report: %d\n",
+			field_count);
 		return -ENODEV;
 	}
 
@@ -97,13 +113,9 @@ static int axff_init(struct hid_device *hid)
 		goto err_free_mem;
 
 	axff->report = report;
-	axff->report->field[0]->value[0] = 0x00;
-	axff->report->field[1]->value[0] = 0x00;
-	axff->report->field[2]->value[0] = 0x00;
-	axff->report->field[3]->value[0] = 0x00;
 	usbhid_submit_report(hid, axff->report, USB_DIR_OUT);
 
-	hid_info(hid, "Force Feedback for ACRUX game controllers by Sergei Kolzun<x0r@dv-life.ru>\n");
+	hid_info(hid, "Force Feedback for ACRUX game controllers by Sergei Kolzun <x0r@dv-life.ru>\n");
 
 	return 0;
 
-- 
1.7.6

