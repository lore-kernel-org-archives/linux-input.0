From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [PATCH] Input: Evdev - Avoid data loss when clock type is changed
Date: Sat,  1 Aug 2015 03:58:52 +0530
Message-ID: <1438381732-29681-1-git-send-email-aniroop.mathur@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34973 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbbGaWZE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2015 18:25:04 -0400
Received: by pabkd10 with SMTP id kd10so47113141pab.2
        for <linux-input@vger.kernel.org>; Fri, 31 Jul 2015 15:25:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: aniroop.mathur@gmail.com, a.mathur@samsung.com

When clock type is changed, previously stored data is flushed
and therfore does not reach to upper layer or application.
Data is critically important along with the timestamp.
So to avoid data loss and send correct timestamp as well,
lets not flush data upon clock type change and
to send correct timestamp, store only monotonic timestamp during write
and change monotonic clock time to desired clock time during read.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c | 64 ++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index a18f41b..ab49382 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -111,15 +111,8 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
 	struct input_event ev;
-	ktime_t time;
-
-	time = client->clk_type == EV_CLK_REAL ?
-			ktime_get_real() :
-			client->clk_type == EV_CLK_MONO ?
-				ktime_get() :
-				ktime_get_boottime();
 
-	ev.time = ktime_to_timeval(time);
+	ev.time = ktime_to_timeval(ktime_get());
 	ev.type = EV_SYN;
 	ev.code = SYN_DROPPED;
 	ev.value = 0;
@@ -145,8 +138,6 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
 
 static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 {
-	unsigned long flags;
-
 	if (client->clk_type == clkid)
 		return 0;
 
@@ -165,19 +156,6 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 		return -EINVAL;
 	}
 
-	/*
-	 * Flush pending events and queue SYN_DROPPED event,
-	 * but only if the queue is not empty.
-	 */
-	spin_lock_irqsave(&client->buffer_lock, flags);
-
-	if (client->head != client->tail) {
-		client->packet_head = client->head = client->tail;
-		__evdev_queue_syn_dropped(client);
-	}
-
-	spin_unlock_irqrestore(&client->buffer_lock, flags);
-
 	return 0;
 }
 
@@ -209,8 +187,7 @@ static void __pass_event(struct evdev_client *client,
 }
 
 static void evdev_pass_values(struct evdev_client *client,
-			const struct input_value *vals, unsigned int count,
-			ktime_t *ev_time)
+			const struct input_value *vals, unsigned int count)
 {
 	struct evdev *evdev = client->evdev;
 	const struct input_value *v;
@@ -220,7 +197,7 @@ static void evdev_pass_values(struct evdev_client *client,
 	if (client->revoked)
 		return;
 
-	event.time = ktime_to_timeval(ev_time[client->clk_type]);
+	event.time = ktime_to_timeval(ktime_get());
 
 	/* Interrupts are disabled, just acquire the lock. */
 	spin_lock(&client->buffer_lock);
@@ -248,22 +225,16 @@ static void evdev_events(struct input_handle *handle,
 {
 	struct evdev *evdev = handle->private;
 	struct evdev_client *client;
-	ktime_t ev_time[EV_CLK_MAX];
-
-	ev_time[EV_CLK_MONO] = ktime_get();
-	ev_time[EV_CLK_REAL] = ktime_mono_to_real(ev_time[EV_CLK_MONO]);
-	ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_MONO],
-						 TK_OFFS_BOOT);
 
 	rcu_read_lock();
 
 	client = rcu_dereference(evdev->grab);
 
 	if (client)
-		evdev_pass_values(client, vals, count, ev_time);
+		evdev_pass_values(client, vals, count);
 	else
 		list_for_each_entry_rcu(client, &evdev->client_list, node)
-			evdev_pass_values(client, vals, count, ev_time);
+			evdev_pass_values(client, vals, count);
 
 	rcu_read_unlock();
 }
@@ -531,6 +502,29 @@ static int evdev_fetch_next_event(struct evdev_client *client,
 	return have_event;
 }
 
+static void evdev_check_timestamp(struct evdev_client *client,
+				struct input_event *event)
+{
+	ktime_t time;
+
+	if (client->clk_type == EV_CLK_MONO)
+		return;
+
+	time = timeval_to_ktime(event->time);
+
+	switch (client->clk_type) {
+
+	case EV_CLK_REAL:
+		time = ktime_mono_to_real(time);
+		break;
+	case EV_CLK_BOOT:
+		time = ktime_mono_to_any(time, TK_OFFS_BOOT);
+		break;
+	}
+
+	event->time = ktime_to_timeval(time);
+}
+
 static ssize_t evdev_read(struct file *file, char __user *buffer,
 			  size_t count, loff_t *ppos)
 {
@@ -561,6 +555,8 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 		while (read + input_event_size() <= count &&
 		       evdev_fetch_next_event(client, &event)) {
 
+			evdev_check_timestamp(client, &event);
+
 			if (input_event_to_user(buffer + read, &event))
 				return -EFAULT;
 
-- 
1.9.1

