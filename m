From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 3/4] HID: Add the transport-driver function to the uhid driver
Date: Wed, 22 Jan 2014 13:49:43 -0500
Message-ID: <1390416584-3667-4-git-send-email-frank.praznik@oh.rr.com>
References: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:48404 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360AbaAVSuU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jan 2014 13:50:20 -0500
In-Reply-To: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add the uhid_output_report transport-driver function to the uhid driver.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 drivers/hid/uhid.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index cedc6da..f5a2b19 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -244,12 +244,39 @@ static int uhid_hid_output_raw(struct hid_device *hid, __u8 *buf, size_t count,
 	return count;
 }
 
+static int uhid_hid_output_report(struct hid_device *hid, __u8 *buf,
+				  size_t count)
+{
+	struct uhid_device *uhid = hid->driver_data;
+	unsigned long flags;
+	struct uhid_event *ev;
+
+	if (count < 1 || count > UHID_DATA_MAX)
+		return -EINVAL;
+
+	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
+	if (!ev)
+		return -ENOMEM;
+
+	ev->type = UHID_OUTPUT;
+	ev->u.output.size = count;
+	ev->u.output.rtype = UHID_OUTPUT_REPORT;
+	memcpy(ev->u.output.data, buf, count);
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	uhid_queue(uhid, ev);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
+	return count;
+}
+
 static struct hid_ll_driver uhid_hid_driver = {
 	.start = uhid_hid_start,
 	.stop = uhid_hid_stop,
 	.open = uhid_hid_open,
 	.close = uhid_hid_close,
 	.parse = uhid_hid_parse,
+	.output_report = uhid_hid_output_report,
 };
 
 #ifdef CONFIG_COMPAT
-- 
1.8.4.2

