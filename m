From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 10/12] HID: uhid: implement SET_REPORT
Date: Tue, 29 Jul 2014 17:14:24 +0200
Message-ID: <1406646866-999-11-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:52407 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbaG2PPH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:15:07 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so9090438wgh.34
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:15:03 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

We so far lacked support for hid_hw_raw_request(..., HID_REQ_SET_REPORT);
Add support for it and simply forward the request to user-space. Note that
SET_REPORT is synchronous, just like GET_REPORT, even though it does not
provide any data back besides an error code.

If a transport layer does SET_REPORT asynchronously, they can just ACK it
immediately by writing an uhid_set_report_reply to uhid.

This patch re-uses the synchronous uhid-report infrastructure to query
user-space. Note that this means you cannot run SET_REPORT and GET_REPORT
in parallel. However, that has always been a restriction of HID and due to
its blocking nature, this is just fine. Maybe some future transport layer
supports parallel requests (very unlikely), however, until then lets not
over-complicate things and avoid request-lookup-tables.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c        | 206 +++++++++++++++++++++++++++++++---------------
 include/uapi/linux/uhid.h |  17 ++++
 2 files changed, 155 insertions(+), 68 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 8bf613e..1951148 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -49,6 +49,7 @@ struct uhid_device {
 	wait_queue_head_t report_wait;
 	bool report_running;
 	u32 report_id;
+	u32 report_type;
 	struct uhid_event report_buf;
 };
 
@@ -124,95 +125,166 @@ static int uhid_hid_parse(struct hid_device *hid)
 	return hid_parse_report(hid, uhid->rd_data, uhid->rd_size);
 }
 
