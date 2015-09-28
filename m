From: Brent Adam <brentadamdev@gmail.com>
Subject: [PATCH] HID: hid-multitouch.c: fix formatting warnings
Date: Mon, 28 Sep 2015 14:03:14 -0600
Message-ID: <1443470594-9878-1-git-send-email-brentadam@smarttech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34965 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbbI1UDp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 16:03:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Brent Adam <brentadam@smarttech.com>

Fixed the following checkpatch.pl warnings:
WARNING: line over 80 characters: line 163
WARNING: Missing a blank line after declarations: line 359
WARNING: Missing a blank line after declarations: line 572
WARNING: Missing a blank line after declarations: line 708
WARNING: Missing a blank line after declarations: line 926
WARNING: Possible unnecessary 'out of memory' message: line 1034
WARNING: Possible unnecessary 'out of memory' message: line 1048
WARNING: line over 80 characters: line 1390

Signed-off-by: Brent Adam <brentadam@smarttech.com>
---
 drivers/hid/hid-multitouch.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 426b2f1..662296e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -160,7 +160,8 @@ static void mt_post_parse(struct mt_device *td);
 #define MT_MAX_MAXCONTACT	250
 
 #define MT_USB_DEVICE(v, p)	HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH, v, p)
-#define MT_BT_DEVICE(v, p)	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_MULTITOUCH, v, p)
+#define MT_BT_DEVICE(v, p)	HID_DEVICE(BUS_BLUETOOTH, \
+					   HID_GROUP_MULTITOUCH, v, p)
 
 /*
  * these device-dependent functions determine what slot corresponds
@@ -356,6 +357,7 @@ static void set_abs(struct input_dev *input, unsigned int code,
 	int fmin = field->logical_minimum;
 	int fmax = field->logical_maximum;
 	int fuzz = snratio ? (fmax - fmin) / snratio : 0;
+
 	input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
 	input_abs_set_res(input, code, hidinput_calc_abs_res(field, code));
 }
@@ -569,6 +571,7 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 
 		if ((td->mtclass.quirks & MT_QUIRK_IGNORE_DUPLICATES) && mt) {
 			struct input_mt_slot *slot = &mt->slots[slotnum];
+
 			if (input_mt_is_active(slot) &&
 			    input_mt_is_used(mt, slot))
 				return;
@@ -705,6 +708,7 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 	if (td->cc_index >= 0) {
 		struct hid_field *field = report->field[td->cc_index];
 		int value = field->value[td->cc_value_index];
+
 		if (value)
 			td->num_expected = value;
 	}
@@ -923,6 +927,7 @@ static void mt_post_parse(struct mt_device *td)
 
 	if (td->touches_by_report > 0) {
 		int field_count_per_touch = f->length / td->touches_by_report;
+
 		td->last_slot_field = f->usages[field_count_per_touch - 1];
 	}
 
@@ -1030,10 +1035,9 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->quirks |= HID_QUIRK_NO_INIT_INPUT_REPORTS;
 
 	td = devm_kzalloc(&hdev->dev, sizeof(struct mt_device), GFP_KERNEL);
-	if (!td) {
-		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
+	if (!td)
 		return -ENOMEM;
-	}
+
 	td->mtclass = *mtclass;
 	td->inputmode = -1;
 	td->maxcontact_report_id = -1;
@@ -1044,10 +1048,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	td->fields = devm_kzalloc(&hdev->dev, sizeof(struct mt_fields),
 				  GFP_KERNEL);
-	if (!td->fields) {
-		dev_err(&hdev->dev, "cannot allocate multitouch fields data\n");
+	if (!td->fields)
 		return -ENOMEM;
-	}
 
 	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
 		td->serial_maybe = true;
@@ -1387,7 +1389,8 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_XIROKU_CSR2) },
 
 	/* Generic MT device */
-	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH, HID_ANY_ID, HID_ANY_ID) },
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH, HID_ANY_ID,
+		     HID_ANY_ID) },
 
 	/* Generic Win 8 certified MT device */
 	{  .driver_data = MT_CLS_WIN_8,
-- 
2.1.4

