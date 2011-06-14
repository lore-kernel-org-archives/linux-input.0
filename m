From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 07/12] HID: wiimote: Add output queue for wiimote driver
Date: Wed, 15 Jun 2011 01:45:52 +0200
Message-ID: <1308095157-4699-8-git-send-email-dh.herrmann@googlemail.com>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36667 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab1FNXqX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 19:46:23 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so41764fxm.19
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 16:46:22 -0700 (PDT)
In-Reply-To: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

The raw hid output function that is supported by bluetooth low-level
hid driver does not provide an output queue and also may sleep. The
wiimote driver, though, may need to send data in atomic context so
this patch adds a buffered output queue for the wiimote driver.

We use the shared workqueue to send our buffer to the hid device.
There is always only one active worker which reschedules itself until
the wiimote queue is empty. This prevents the worker from occupying
the shared workqueue for too long. If our queue is full, every further
output is discarded.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |  104 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index f249940..687a469 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -15,15 +15,28 @@
 #include <linux/hid.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 #include "hid-ids.h"
 
 #define WIIMOTE_VERSION "0.1"
 #define WIIMOTE_NAME "Nintendo Wii Remote"
+#define WIIMOTE_BUFSIZE 32
+
+struct wiimote_buf {
+	__u8 data[HID_MAX_BUFFER_SIZE];
+	size_t size;
+};
 
 struct wiimote_data {
 	atomic_t ready;
 	struct hid_device *hdev;
 	struct input_dev *input;
+
+	spinlock_t qlock;
+	__u8 head;
+	__u8 tail;
+	struct wiimote_buf outq[WIIMOTE_BUFSIZE];
+	struct work_struct worker;
 };
 
 static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
@@ -36,6 +49,78 @@ static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
 							HID_OUTPUT_REPORT);
 }
 
+static void wiimote_worker(struct work_struct *work)
+{
+	struct wiimote_data *wdata = container_of(work, struct wiimote_data,
+									worker);
+
+	if (!atomic_read(&wdata->ready))
+		return;
+
+	spin_lock(&wdata->qlock);
+
+	if (wdata->head != wdata->tail) {
+		spin_unlock(&wdata->qlock);
+		wiimote_hid_send(wdata->hdev, wdata->outq[wdata->tail].data,
+						wdata->outq[wdata->tail].size);
+		spin_lock(&wdata->qlock);
+
+		wdata->tail = (wdata->tail + 1) % WIIMOTE_BUFSIZE;
+
+		/*
+		 * We are using the shared workqueue so send at most one whole
+		 * buffer and then reschedule ourself so we do not occupy the
+		 * shared workqueue for too long.
+		 */
+		if (wdata->head != wdata->tail)
+			schedule_work(&wdata->worker);
+	}
+
+	spin_unlock(&wdata->qlock);
+}
+
+static void wiimote_queue(struct wiimote_data *wdata, const __u8 *buffer,
+								size_t count)
+{
+	unsigned long flags;
+	__u8 newhead;
+
+	if (!atomic_read(&wdata->ready))
+		return;
+
+	if (count > HID_MAX_BUFFER_SIZE) {
+		hid_warn(wdata->hdev, "Sending too large output report\n");
+		return;
+	}
+
+	/*
+	 * Copy new request into our output queue and check whether the
+	 * queue is full. If it is full, discard this request.
+	 * If it is empty we need to start a new worker that will
+	 * send out the buffer to the hid device.
+	 * If the queue is not empty, then there must be a worker
+	 * that is currently sending out our buffer and this worker
+	 * will reschedule itself until the queue is empty.
+	 */
+
+	spin_lock_irqsave(&wdata->qlock, flags);
+
+	memcpy(wdata->outq[wdata->head].data, buffer, count);
+	wdata->outq[wdata->head].size = count;
+	newhead = (wdata->head + 1) % WIIMOTE_BUFSIZE;
+
+	if (wdata->head == wdata->tail) {
+		wdata->head = newhead;
+		schedule_work(&wdata->worker);
+	} else if (newhead != wdata->tail) {
+		wdata->head = newhead;
+	} else {
+		hid_warn(wdata->hdev, "Output queue is full");
+	}
+
+	spin_unlock_irqrestore(&wdata->qlock, flags);
+}
+
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
@@ -87,6 +172,9 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	wdata->input->id.version = wdata->hdev->version;
 	wdata->input->name = WIIMOTE_NAME;
 
+	spin_lock_init(&wdata->qlock);
+	INIT_WORK(&wdata->worker, wiimote_worker);
+
 	return wdata;
 }
 
@@ -137,8 +225,24 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 	struct wiimote_data *wdata = hid_get_drvdata(hdev);
 
 	hid_info(hdev, "Device removed\n");
+
+	/*
+	 * We handle events from HID, input and sysfs and
+	 * send requests to HID and input. So stop sysfs
+	 * first, then lock HID output and stop HID.
+	 * Now only input is left so stop it and free the
+	 * the device data.
+	 */
+
+	atomic_set(&wdata->ready, 0);
+	cancel_work_sync(&wdata->worker);
+
 	hid_hw_stop(hdev);
 	input_unregister_device(wdata->input);
+
+	/* the worker may have been rescheduled so wait again for it */
+	cancel_work_sync(&wdata->worker);
+
 	kfree(wdata);
 }
 
-- 
1.7.5.2

