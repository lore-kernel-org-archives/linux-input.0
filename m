From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 06/12] HID: uhid: invert report_done and make non-atomic
Date: Tue, 29 Jul 2014 17:14:20 +0200
Message-ID: <1406646866-999-7-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:56890 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbaG2PO4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:14:56 -0400
Received: by mail-we0-f179.google.com with SMTP id u57so9285873wes.10
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:14:55 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

All accesses to @report_done are protected by qlock (or report-contexts).
No need to use an atomic.

While at it, invert the logic and call it "report_running". This is
similar to the uhid->running field and easier to read.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index db4e119..2d2025a 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -47,7 +47,7 @@ struct uhid_device {
 	/* blocking GET_REPORT support; state changes protected by qlock */
 	struct mutex report_lock;
 	wait_queue_head_t report_wait;
-	atomic_t report_done;
+	bool report_running;
 	u32 report_id;
 	struct uhid_event report_buf;
 };
@@ -168,13 +168,13 @@ static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
 	ev->u.feature.rnum = rnum;
 	ev->u.feature.rtype = report_type;
 
-	atomic_set(&uhid->report_done, 0);
+	uhid->report_running = true;
 	uhid_queue(uhid, ev);
 	spin_unlock_irqrestore(&uhid->qlock, flags);
 
 	ret = wait_event_interruptible_timeout(uhid->report_wait,
-			atomic_read(&uhid->report_done) || !uhid->running,
-			5 * HZ);
+				!uhid->report_running || !uhid->running,
+				5 * HZ);
 
 	if (!ret || !uhid->running) {
 		ret = -EIO;
@@ -196,7 +196,7 @@ static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
 		spin_unlock_irqrestore(&uhid->qlock, flags);
 	}
 
-	atomic_set(&uhid->report_done, 1);
+	uhid->report_running = false;
 
 unlock:
 	mutex_unlock(&uhid->report_lock);
@@ -500,11 +500,11 @@ static int uhid_dev_feature_answer(struct uhid_device *uhid,
 	/* id for old report; drop it silently */
 	if (uhid->report_id != ev->u.feature_answer.id)
 		goto unlock;
-	if (atomic_read(&uhid->report_done))
+	if (!uhid->report_running)
 		goto unlock;
 
 	memcpy(&uhid->report_buf, ev, sizeof(*ev));
-	atomic_set(&uhid->report_done, 1);
+	uhid->report_running = false;
 	wake_up_interruptible(&uhid->report_wait);
 
 unlock:
@@ -526,7 +526,6 @@ static int uhid_char_open(struct inode *inode, struct file *file)
 	init_waitqueue_head(&uhid->waitq);
 	init_waitqueue_head(&uhid->report_wait);
 	uhid->running = false;
-	atomic_set(&uhid->report_done, 1);
 
 	file->private_data = uhid;
 	nonseekable_open(inode, file);
-- 
2.0.3

