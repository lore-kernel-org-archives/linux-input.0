From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] evdev: flush ABS_* events during EVIOCGABS
Date: Thu, 10 Apr 2014 21:09:04 +0200
Message-ID: <1397156944-5991-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:37755 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758812AbaDJTJL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Apr 2014 15:09:11 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so4360810pbc.9
        for <linux-input@vger.kernel.org>; Thu, 10 Apr 2014 12:09:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

We currently flush input events in the outgoing client queue on most
EVIOCG* ioctls so userspace doesn't get events twice (once during the
ioctl and once during a later read()).

We introduced this in:
  commit 483180281f0ac60d1138710eb21f4b9961901294
  Author: David Herrmann <dh.herrmann@gmail.com>
  Date:   Sun Apr 7 21:13:19 2013 -0700

      Input: evdev - flush queues during EVIOCGKEY-like ioctls

However, we didn't modify the EVIOCGABS handler as we considered ABS
values to change fast enough that flushing the queue seems irrelevant. But
as it turns out, the ABS SLOT events suffer from the same issues. Hence,
also flush the input queue from ABS values on EVIOCGABS.

Reported-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
Hi

This is untested as I don't have any multitouch hardware right now. Peter, can
you give this a try?

Thanks
David

 drivers/input/evdev.c | 63 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index a06e125..fc55c19 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -55,8 +55,11 @@ struct evdev_client {
 	struct input_event buffer[];
 };
 
-/* flush queued events of type @type, caller must hold client->buffer_lock */
-static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
+/* Flush queued events of given type @type and code @code. A negative code
+ * is interpreted as catch-all. Caller must hold client->buffer_lock. */
+static void __evdev_flush_queue(struct evdev_client *client,
+				unsigned int type,
+				int code)
 {
 	unsigned int i, head, num;
 	unsigned int mask = client->bufsize - 1;
@@ -75,7 +78,7 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 		ev = &client->buffer[i];
 		is_report = ev->type == EV_SYN && ev->code == SYN_REPORT;
 
-		if (ev->type == type) {
+		if (ev->type == type && (code < 0 || ev->code == code)) {
 			/* drop matched entry */
 			continue;
 		} else if (is_report && !num) {
@@ -774,7 +777,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
 
 	spin_unlock(&dev->event_lock);
 
-	__evdev_flush_queue(client, type);
+	__evdev_flush_queue(client, type, -1);
 
 	spin_unlock_irq(&client->buffer_lock);
 
@@ -787,6 +790,40 @@ static int evdev_handle_get_val(struct evdev_client *client,
 	return ret;
 }
 
+static int evdev_handle_get_abs(struct evdev_client *client,
+				struct input_dev *dev,
+				unsigned int code,
+				unsigned int size,
+				void __user *p)
+{
+	struct input_absinfo abs;
+	int ret;
+
+	if (!dev->absinfo)
+		return -EINVAL;
+
+	/* see evdev_handle_get_val() for locking order */
+
+	spin_lock_irq(&dev->event_lock);
+	spin_lock(&client->buffer_lock);
+
+	abs = dev->absinfo[code];
+
+	spin_unlock(&dev->event_lock);
+
+	__evdev_flush_queue(client, EV_ABS, code);
+
+	spin_unlock_irq(&client->buffer_lock);
+
+	ret = copy_to_user(p, &abs, min_t(size_t,
+					  size,
+					  sizeof(struct input_absinfo)));
+	if (ret < 0)
+		evdev_queue_syn_dropped(client);
+
+	return ret;
+}
+
 static int evdev_handle_mt_request(struct input_dev *dev,
 				   unsigned int size,
 				   int __user *ip)
@@ -972,20 +1009,10 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 						_IOC_NR(cmd) & EV_MAX, size,
 						p, compat_mode);
 
-		if ((_IOC_NR(cmd) & ~ABS_MAX) == _IOC_NR(EVIOCGABS(0))) {
-
-			if (!dev->absinfo)
-				return -EINVAL;
-
-			t = _IOC_NR(cmd) & ABS_MAX;
-			abs = dev->absinfo[t];
-
-			if (copy_to_user(p, &abs, min_t(size_t,
-					size, sizeof(struct input_absinfo))))
-				return -EFAULT;
-
-			return 0;
-		}
+		if ((_IOC_NR(cmd) & ~ABS_MAX) == _IOC_NR(EVIOCGABS(0)))
+			return evdev_handle_get_abs(client, dev,
+						    _IOC_NR(cmd) & ABS_MAX,
+						    size, p);
 	}
 
 	if (_IOC_DIR(cmd) == _IOC_WRITE) {
-- 
1.9.1

