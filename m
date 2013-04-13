From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 06/21] HID: wiimote: wake up if output queue failed
Date: Sat, 13 Apr 2013 12:47:47 +0200
Message-ID: <1365850082-3585-7-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:59071 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3DMKsg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:36 -0400
Received: by mail-ee0-f47.google.com with SMTP id t10so1569873eei.34
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:35 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Our output queue is asynchronous but synchronous reports may wait for a
response to their request. Therefore, wake them up unconditionally if an
output report couldn't be sent. But keep the report ID intact so we don't
incorrectly assume our request succeeded.

Note that the underlying connection is required to be reliable and does
retransmission itself. So it is safe to assume that if the transmission
fails, the device is in inconsistent state. Hence, we abort every request
if any output report fails. No need to verify which report failed.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 24 +++++++++++++++++++-----
 drivers/hid/hid-wiimote.h      | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index e47c949..73969d4 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -58,11 +58,11 @@ static enum power_supply_property wiimote_battery_props[] = {
 
 /* output queue handling */
 
-static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
-								size_t count)
+static int wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
+			    size_t count)
 {
 	__u8 *buf;
-	ssize_t ret;
+	int ret;
 
 	if (!hdev->hid_output_raw_report)
 		return -ENODEV;
@@ -84,14 +84,20 @@ static void wiimote_queue_worker(struct work_struct *work)
 	struct wiimote_data *wdata = container_of(queue, struct wiimote_data,
 						  queue);
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&wdata->queue.lock, flags);
 
 	while (wdata->queue.head != wdata->queue.tail) {
 		spin_unlock_irqrestore(&wdata->queue.lock, flags);
-		wiimote_hid_send(wdata->hdev,
+		ret = wiimote_hid_send(wdata->hdev,
 				 wdata->queue.outq[wdata->queue.tail].data,
 				 wdata->queue.outq[wdata->queue.tail].size);
+		if (ret < 0) {
+			spin_lock_irqsave(&wdata->state.lock, flags);
+			wiimote_cmd_abort(wdata);
+			spin_unlock_irqrestore(&wdata->state.lock, flags);
+		}
 		spin_lock_irqsave(&wdata->queue.lock, flags);
 
 		wdata->queue.tail = (wdata->queue.tail + 1) % WIIMOTE_BUFSIZE;
@@ -108,7 +114,9 @@ static void wiimote_queue(struct wiimote_data *wdata, const __u8 *buffer,
 
 	if (count > HID_MAX_BUFFER_SIZE) {
 		hid_warn(wdata->hdev, "Sending too large output report\n");
-		return;
+
+		spin_lock_irqsave(&wdata->queue.lock, flags);
+		goto out_error;
 	}
 
 	/*
@@ -134,8 +142,14 @@ static void wiimote_queue(struct wiimote_data *wdata, const __u8 *buffer,
 		wdata->queue.head = newhead;
 	} else {
 		hid_warn(wdata->hdev, "Output queue is full");
+		goto out_error;
 	}
 
+	goto out_unlock;
+
+out_error:
+	wiimote_cmd_abort(wdata);
+out_unlock:
 	spin_unlock_irqrestore(&wdata->queue.lock, flags);
 }
 
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index a3a449a..74b7a47 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -195,6 +195,16 @@ static inline void wiimote_cmd_complete(struct wiimote_data *wdata)
 	complete(&wdata->state.ready);
 }
 
+/* requires the state.lock spinlock to be held */
+static inline void wiimote_cmd_abort(struct wiimote_data *wdata)
+{
+	/* Abort synchronous request by waking up the sleeping caller. But
+	 * reset the state.cmd field to an invalid value so no further event
+	 * handlers will work with it. */
+	wdata->state.cmd = WIIPROTO_REQ_MAX;
+	complete(&wdata->state.ready);
+}
+
 static inline int wiimote_cmd_acquire(struct wiimote_data *wdata)
 {
 	return mutex_lock_interruptible(&wdata->state.sync) ? -ERESTARTSYS : 0;
@@ -223,11 +233,17 @@ static inline int wiimote_cmd_wait(struct wiimote_data *wdata)
 {
 	int ret;
 
+	/* The completion acts as implicit memory barrier so we can safely
+	 * assume that state.cmd is set on success/failure and isn't accessed
+	 * by any other thread, anymore. */
+
 	ret = wait_for_completion_interruptible_timeout(&wdata->state.ready, HZ);
 	if (ret < 0)
 		return -ERESTARTSYS;
 	else if (ret == 0)
 		return -EIO;
+	else if (wdata->state.cmd != WIIPROTO_REQ_NULL)
+		return -EIO;
 	else
 		return 0;
 }
@@ -236,9 +252,12 @@ static inline int wiimote_cmd_wait_noint(struct wiimote_data *wdata)
 {
 	unsigned long ret;
 
+	/* no locking needed; see wiimote_cmd_wait() */
 	ret = wait_for_completion_timeout(&wdata->state.ready, HZ);
 	if (!ret)
 		return -EIO;
+	else if (wdata->state.cmd != WIIPROTO_REQ_NULL)
+		return -EIO;
 	else
 		return 0;
 }
-- 
1.8.2.1

