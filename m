From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH v2 1/9] HID: core: add "report" hook, called once the report has been parsed
Date: Thu, 31 Jan 2013 17:22:23 +0100
Message-ID: <1359649351-11092-2-git-send-email-benjamin.tissoires@gmail.com>
References: <1359649351-11092-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:48451 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3AaQa3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jan 2013 11:30:29 -0500
In-Reply-To: <1359649351-11092-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This callback is called when the parsing of the report has been done
by hid-core (so after the calls to .event). The hid drivers can now
have access to the whole report by relying on the values stored in
the different fields.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-core.c | 4 ++++
 include/linux/hid.h    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5ae2cb1..b671e4e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1195,6 +1195,7 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 {
 	struct hid_report_enum *report_enum = hid->report_enum + type;
 	struct hid_report *report;
+	struct hid_driver *hdrv;
 	unsigned int a;
 	int rsize, csize = size;
 	u8 *cdata = data;
@@ -1231,6 +1232,9 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 	if (hid->claimed != HID_CLAIMED_HIDRAW) {
 		for (a = 0; a < report->maxfield; a++)
 			hid_input_field(hid, report->field[a], cdata, interrupt);
+		hdrv = hid->driver;
+		if (hdrv && hdrv->report)
+			hdrv->report(hid, report);
 	}
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 828726c..e14b465 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -589,6 +589,7 @@ struct hid_usage_id {
  * @raw_event: if report in report_table, this hook is called (NULL means nop)
  * @usage_table: on which events to call event (NULL means all)
  * @event: if usage in usage_table, this hook is called (NULL means nop)
+ * @report: this hook is called after parsing a report (NULL means nop)
  * @report_fixup: called before report descriptor parsing (NULL means nop)
  * @input_mapping: invoked on input registering before mapping an usage
  * @input_mapped: invoked on input registering after mapping an usage
@@ -627,6 +628,7 @@ struct hid_driver {
 	const struct hid_usage_id *usage_table;
 	int (*event)(struct hid_device *hdev, struct hid_field *field,
 			struct hid_usage *usage, __s32 value);
+	void (*report)(struct hid_device *hdev, struct hid_report *report);
 
 	__u8 *(*report_fixup)(struct hid_device *hdev, __u8 *buf,
 			unsigned int *size);
-- 
1.8.1

