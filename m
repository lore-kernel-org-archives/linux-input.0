From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [PATCH] Input: Add support for CLOCK_BOOTTIME
Date: Tue, 16 Dec 2014 22:26:34 +0530
Message-ID: <1418748994-2875-1-git-send-email-aniroop.mathur@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:63224 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaLPQ4t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2014 11:56:49 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so14498558pad.38
        for <linux-input@vger.kernel.org>; Tue, 16 Dec 2014 08:56:48 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aniroop.mathur@gmail.com, a.mathur@samsung.com

This patch adds support for CLOCK_BOOTTIME for input event timestamp.
CLOCK_BOOTTIME includes suspend time, so it would allow aplications
to get correct time difference between two events even when system
resumes from suspend state.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index de05545..7825794 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -28,6 +28,13 @@
 #include <linux/cdev.h>
 #include "input-compat.h"
 
+enum clock_type {
+	REAL = 0,
+	MONO,
+	BOOT,
+	CLK_MAX
+};
+
 struct evdev {
 	int open;
 	struct input_handle handle;
@@ -108,8 +115,9 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
 	struct input_event ev;
 	ktime_t time;
 
-	time = (client->clkid == CLOCK_MONOTONIC) ?
-		ktime_get() : ktime_get_real();
+	time = (client->clkid == CLOCK_REALTIME) ?
+		ktime_get_real() : (client->clkid == CLOCK_MONOTONIC) ?
+		ktime_get() : ktime_get_boottime();
 
 	ev.time = ktime_to_timeval(time);
 	ev.type = EV_SYN;
@@ -159,7 +167,7 @@ static void __pass_event(struct evdev_client *client,
 
 static void evdev_pass_values(struct evdev_client *client,
 			const struct input_value *vals, unsigned int count,
-			ktime_t mono, ktime_t real)
+			ktime_t *ev_time)
 {
 	struct evdev *evdev = client->evdev;
 	const struct input_value *v;
@@ -169,8 +177,9 @@ static void evdev_pass_values(struct evdev_client *client,
 	if (client->revoked)
 		return;
 
-	event.time = ktime_to_timeval(client->clkid == CLOCK_MONOTONIC ?
-				      mono : real);
+	event.time = ktime_to_timeval(client->clkid == CLOCK_REALTIME ?
+			ev_time[REAL] : client->clkid == CLOCK_MONOTONIC ?
+			ev_time[MONO] : ev_time[BOOT]);
 
 	/* Interrupts are disabled, just acquire the lock. */
 	spin_lock(&client->buffer_lock);
@@ -198,21 +207,21 @@ static void evdev_events(struct input_handle *handle,
 {
 	struct evdev *evdev = handle->private;
 	struct evdev_client *client;
-	ktime_t time_mono, time_real;
+	ktime_t ev_time[CLK_MAX];
 
-	time_mono = ktime_get();
-	time_real = ktime_mono_to_real(time_mono);
+	ev_time[MONO] = ktime_get();
+	ev_time[REAL] = ktime_mono_to_real(ev_time[MONO]);
+	ev_time[BOOT] = ktime_get_boottime();
 
 	rcu_read_lock();
 
 	client = rcu_dereference(evdev->grab);
 
 	if (client)
-		evdev_pass_values(client, vals, count, time_mono, time_real);
+		evdev_pass_values(client, vals, count, ev_time);
 	else
 		list_for_each_entry_rcu(client, &evdev->client_list, node)
-			evdev_pass_values(client, vals, count,
-					  time_mono, time_real);
+			evdev_pass_values(client, vals, count, ev_time);
 
 	rcu_read_unlock();
 }
@@ -874,7 +883,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 	case EVIOCSCLOCKID:
 		if (copy_from_user(&i, p, sizeof(unsigned int)))
 			return -EFAULT;
-		if (i != CLOCK_MONOTONIC && i != CLOCK_REALTIME)
+		if (i != CLOCK_MONOTONIC && i != CLOCK_REALTIME && i != CLOCK_BOOTTIME)
 			return -EINVAL;
 		client->clkid = i;
 		return 0;
-- 
1.9.1

