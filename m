From: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC] HID: uhid: Handle LED input events
Date: Thu,  1 Nov 2012 18:55:39 -0300
Message-ID: <1351806939-4925-1-git-send-email-andre.guedes@openbossa.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ye0-f174.google.com ([209.85.213.174]:44515 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762334Ab2KAV4m (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Nov 2012 17:56:42 -0400
Received: by mail-ye0-f174.google.com with SMTP id m12so594310yen.19
        for <linux-input@vger.kernel.org>; Thu, 01 Nov 2012 14:56:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com

This patches adds support for handling LED input events in uhid
driver.

When uhid receives an input LED event, we set the proper field,
create the output report and send it to userspace as UHID_OUTPUT
event. Others input events are sent to userspace as UHID_OUTPUT_EV
events.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 drivers/hid/uhid.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 714cd8c..e7b7cdc 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -122,15 +122,40 @@ static int uhid_hid_input(struct input_dev *input, unsigned int type,
 	struct uhid_device *uhid = hid->driver_data;
 	unsigned long flags;
 	struct uhid_event *ev;
+	struct hid_field *field;
+	struct hid_report *report;
+	int offset;
 
 	ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
 	if (!ev)
 		return -ENOMEM;
 
-	ev->type = UHID_OUTPUT_EV;
-	ev->u.output_ev.type = type;
-	ev->u.output_ev.code = code;
-	ev->u.output_ev.value = value;
+	switch (type) {
+	case EV_LED:
+		offset = hidinput_find_field(hid, type, code, &field);
+		if (offset == -1) {
+			hid_warn(input, "event field not found\n");
+			kfree(ev);
+			return -1;
+		}
+
+		hid_set_field(field, offset, value);
+
+		report = field->report;
+
+		ev->type = UHID_OUTPUT;
+		ev->u.output.rtype = UHID_OUTPUT_REPORT;
+		hid_output_report(report, ev->u.output.data);
+		ev->u.output.size = ((report->size - 1) >> 3) + 1 +
+							(report->id > 0);
+		break;
+
+	default:
+		ev->type = UHID_OUTPUT_EV;
+		ev->u.output_ev.type = type;
+		ev->u.output_ev.code = code;
+		ev->u.output_ev.value = value;
+	}
 
 	spin_lock_irqsave(&uhid->qlock, flags);
 	uhid_queue(uhid, ev);
-- 
1.8.0

