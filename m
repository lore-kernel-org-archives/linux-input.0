From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 11/12] HID: uhid: report to user-space whether reports are numbered
Date: Tue, 29 Jul 2014 17:14:25 +0200
Message-ID: <1406646866-999-12-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:45850 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbaG2PPF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:15:05 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so9127959wes.11
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:15:04 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

This makes UHID_START include a "dev_flags" field that describes details
of the hid-device in the kernel. The first flags we introduce describe
whether a given report-type uses numbered reports. This is useful for
transport layers that force report-numbers and therefore might have to
prefix kernel-provided HID-messages with the report-number.

Currently, only HoG needs this and the spec only talks about "global
report numbers". That is, it's a global boolean not a per-type boolean.
However, given the quirks we already have in kernel-space, a per-type
value seems much more appropriate.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c        | 21 ++++++++++++++++++++-
 include/uapi/linux/uhid.h | 11 +++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 1951148..f6ec5ea 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -92,8 +92,27 @@ static int uhid_queue_event(struct uhid_device *uhid, __u32 event)
 static int uhid_hid_start(struct hid_device *hid)
 {
 	struct uhid_device *uhid = hid->driver_data;
+	struct uhid_event *ev;
+	unsigned long flags;
+
+	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
+	if (!ev)
+		return -ENOMEM;
+
+	ev->type = UHID_START;
 
-	return uhid_queue_event(uhid, UHID_START);
+	if (hid->report_enum[HID_FEATURE_REPORT].numbered)
+		ev->u.start.dev_flags |= UHID_DEV_NUMBERED_FEATURE_REPORTS;
+	if (hid->report_enum[HID_OUTPUT_REPORT].numbered)
+		ev->u.start.dev_flags |= UHID_DEV_NUMBERED_OUTPUT_REPORTS;
+	if (hid->report_enum[HID_INPUT_REPORT].numbered)
+		ev->u.start.dev_flags |= UHID_DEV_NUMBERED_INPUT_REPORTS;
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	uhid_queue(uhid, ev);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
+	return 0;
 }
 
 static void uhid_hid_stop(struct hid_device *hid)
diff --git a/include/uapi/linux/uhid.h b/include/uapi/linux/uhid.h
index 62aac0e..aaa86d6 100644
--- a/include/uapi/linux/uhid.h
+++ b/include/uapi/linux/uhid.h
@@ -54,6 +54,16 @@ struct uhid_create2_req {
 	__u8 rd_data[HID_MAX_DESCRIPTOR_SIZE];
 } __attribute__((__packed__));
 
+enum uhid_dev_flag {
+	UHID_DEV_NUMBERED_FEATURE_REPORTS			= (1ULL << 0),
+	UHID_DEV_NUMBERED_OUTPUT_REPORTS			= (1ULL << 1),
+	UHID_DEV_NUMBERED_INPUT_REPORTS				= (1ULL << 2),
+};
+
+struct uhid_start_req {
+	__u64 dev_flags;
+};
+
 #define UHID_DATA_MAX 4096
 
 enum uhid_report_type {
@@ -182,6 +192,7 @@ struct uhid_event {
 		struct uhid_input2_req input2;
 		struct uhid_set_report_req set_report;
 		struct uhid_set_report_reply_req set_report_reply;
+		struct uhid_start_req start;
 	} u;
 } __attribute__((__packed__));
 
-- 
2.0.3

