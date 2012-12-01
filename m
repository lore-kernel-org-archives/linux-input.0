From: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC v2 2/4] HID: uhid: Handle LED input events
Date: Sat,  1 Dec 2012 16:07:19 -0300
Message-ID: <1354388841-23854-3-git-send-email-andre.guedes@openbossa.org>
References: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34342 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab2LATHn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Dec 2012 14:07:43 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so688953vcd.19
        for <linux-input@vger.kernel.org>; Sat, 01 Dec 2012 11:07:42 -0800 (PST)
In-Reply-To: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com

This patch adds support for handling LED input events in uhid driver.
Others input events are sent to userspace as UHID_OUTPUT_EV events.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 drivers/hid/uhid.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 714cd8c..a5cf905 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -122,21 +122,31 @@ static int uhid_hid_input(struct input_dev *input, unsigned int type,
 	struct uhid_device *uhid = hid->driver_data;
 	unsigned long flags;
 	struct uhid_event *ev;
+	int ret;
 
-	ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
-	if (!ev)
-		return -ENOMEM;
+	switch (type) {
+	case EV_LED:
+		ret = hidinput_led_output_report(hid, code, value);
+		break;
 
-	ev->type = UHID_OUTPUT_EV;
-	ev->u.output_ev.type = type;
-	ev->u.output_ev.code = code;
-	ev->u.output_ev.value = value;
+	default:
+		ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
+		if (!ev)
+			return -ENOMEM;
 
-	spin_lock_irqsave(&uhid->qlock, flags);
-	uhid_queue(uhid, ev);
-	spin_unlock_irqrestore(&uhid->qlock, flags);
+		ev->type = UHID_OUTPUT_EV;
+		ev->u.output_ev.type = type;
+		ev->u.output_ev.code = code;
+		ev->u.output_ev.value = value;
 
-	return 0;
+		spin_lock_irqsave(&uhid->qlock, flags);
+		uhid_queue(uhid, ev);
+		spin_unlock_irqrestore(&uhid->qlock, flags);
+
+		ret = 0;
+	}
+
+	return ret;
 }
 
 static int uhid_hid_parse(struct hid_device *hid)
-- 
1.8.0.1

