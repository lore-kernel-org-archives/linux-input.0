From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 02/26] HID: wiimote: move queue handling into separate struct
Date: Sun,  5 May 2013 23:12:46 +0200
Message-ID: <1367788390-29835-3-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:50817 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab3EEVNp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:13:45 -0400
Received: by mail-bk0-f53.google.com with SMTP id i18so1327225bkv.26
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:13:44 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

The output queue is independent of the other wiimote modules and can run
on its own. Therefore, move its members into a separate struct so we don't
run into name collisions with other modules.

This is only a syntactic change that renames all queue members to queue.*.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 53 +++++++++++++++++++++++-------------------
 drivers/hid/hid-wiimote.h      | 15 +++++++-----
 2 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 119dc56..2d85d3a 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -56,6 +56,8 @@ static enum power_supply_property wiimote_battery_props[] = {
 	POWER_SUPPLY_PROP_SCOPE,
 };
 
+/* output queue handling */
+
 static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
 								size_t count)
 {
@@ -75,24 +77,27 @@ static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
 	return ret;
 }
 
-static void wiimote_worker(struct work_struct *work)
+static void wiimote_queue_worker(struct work_struct *work)
 {
-	struct wiimote_data *wdata = container_of(work, struct wiimote_data,
-									worker);
+	struct wiimote_queue *queue = container_of(work, struct wiimote_queue,
+						   worker);
+	struct wiimote_data *wdata = container_of(queue, struct wiimote_data,
+						  queue);
 	unsigned long flags;
 
-	spin_lock_irqsave(&wdata->qlock, flags);
+	spin_lock_irqsave(&wdata->queue.lock, flags);
 
-	while (wdata->head != wdata->tail) {
-		spin_unlock_irqrestore(&wdata->qlock, flags);
-		wiimote_hid_send(wdata->hdev, wdata->outq[wdata->tail].data,
-						wdata->outq[wdata->tail].size);
-		spin_lock_irqsave(&wdata->qlock, flags);
+	while (wdata->queue.head != wdata->queue.tail) {
+		spin_unlock_irqrestore(&wdata->queue.lock, flags);
+		wiimote_hid_send(wdata->hdev,
+				 wdata->queue.outq[wdata->queue.tail].data,
+				 wdata->queue.outq[wdata->queue.tail].size);
+		spin_lock_irqsave(&wdata->queue.lock, flags);
 
-		wdata->tail = (wdata->tail + 1) % WIIMOTE_BUFSIZE;
+		wdata->queue.tail = (wdata->queue.tail + 1) % WIIMOTE_BUFSIZE;
 	}
 
-	spin_unlock_irqrestore(&wdata->qlock, flags);
+	spin_unlock_irqrestore(&wdata->queue.lock, flags);
 }
 
 static void wiimote_queue(struct wiimote_data *wdata, const __u8 *buffer,
@@ -116,22 +121,22 @@ static void wiimote_queue(struct wiimote_data *wdata, const __u8 *buffer,
 	 * will reschedule itself until the queue is empty.
 	 */
 
-	spin_lock_irqsave(&wdata->qlock, flags);
+	spin_lock_irqsave(&wdata->queue.lock, flags);
 
-	memcpy(wdata->outq[wdata->head].data, buffer, count);
-	wdata->outq[wdata->head].size = count;
-	newhead = (wdata->head + 1) % WIIMOTE_BUFSIZE;
+	memcpy(wdata->queue.outq[wdata->queue.head].data, buffer, count);
+	wdata->queue.outq[wdata->queue.head].size = count;
+	newhead = (wdata->queue.head + 1) % WIIMOTE_BUFSIZE;
 
-	if (wdata->head == wdata->tail) {
-		wdata->head = newhead;
-		schedule_work(&wdata->worker);
-	} else if (newhead != wdata->tail) {
-		wdata->head = newhead;
+	if (wdata->queue.head == wdata->queue.tail) {
+		wdata->queue.head = newhead;
+		schedule_work(&wdata->queue.worker);
+	} else if (newhead != wdata->queue.tail) {
+		wdata->queue.head = newhead;
 	} else {
 		hid_warn(wdata->hdev, "Output queue is full");
 	}
 
-	spin_unlock_irqrestore(&wdata->qlock, flags);
+	spin_unlock_irqrestore(&wdata->queue.lock, flags);
 }
 
 /*
@@ -1157,8 +1162,8 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	input_set_abs_params(wdata->ir, ABS_HAT3X, 0, 1023, 2, 4);
 	input_set_abs_params(wdata->ir, ABS_HAT3Y, 0, 767, 2, 4);
 
-	spin_lock_init(&wdata->qlock);
-	INIT_WORK(&wdata->worker, wiimote_worker);
+	spin_lock_init(&wdata->queue.lock);
+	INIT_WORK(&wdata->queue.worker, wiimote_queue_worker);
 
 	spin_lock_init(&wdata->state.lock);
 	init_completion(&wdata->state.ready);
@@ -1187,7 +1192,7 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 	input_unregister_device(wdata->accel);
 	input_unregister_device(wdata->ir);
 	input_unregister_device(wdata->input);
-	cancel_work_sync(&wdata->worker);
+	cancel_work_sync(&wdata->queue.worker);
 	hid_hw_stop(wdata->hdev);
 
 	kfree(wdata);
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index a2629ed..2700d47 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -48,6 +48,14 @@ struct wiimote_buf {
 	size_t size;
 };
 
+struct wiimote_queue {
+	spinlock_t lock;
+	struct work_struct worker;
+	__u8 head;
+	__u8 tail;
+	struct wiimote_buf outq[WIIMOTE_BUFSIZE];
+};
+
 struct wiimote_state {
 	spinlock_t lock;
 	__u8 flags;
@@ -77,12 +85,7 @@ struct wiimote_data {
 	struct wiimote_ext *ext;
 	struct wiimote_debug *debug;
 
-	spinlock_t qlock;
-	__u8 head;
-	__u8 tail;
-	struct wiimote_buf outq[WIIMOTE_BUFSIZE];
-	struct work_struct worker;
-
+	struct wiimote_queue queue;
 	struct wiimote_state state;
 };
 
-- 
1.8.2.2

