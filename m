From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 07/12] HID: wiimote: Add output queue for wiimote driver
Date: Mon, 27 Jun 2011 16:30:08 +0200
Message-ID: <1309185013-484-7-git-send-email-dh.herrmann@googlemail.com>
References: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:46203 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab1F0ObB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 10:31:01 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so1868791fxd.11
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2011 07:31:00 -0700 (PDT)
In-Reply-To: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org, David Herrmann <dh.herrmann@googlemail.com>

The raw hid output function that is supported by bluetooth low-level
hid driver does not provide an output queue and also may sleep. The
wiimote driver, though, may need to send data in atomic context so
this patch adds a buffered output queue for the wiimote driver.

We use the shared workqueue to send our buffer to the hid device.
There is always only one active worker which reschedules itself until
the wiimote queue is empty. This prevents the worker from occupying
the shared workqueue for too long. If our queue is full, every further
output is discarded.

Special care is needed in the deinitialization routine. When
wiimote_hid_remove is called, HID input is already disabled, but HID
output may still be used from our worker and is then discarded by the
lower HID layers. Therefore, we can safely disable the input layer since it
is the only layer that still sends input events.
Future sysfs attributes must be freed before unregistering input to
avoid the sysfs handlers to send input events to a non-existing input
layer.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   86 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 811ed89..c2b91fb 100644
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
@@ -45,6 +58,73 @@ static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
 	return ret;
 }
 
+static void wiimote_worker(struct work_struct *work)
+{
+	struct wiimote_data *wdata = container_of(work, struct wiimote_data,
+									worker);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->qlock, flags);
+
+	if (wdata->head != wdata->tail) {
+		spin_unlock_irqrestore(&wdata->qlock, flags);
+		wiimote_hid_send(wdata->hdev, wdata->outq[wdata->tail].data,
+						wdata->outq[wdata->tail].size);
+		spin_lock_irqsave(&wdata->qlock, flags);
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
+	spin_unlock_irqrestore(&wdata->qlock, flags);
+}
+
+static void wiimote_queue(struct wiimote_data *wdata, const __u8 *buffer,
+								size_t count)
+{
+	unsigned long flags;
+	__u8 newhead;
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
@@ -100,6 +180,9 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	wdata->input->id.version = wdata->hdev->version;
 	wdata->input->name = WIIMOTE_NAME;
 
+	spin_lock_init(&wdata->qlock);
+	INIT_WORK(&wdata->worker, wiimote_worker);
+
 	return wdata;
 }
 
@@ -157,8 +240,11 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 	struct wiimote_data *wdata = hid_get_drvdata(hdev);
 
 	hid_info(hdev, "Device removed\n");
+
 	hid_hw_stop(hdev);
 	input_unregister_device(wdata->input);
+
+	cancel_work_sync(&wdata->worker);
 	wiimote_destroy(wdata);
 }
 
-- 
1.7.5.2

