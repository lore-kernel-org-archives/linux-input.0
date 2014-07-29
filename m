From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 07/12] HID: uhid: add ABI compatible UHID_GET_REPORT replacing UHID_FEATURE
Date: Tue, 29 Jul 2014 17:14:21 +0200
Message-ID: <1406646866-999-8-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:48267 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbaG2PO6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:14:58 -0400
Received: by mail-we0-f177.google.com with SMTP id w62so9078109wes.22
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:14:56 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

The old hdev->hid_get_raw_report() was broken by design. It was never
clear what kind of HW request it should trigger. Benjamin fixed that with
the core HID cleanup, though we never really adjusted uhid.

Unfortunately, our old UHID_FEATURE command was modelled around the broken
hid_get_raw_report(). We converted it silently to the new GET_REPORT and
nothing broke. Make this explicit by renaming UHID_FEATURE to
UHID_GET_REPORT and UHID_FEATURE_ANSWER to UHID_GET_REPORT_REPLY.

Note that this is 100% ABI compatible to UHID_FEATURE. This is just a
rename. But we have to keep the old definitions around to not break API.

>From now on, UHID_GET_REPORT must trigger a GET_REPORT request on the
user-space hardware layer. All the ambiguity due to the weird "feature"
name should be gone now.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c        | 28 ++++++++++++++--------------
 include/uapi/linux/uhid.h | 23 +++++++++++++++++++++--
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 2d2025a..8f5e46b 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -124,8 +124,8 @@ static int uhid_hid_parse(struct hid_device *hid)
 	return hid_parse_report(hid, uhid->rd_data, uhid->rd_size);
 }
 
-static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
-			    __u8 *buf, size_t count, unsigned char rtype)
+static int uhid_hid_get_report(struct hid_device *hid, unsigned char rnum,
+			       __u8 *buf, size_t count, unsigned char rtype)
 {
 	struct uhid_device *uhid = hid->driver_data;
 	__u8 report_type;
@@ -133,7 +133,7 @@ static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
 	unsigned long flags;
 	int ret;
 	size_t uninitialized_var(len);
-	struct uhid_feature_answer_req *req;
+	struct uhid_get_report_reply_req *req;
 
 	if (!uhid->running)
 		return -EIO;
@@ -163,10 +163,10 @@ static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
 	}
 
 	spin_lock_irqsave(&uhid->qlock, flags);
-	ev->type = UHID_FEATURE;
-	ev->u.feature.id = ++uhid->report_id;
-	ev->u.feature.rnum = rnum;
-	ev->u.feature.rtype = report_type;
+	ev->type = UHID_GET_REPORT;
+	ev->u.get_report.id = ++uhid->report_id;
+	ev->u.get_report.rnum = rnum;
+	ev->u.get_report.rtype = report_type;
 
 	uhid->report_running = true;
 	uhid_queue(uhid, ev);
@@ -182,7 +182,7 @@ static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
 		ret = -ERESTARTSYS;
 	} else {
 		spin_lock_irqsave(&uhid->qlock, flags);
-		req = &uhid->report_buf.u.feature_answer;
+		req = &uhid->report_buf.u.get_report_reply;
 
 		if (req->err) {
 			ret = -EIO;
@@ -253,7 +253,7 @@ static int uhid_raw_request(struct hid_device *hid, unsigned char reportnum,
 {
 	switch (reqtype) {
 	case HID_REQ_GET_REPORT:
-		return uhid_hid_get_raw(hid, reportnum, buf, len, rtype);
+		return uhid_hid_get_report(hid, reportnum, buf, len, rtype);
 	case HID_REQ_SET_REPORT:
 		/* TODO: implement proper SET_REPORT functionality */
 		return -ENOSYS;
@@ -487,8 +487,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
 	return 0;
 }
 
-static int uhid_dev_feature_answer(struct uhid_device *uhid,
-				   struct uhid_event *ev)
+static int uhid_dev_get_report_reply(struct uhid_device *uhid,
+				     struct uhid_event *ev)
 {
 	unsigned long flags;
 
@@ -498,7 +498,7 @@ static int uhid_dev_feature_answer(struct uhid_device *uhid,
 	spin_lock_irqsave(&uhid->qlock, flags);
 
 	/* id for old report; drop it silently */
-	if (uhid->report_id != ev->u.feature_answer.id)
+	if (uhid->report_id != ev->u.get_report_reply.id)
 		goto unlock;
 	if (!uhid->report_running)
 		goto unlock;
@@ -634,8 +634,8 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 	case UHID_INPUT2:
 		ret = uhid_dev_input2(uhid, &uhid->input_buf);
 		break;
-	case UHID_FEATURE_ANSWER:
-		ret = uhid_dev_feature_answer(uhid, &uhid->input_buf);
+	case UHID_GET_REPORT_REPLY:
+		ret = uhid_dev_get_report_reply(uhid, &uhid->input_buf);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
diff --git a/include/uapi/linux/uhid.h b/include/uapi/linux/uhid.h
index 1e3b09c..0a08f2b 100644
--- a/include/uapi/linux/uhid.h
+++ b/include/uapi/linux/uhid.h
@@ -33,8 +33,10 @@ enum uhid_event_type {
 	UHID_OUTPUT,
 	UHID_OUTPUT_EV,			/* obsolete! */
 	UHID_INPUT,
-	UHID_FEATURE,
-	UHID_FEATURE_ANSWER,
+	UHID_FEATURE,			/* obsolete! use UHID_GET_REPORT */
+	UHID_GET_REPORT = UHID_FEATURE,
+	UHID_FEATURE_ANSWER,		/* obsolete! use UHID_GET_REPORT_REPLY */
+	UHID_GET_REPORT_REPLY = UHID_FEATURE_ANSWER,
 	UHID_CREATE2,
 	UHID_INPUT2,
 };
@@ -98,12 +100,20 @@ struct uhid_output_ev_req {
 	__s32 value;
 } __attribute__((__packed__));
 
+/* Obsolete! Kernel uses ABI compatible UHID_GET_REPORT. */
 struct uhid_feature_req {
 	__u32 id;
 	__u8 rnum;
 	__u8 rtype;
 } __attribute__((__packed__));
 
+struct uhid_get_report_req {
+	__u32 id;
+	__u8 rnum;
+	__u8 rtype;
+} __attribute__((__packed__));
+
+/* Obsolete! Use ABI compatible UHID_GET_REPORT_REPLY. */
 struct uhid_feature_answer_req {
 	__u32 id;
 	__u16 err;
@@ -111,6 +121,13 @@ struct uhid_feature_answer_req {
 	__u8 data[UHID_DATA_MAX];
 } __attribute__((__packed__));
 
+struct uhid_get_report_reply_req {
+	__u32 id;
+	__u16 err;
+	__u16 size;
+	__u8 data[UHID_DATA_MAX];
+} __attribute__((__packed__));
+
 struct uhid_event {
 	__u32 type;
 
@@ -120,7 +137,9 @@ struct uhid_event {
 		struct uhid_output_req output;
 		struct uhid_output_ev_req output_ev;
 		struct uhid_feature_req feature;
+		struct uhid_get_report_req get_report;
 		struct uhid_feature_answer_req feature_answer;
+		struct uhid_get_report_reply_req get_report_reply;
 		struct uhid_create2_req create2;
 		struct uhid_input2_req input2;
 	} u;
-- 
2.0.3

