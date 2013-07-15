From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 6/8] HID: uhid: use generic hidinput_input_event()
Date: Mon, 15 Jul 2013 19:10:15 +0200
Message-ID: <1373908217-16748-7-git-send-email-dh.herrmann@gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:58526 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab3GORKq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 13:10:46 -0400
Received: by mail-ea0-f176.google.com with SMTP id z15so7812504ead.7
        for <linux-input@vger.kernel.org>; Mon, 15 Jul 2013 10:10:45 -0700 (PDT)
In-Reply-To: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>, David Herrmann <dh.herrmann@gmail.com>

HID core provides the same functionality and can convert the input event
to a raw output report. We can thus drop UHID_OUTPUT_EV and rely on the
mandatory UHID_OUTPUT.

User-space wasn't able to do anything with UHID_OUTPUT_EV, anyway. They
don't have access to the report fields.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 Documentation/hid/uhid.txt |  4 +++-
 drivers/hid/uhid.c         | 25 -------------------------
 include/uapi/linux/uhid.h  |  4 +++-
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
index 3c74121..dc35a2b 100644
--- a/Documentation/hid/uhid.txt
+++ b/Documentation/hid/uhid.txt
@@ -149,11 +149,13 @@ needs. Only UHID_OUTPUT and UHID_OUTPUT_EV have payloads.
   is of type "struct uhid_data_req".
   This may be received even though you haven't received UHID_OPEN, yet.
 
-  UHID_OUTPUT_EV:
+  UHID_OUTPUT_EV (obsolete):
   Same as UHID_OUTPUT but this contains a "struct input_event" as payload. This
   is called for force-feedback, LED or similar events which are received through
   an input device by the HID subsystem. You should convert this into raw reports
   and send them to your device similar to events of type UHID_OUTPUT.
+  This is no longer sent by newer kernels. Instead, HID core converts it into a
+  raw output report and sends it via UHID_OUTPUT.
 
   UHID_FEATURE:
   This event is sent if the kernel driver wants to perform a feature request as
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index fc307e0..f53f2d5 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -116,30 +116,6 @@ static void uhid_hid_close(struct hid_device *hid)
 	uhid_queue_event(uhid, UHID_CLOSE);
 }
 
-static int uhid_hid_input(struct input_dev *input, unsigned int type,
-			  unsigned int code, int value)
-{
-	struct hid_device *hid = input_get_drvdata(input);
-	struct uhid_device *uhid = hid->driver_data;
-	unsigned long flags;
-	struct uhid_event *ev;
-
-	ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
-	if (!ev)
-		return -ENOMEM;
-
-	ev->type = UHID_OUTPUT_EV;
-	ev->u.output_ev.type = type;
-	ev->u.output_ev.code = code;
-	ev->u.output_ev.value = value;
-
-	spin_lock_irqsave(&uhid->qlock, flags);
-	uhid_queue(uhid, ev);
-	spin_unlock_irqrestore(&uhid->qlock, flags);
-
-	return 0;
-}
-
 static int uhid_hid_parse(struct hid_device *hid)
 {
 	struct uhid_device *uhid = hid->driver_data;
@@ -273,7 +249,6 @@ static struct hid_ll_driver uhid_hid_driver = {
 	.stop = uhid_hid_stop,
 	.open = uhid_hid_open,
 	.close = uhid_hid_close,
-	.hidinput_input_event = uhid_hid_input,
 	.parse = uhid_hid_parse,
 };
 
diff --git a/include/uapi/linux/uhid.h b/include/uapi/linux/uhid.h
index e9ed951..414b74b 100644
--- a/include/uapi/linux/uhid.h
+++ b/include/uapi/linux/uhid.h
@@ -30,7 +30,7 @@ enum uhid_event_type {
 	UHID_OPEN,
 	UHID_CLOSE,
 	UHID_OUTPUT,
-	UHID_OUTPUT_EV,
+	UHID_OUTPUT_EV,			/* obsolete! */
 	UHID_INPUT,
 	UHID_FEATURE,
 	UHID_FEATURE_ANSWER,
@@ -69,6 +69,8 @@ struct uhid_output_req {
 	__u8 rtype;
 } __attribute__((__packed__));
 
+/* Obsolete! Newer kernels will no longer send these events but instead convert
+ * it into raw output reports via UHID_OUTPUT. */
 struct uhid_output_ev_req {
 	__u16 type;
 	__u16 code;
-- 
1.8.3.2

