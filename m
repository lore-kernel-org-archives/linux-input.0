From: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC v2 1/4] HID: Add generic handler for LED input events
Date: Sat,  1 Dec 2012 16:07:18 -0300
Message-ID: <1354388841-23854-2-git-send-email-andre.guedes@openbossa.org>
References: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42104 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab2LATHl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Dec 2012 14:07:41 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so497377vby.19
        for <linux-input@vger.kernel.org>; Sat, 01 Dec 2012 11:07:40 -0800 (PST)
In-Reply-To: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com

This patch adds the helper hidinput_led_output_report to handle LED
input events.

This helper implements a generic handler for LED input events. It
basically sets the proper field, builds the output report and call
hid_output_raw_report callback to send the raw report to the device.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 drivers/hid/hid-input.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h     |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 21b196c..957f510 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1300,3 +1300,54 @@ void hidinput_disconnect(struct hid_device *hid)
 }
 EXPORT_SYMBOL_GPL(hidinput_disconnect);
 
+/*
+ * hidinput_led_output_report - Generic handler for LED input events
+ *
+ * @hid: hid device
+ * @code: input event code
+ * @value: input event value
+ *
+ * This function implements a generic handler for LED input events. It
+ * sets the proper LED field, builds the output report and sends it to
+ * device.
+ *
+ * This helper relies on device's .hid_output_raw_report() to send
+ * reports to the device.
+ */
+int hidinput_led_output_report(struct hid_device *hid, unsigned int code,
+				    int value)
+{
+	int offset;
+	struct hid_field *field;
+	struct hid_report *report;
+	u8 *buf;
+	int len;
+	int ret;
+
+	if (!hid->hid_output_raw_report)
+		return -ENOTSUPP;
+
+	offset = hidinput_find_field(hid, EV_LED, code, &field);
+	if (offset == -1)
+		return -ENOENT;
+
+	hid_set_field(field, offset, value);
+
+	report = field->report;
+
+	len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
+
+	buf = kzalloc(len, GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+
+	hid_output_report(report, buf);
+
+	ret = hid->hid_output_raw_report(hid, buf, len, HID_OUTPUT_REPORT);
+
+	kfree(buf);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hidinput_led_output_report);
+
diff --git a/include/linux/hid.h b/include/linux/hid.h
index d2c42dd..bd02df3 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -701,6 +701,8 @@ extern void hidinput_hid_event(struct hid_device *, struct hid_field *, struct h
 extern void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
 extern int hidinput_connect(struct hid_device *hid, unsigned int force);
 extern void hidinput_disconnect(struct hid_device *);
+extern int hidinput_led_output_report(struct hid_device *hid,
+					unsigned int code, int value);
 
 int hid_set_field(struct hid_field *, unsigned, __s32);
 int hid_input_report(struct hid_device *, int type, u8 *, int, int);
-- 
1.8.0.1

