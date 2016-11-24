From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: evdev: fix queueing of SYN_DROPPED event for EVIOCG[type] IOCTL case
Date: Fri, 25 Nov 2016 01:41:43 +0530
Message-ID: <1480018303-4220-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: aniroop.mathur@gmail.com, s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <a.mathur@samsung.com>
List-Id: linux-input@vger.kernel.org

Currently, when EVIOCG[type] ioctl call is issued and bits_to_user fails,
then SYN_DROPPED event is inserted in the event queue always.

However, it is not compulsory that some events are flushed out on every
EVIOCG[type] ioctl call like in case of empty event queue and in case when
EVIOCG[type] ioctl is issued for say A type of events but event queue does
not have any A type of events but some other type of events.

Therefore, insert SYN_DROPPED event only when some events have been flushed
out from event queue plus bits_to_user fails.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..f8b295e 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -108,9 +108,11 @@ static bool __evdev_is_filtered(struct evdev_client *client,
 }
 
 /* flush queued events of type @type, caller must hold client->buffer_lock */
-static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
+static unsigned int __evdev_flush_queue(struct evdev_client *client,
+					unsigned int type)
 {
 	unsigned int i, head, num;
+	unsigned int drop_count = 0;
 	unsigned int mask = client->bufsize - 1;
 	bool is_report;
 	struct input_event *ev;
@@ -129,9 +131,11 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 
 		if (ev->type == type) {
 			/* drop matched entry */
+			drop_count++;
 			continue;
 		} else if (is_report && !num) {
 			/* drop empty SYN_REPORT groups */
+			drop_count++;
 			continue;
 		} else if (head != i) {
 			/* move entry to fill the gap */
@@ -151,6 +155,7 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 	}
 
 	client->head = head;
+	return drop_count;
 }
 
 static void __evdev_queue_syn_dropped(struct evdev_client *client)
@@ -920,6 +925,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
 	int ret;
 	unsigned long *mem;
 	size_t len;
+	unsigned int drop_count = 0;
 
 	len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
 	mem = kmalloc(len, GFP_KERNEL);
@@ -933,12 +939,12 @@ static int evdev_handle_get_val(struct evdev_client *client,
 
 	spin_unlock(&dev->event_lock);
 
-	__evdev_flush_queue(client, type);
+	drop_count = __evdev_flush_queue(client, type);
 
 	spin_unlock_irq(&client->buffer_lock);
 
 	ret = bits_to_user(mem, maxbit, maxlen, p, compat);
-	if (ret < 0)
+	if (ret < 0 && drop_count > 0)
 		evdev_queue_syn_dropped(client);
 
 	kfree(mem);
-- 
2.6.2