+/* must be called with report_lock held */
+static int __uhid_report_queue_and_wait(struct uhid_device *uhid,
+					struct uhid_event *ev,
+					__u32 *report_id)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	*report_id = ++uhid->report_id;
+	uhid->report_type = ev->type;
+	uhid->report_running = true;
+	uhid_queue(uhid, ev);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
+	ret = wait_event_interruptible_timeout(uhid->report_wait,
+				!uhid->report_running || !uhid->running,
+				5 * HZ);
+	if (!ret || !uhid->running || uhid->report_running)
+		ret = -EIO;
+	else if (ret < 0)
+		ret = -ERESTARTSYS;
+	else
+		ret = 0;
+
+	uhid->report_running = false;
+
+	return ret;
+}
+
+static void uhid_report_wake_up(struct uhid_device *uhid, u32 id,
+				const struct uhid_event *ev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+
+	/* id for old report; drop it silently */
+	if (uhid->report_type != ev->type || uhid->report_id != id)
+		goto unlock;
+	if (!uhid->report_running)
+		goto unlock;
+
+	memcpy(&uhid->report_buf, ev, sizeof(*ev));
+	uhid->report_running = false;
+	wake_up_interruptible(&uhid->report_wait);
+
+unlock:
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+}
+
 static int uhid_hid_get_report(struct hid_device *hid, unsigned char rnum,
-			       __u8 *buf, size_t count, unsigned char rtype)
+			       u8 *buf, size_t count, u8 rtype)
 {
 	struct uhid_device *uhid = hid->driver_data;
-	__u8 report_type;
+	struct uhid_get_report_reply_req *req;
 	struct uhid_event *ev;
-	unsigned long flags;
 	int ret;
-	size_t uninitialized_var(len);
-	struct uhid_get_report_reply_req *req;
 
 	if (!uhid->running)
 		return -EIO;
 
-	switch (rtype) {
-	case HID_FEATURE_REPORT:
-		report_type = UHID_FEATURE_REPORT;
-		break;
-	case HID_OUTPUT_REPORT:
-		report_type = UHID_OUTPUT_REPORT;
-		break;
-	case HID_INPUT_REPORT:
-		report_type = UHID_INPUT_REPORT;
-		break;
-	default:
-		return -EINVAL;
-	}
+	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
+	if (!ev)
+		return -ENOMEM;
+
+	ev->type = UHID_GET_REPORT;
+	ev->u.get_report.rnum = rnum;
+	ev->u.get_report.rtype = rtype;
 
 	ret = mutex_lock_interruptible(&uhid->report_lock);
-	if (ret)
+	if (ret) {
+		kfree(ev);
 		return ret;
+	}
 
-	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
-	if (!ev) {
-		ret = -ENOMEM;
+	/* this _always_ takes ownership of @ev */
+	ret = __uhid_report_queue_and_wait(uhid, ev, &ev->u.get_report.id);
+	if (ret)
 		goto unlock;
+
+	req = &uhid->report_buf.u.get_report_reply;
+	if (req->err) {
+		ret = -EIO;
+	} else {
+		ret = min3(count, (size_t)req->size, (size_t)UHID_DATA_MAX);
+		memcpy(buf, req->data, ret);
 	}
 
-	spin_lock_irqsave(&uhid->qlock, flags);
-	ev->type = UHID_GET_REPORT;
-	ev->u.get_report.id = ++uhid->report_id;
-	ev->u.get_report.rnum = rnum;
-	ev->u.get_report.rtype = report_type;
+unlock:
+	mutex_unlock(&uhid->report_lock);
+	return ret;
+}
 
-	uhid->report_running = true;
-	uhid_queue(uhid, ev);
-	spin_unlock_irqrestore(&uhid->qlock, flags);
+static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
+			       const u8 *buf, size_t count, u8 rtype)
+{
+	struct uhid_device *uhid = hid->driver_data;
+	struct uhid_event *ev;
+	int ret;
 
-	ret = wait_event_interruptible_timeout(uhid->report_wait,
-				!uhid->report_running || !uhid->running,
-				5 * HZ);
+	if (!uhid->running || count > UHID_DATA_MAX)
+		return -EIO;
 
-	if (!ret || !uhid->running) {
-		ret = -EIO;
-	} else if (ret < 0) {
-		ret = -ERESTARTSYS;
-	} else {
-		spin_lock_irqsave(&uhid->qlock, flags);
-		req = &uhid->report_buf.u.get_report_reply;
+	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
+	if (!ev)
+		return -ENOMEM;
 
-		if (req->err) {
-			ret = -EIO;
-		} else {
-			ret = 0;
-			len = min(count,
-				min_t(size_t, req->size, UHID_DATA_MAX));
-			memcpy(buf, req->data, len);
-		}
+	ev->type = UHID_SET_REPORT;
+	ev->u.set_report.rnum = rnum;
+	ev->u.set_report.rtype = rtype;
+	ev->u.set_report.size = count;
+	memcpy(ev->u.set_report.data, buf, count);
 
-		spin_unlock_irqrestore(&uhid->qlock, flags);
+	ret = mutex_lock_interruptible(&uhid->report_lock);
+	if (ret) {
+		kfree(ev);
+		return ret;
 	}
 
-	uhid->report_running = false;
+	/* this _always_ takes ownership of @ev */
+	ret = __uhid_report_queue_and_wait(uhid, ev, &ev->u.set_report.id);
+	if (ret)
+		goto unlock;
+
+	if (uhid->report_buf.u.set_report_reply.err)
+		ret = -EIO;
+	else
+		ret = count;
 
 unlock:
 	mutex_unlock(&uhid->report_lock);
-	return ret ? ret : len;
+	return ret;
 }
 
 static int uhid_hid_raw_request(struct hid_device *hid, unsigned char reportnum,
 				__u8 *buf, size_t len, unsigned char rtype,
 				int reqtype)
 {
+	u8 u_rtype;
+
+	switch (rtype) {
+	case HID_FEATURE_REPORT:
+		u_rtype = UHID_FEATURE_REPORT;
+		break;
+	case HID_OUTPUT_REPORT:
+		u_rtype = UHID_OUTPUT_REPORT;
+		break;
+	case HID_INPUT_REPORT:
+		u_rtype = UHID_INPUT_REPORT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	switch (reqtype) {
 	case HID_REQ_GET_REPORT:
-		return uhid_hid_get_report(hid, reportnum, buf, len, rtype);
+		return uhid_hid_get_report(hid, reportnum, buf, len, u_rtype);
 	case HID_REQ_SET_REPORT:
-		/* TODO: implement proper SET_REPORT functionality */
-		return -ENOSYS;
+		return uhid_hid_set_report(hid, reportnum, buf, len, u_rtype);
 	default:
 		return -EIO;
 	}
@@ -490,25 +562,20 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
 static int uhid_dev_get_report_reply(struct uhid_device *uhid,
 				     struct uhid_event *ev)
 {
-	unsigned long flags;
-
 	if (!uhid->running)
 		return -EINVAL;
 
-	spin_lock_irqsave(&uhid->qlock, flags);
-
-	/* id for old report; drop it silently */
-	if (uhid->report_id != ev->u.get_report_reply.id)
-		goto unlock;
-	if (!uhid->report_running)
-		goto unlock;
+	uhid_report_wake_up(uhid, ev->u.get_report_reply.id, ev);
+	return 0;
+}
 
-	memcpy(&uhid->report_buf, ev, sizeof(*ev));
-	uhid->report_running = false;
-	wake_up_interruptible(&uhid->report_wait);
+static int uhid_dev_set_report_reply(struct uhid_device *uhid,
+				     struct uhid_event *ev)
+{
+	if (!uhid->running)
+		return -EINVAL;
 
-unlock:
-	spin_unlock_irqrestore(&uhid->qlock, flags);
+	uhid_report_wake_up(uhid, ev->u.set_report_reply.id, ev);
 	return 0;
 }
 
@@ -637,6 +704,9 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 	case UHID_GET_REPORT_REPLY:
 		ret = uhid_dev_get_report_reply(uhid, &uhid->input_buf);
 		break;
+	case UHID_SET_REPORT_REPLY:
+		ret = uhid_dev_set_report_reply(uhid, &uhid->input_buf);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 	}
diff --git a/include/uapi/linux/uhid.h b/include/uapi/linux/uhid.h
index 116536e..62aac0e 100644
--- a/include/uapi/linux/uhid.h
+++ b/include/uapi/linux/uhid.h
@@ -37,6 +37,8 @@ enum uhid_event_type {
 	UHID_GET_REPORT_REPLY,
 	UHID_CREATE2,
 	UHID_INPUT2,
+	UHID_SET_REPORT,
+	UHID_SET_REPORT_REPLY,
 };
 
 struct uhid_create2_req {
@@ -84,6 +86,19 @@ struct uhid_get_report_reply_req {
 	__u8 data[UHID_DATA_MAX];
 } __attribute__((__packed__));
 
+struct uhid_set_report_req {
+	__u32 id;
+	__u8 rnum;
+	__u8 rtype;
+	__u16 size;
+	__u8 data[UHID_DATA_MAX];
+} __attribute__((__packed__));
+
+struct uhid_set_report_reply_req {
+	__u32 id;
+	__u16 err;
+} __attribute__((__packed__));
+
 /*
  * Compat Layer
  * All these commands and requests are obsolete. You should avoid using them in
@@ -165,6 +180,8 @@ struct uhid_event {
 		struct uhid_get_report_reply_req get_report_reply;
 		struct uhid_create2_req create2;
 		struct uhid_input2_req input2;
+		struct uhid_set_report_req set_report;
+		struct uhid_set_report_reply_req set_report_reply;
 	} u;
 } __attribute__((__packed__));
 
-- 
2.0.3

