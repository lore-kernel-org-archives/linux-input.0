From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 11/16] HID: uhid: forward output request to user-space
Date: Sun, 10 Jun 2012 15:16:23 +0200
Message-ID: <1339334188-21766-12-git-send-email-dh.herrmann@googlemail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33409 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208Ab2FJNQt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jun 2012 09:16:49 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so1506960wey.19
        for <linux-input@vger.kernel.org>; Sun, 10 Jun 2012 06:16:48 -0700 (PDT)
In-Reply-To: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

If the hid-driver wants to send standardized data to the device it uses a
linux input_event. We forward this to the user-space transport-level
driver so they can perform the requested action on the device.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/uhid.c   |   18 ++++++++++++++++++
 include/linux/uhid.h |    8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 0226ba3f..4dd693e 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -112,6 +112,24 @@ static void uhid_hid_close(struct hid_device *hid)
 static int uhid_hid_input(struct input_dev *input, unsigned int type,
 			  unsigned int code, int value)
 {
+	struct hid_device *hid = input_get_drvdata(input);
+	struct uhid_device *uhid = hid->driver_data;
+	unsigned long flags;
+	struct uhid_event *ev;
+
+	ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
+	if (!ev)
+		return -ENOMEM;
+
+	ev->type = UHID_OUTPUT_EV;
+	ev->u.output_ev.type = type;
+	ev->u.output_ev.code = code;
+	ev->u.output_ev.value = value;
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	uhid_queue(uhid, ev);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
 	return 0;
 }
 
diff --git a/include/linux/uhid.h b/include/linux/uhid.h
index 351650b..3fa4849 100644
--- a/include/linux/uhid.h
+++ b/include/linux/uhid.h
@@ -29,6 +29,7 @@ enum uhid_event_type {
 	UHID_STOP,
 	UHID_OPEN,
 	UHID_CLOSE,
+	UHID_OUTPUT_EV,
 	UHID_INPUT,
 };
 
@@ -53,12 +54,19 @@ struct uhid_input_req {
 	__u16 size;
 } __attribute__((__packed__));
 
+struct uhid_output_ev_req {
+	__u16 type;
+	__u16 code;
+	__s32 value;
+} __attribute__((__packed__));
+
 struct uhid_event {
 	__u32 type;
 
 	union {
 		struct uhid_create_req create;
 		struct uhid_input_req input;
+		struct uhid_output_ev_req output_ev;
 	} u;
 } __attribute__((__packed__));
 
-- 
1.7.10.4

