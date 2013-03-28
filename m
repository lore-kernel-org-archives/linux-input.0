From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2] Input: evdev - Flush queues during EVIOCGKEY-like ioctls
Date: Thu, 28 Mar 2013 01:49:24 +0100
Message-ID: <1364431764-31378-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:39841 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab3C1Aqi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Mar 2013 20:46:38 -0400
Received: by mail-bk0-f42.google.com with SMTP id jc3so1532781bkc.15
        for <linux-input@vger.kernel.org>; Wed, 27 Mar 2013 17:46:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

If userspace requests current KEY-state, they very likely assume that no
such events are pending in the output queue of the evdev device.
Otherwise, they will parse events which they already handled via
EVIOCGKEY(). For XKB applications this can cause irreversible keyboard
states if a modifier is locked multiple times because a CTRL-DOWN event is
handled once via EVIOCGKEY() and once from the queue via read(), even
though it should handle it only once.

Therefore, lets do the only logical thing and flush the evdev queue
atomically during this ioctl. We only flush events that are affected by
the given ioctl.

This only affects boolean events like KEY, SND, SW and LED. ABS, REL and
others are not affected as duplicate events can be handled gracefully by
user-space.

Note: This actually breaks semantics of the evdev ABI. However,
investigations showed that userspace already expects the new semantics and
we end up fixing at least all XKB applications.
All applications that are aware of this race-condition mirror the KEY
state for each open-file and detect/drop duplicate events. Hence, they do
not care whether duplicates are posted or not and work fine with this fix.

Also note that we need proper locking to guarantee atomicity and avoid
dead-locks. event_lock must be locked before queue_lock (see input-core).
However, we can safely release event_lock while flushing the queue. This
allows the input-core to proceed with pending events and only stop if it
needs our queue_lock to post new events.
This should guarantee that we don't block event-dispatching for too long
while flushing a single event queue.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/input/evdev.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 4 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index f0f8928..75e13d3 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -52,6 +52,52 @@ struct evdev_client {
 	struct input_event buffer[];
 };
 
+/* flush queued events of type @type, caller must hold client->buffer_lock */
+static void __flush_queue(struct evdev_client *client, unsigned int type)
+{
+	unsigned int i, head, num;
+	unsigned int mask = client->bufsize - 1;
+	bool is_report;
+	struct input_event *ev;
+
+	BUG_ON(type == EV_SYN);
+
+	head = client->tail;
+	client->packet_head = client->tail;
+
+	/* init to 1 so a leading SYN_REPORT will not be dropped */
+	num = 1;
+
+	for (i = client->tail; i != client->head; i = (i + 1) & mask) {
+		ev = &client->buffer[i];
+		is_report = ev->type == EV_SYN && ev->code == SYN_REPORT;
+
+		if (ev->type == type) {
+			/* drop matched entry */
+			continue;
+		} else if (is_report && !num) {
+			/* drop empty SYN_REPORT groups */
+			continue;
+		} else if (head != i) {
+			/* move entry to fill the gap */
+			client->buffer[head].time = ev->time;
+			client->buffer[head].type = ev->type;
+			client->buffer[head].code = ev->code;
+			client->buffer[head].value = ev->value;
+		}
+
+		num++;
+		head = (head + 1) & mask;
+
+		if (is_report) {
+			num = 0;
+			client->packet_head = head;
+		}
+	}
+
+	client->head = head;
+}
+
 static void __pass_event(struct evdev_client *client,
 			 const struct input_event *event)
 {
@@ -650,6 +696,38 @@ static int evdev_handle_set_keycode_v2(struct input_dev *dev, void __user *p)
 	return input_set_keycode(dev, &ke);
 }
 
+/*
+ * If we transfer state to the user, we should flush all pending events
+ * from the client's queue. Otherwise, they might end up with duplicate
+ * events, which can screw up client's state tracking.
+ *
+ * We need to take event_lock before buffer_lock to avoid dead-locks. But we
+ * need the even_lock only to guarantee consistent state. We can safely release
+ * it while flushing the queue. This allows input-core to handle filters while
+ * we flush the queue.
+ */
+static int evdev_handle_get_val(struct evdev_client *client,
+				struct input_dev *dev, unsigned int type,
+				unsigned long *bits, unsigned int max,
+				unsigned int size, void __user *p, int compat)
+{
+	int ret;
+
+	spin_lock_irq(&dev->event_lock);
+	spin_lock(&client->buffer_lock);
+
+	ret = bits_to_user(bits, max, size, p, compat);
+
+	spin_unlock(&dev->event_lock);
+
+	if (ret >= 0)
+		__flush_queue(client, type);
+
+	spin_unlock_irq(&client->buffer_lock);
+
+	return ret;
+}
+
 static int evdev_handle_mt_request(struct input_dev *dev,
 				   unsigned int size,
 				   int __user *ip)
@@ -771,16 +849,20 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 		return evdev_handle_mt_request(dev, size, ip);
 
 	case EVIOCGKEY(0):
-		return bits_to_user(dev->key, KEY_MAX, size, p, compat_mode);
+		return evdev_handle_get_val(client, dev, EV_KEY, dev->key,
+					    KEY_MAX, size, p, compat_mode);
 
 	case EVIOCGLED(0):
-		return bits_to_user(dev->led, LED_MAX, size, p, compat_mode);
+		return evdev_handle_get_val(client, dev, EV_LED, dev->led,
+					    LED_MAX, size, p, compat_mode);
 
 	case EVIOCGSND(0):
-		return bits_to_user(dev->snd, SND_MAX, size, p, compat_mode);
+		return evdev_handle_get_val(client, dev, EV_SND, dev->snd,
+					    SND_MAX, size, p, compat_mode);
 
 	case EVIOCGSW(0):
-		return bits_to_user(dev->sw, SW_MAX, size, p, compat_mode);
+		return evdev_handle_get_val(client, dev, EV_SW, dev->sw,
+					    SW_MAX, size, p, compat_mode);
 
 	case EVIOCGNAME(0):
 		return str_to_user(dev->name, size, p);
-- 
1.8.2

