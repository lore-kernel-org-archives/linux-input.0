From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] [v6]Input: evdev: fix bug of dropping valid full packet after
 syn_dropped event
Date: Thu, 14 Jan 2016 22:15:22 +0530
Message-ID: <1452789923-13327-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44072 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347AbcANQpx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jan 2016 11:45:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com, s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <a.mathur@samsung.com>

If last event in old queue that was dropped was EV_SYN/SYN_REPORT, then
lets generate EV_SYN/SYN_REPORT immediately after queing EV_SYN/SYN_DROPPED
so that clients would not ignore next valid full packet events.

Difference from v5:
- Corrected header to store last event occured for pass_event and
clock_change function
- Moved buffer lock after evdev_queue_syn_dropped to avoid shifting
of head during bits_to_user processing in evdev_handle_get_val function.
As input cores passes packets (not single events) to evdev handler so
after flushing queue for particular events, there will always be syn_report
in the buffer at the end. And if flush request is for syn_report, then
syn_report will not be queued after syn_dropped, anyways.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c |   57 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..b474e81 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -156,7 +156,12 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
 	struct input_event ev;
+	struct input_event last_ev;
 	ktime_t time;
+	unsigned int mask = client->bufsize - 1;
+
+	/* store last event */
+	last_ev = client->buffer[(client->head - 1) & mask];
 
 	time = client->clk_type == EV_CLK_REAL ?
 			ktime_get_real() :
@@ -170,22 +175,28 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
 	ev.value = 0;
 
 	client->buffer[client->head++] = ev;
-	client->head &= client->bufsize - 1;
+	client->head &= mask;
 
 	if (unlikely(client->head == client->tail)) {
 		/* drop queue but keep our SYN_DROPPED event */
-		client->tail = (client->head - 1) & (client->bufsize - 1);
+		client->tail = (client->head - 1) & mask;
 		client->packet_head = client->tail;
 	}
-}
 
-static void evdev_queue_syn_dropped(struct evdev_client *client)
-{
-	unsigned long flags;
+	/*
+	 * If last packet was completely stored, then queue SYN_REPORT
+	 * so that clients would not ignore next valid full packet
+	 */
+	if (last_ev.type == EV_SYN && last_ev.code == SYN_REPORT) {
+		last_ev.time = ev.time;
+		client->buffer[client->head++] = last_ev;
+		client->head &= mask;
+		client->packet_head = client->head;
 
-	spin_lock_irqsave(&client->buffer_lock, flags);
-	__evdev_queue_syn_dropped(client);
-	spin_unlock_irqrestore(&client->buffer_lock, flags);
+		/* drop queue but keep our SYN_DROPPED & SYN_REPORT event */
+		if (unlikely(client->head == client->tail))
+			client->tail = (client->head - 2) & mask;
+	}
 }
 
 static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
@@ -218,7 +229,7 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 		spin_lock_irqsave(&client->buffer_lock, flags);
 
 		if (client->head != client->tail) {
-			client->packet_head = client->head = client->tail;
+			client->packet_head = client->tail = client->head;
 			__evdev_queue_syn_dropped(client);
 		}
 
@@ -231,22 +242,24 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 static void __pass_event(struct evdev_client *client,
 			 const struct input_event *event)
 {
+	unsigned int mask = client->bufsize - 1;
+
 	client->buffer[client->head++] = *event;
-	client->head &= client->bufsize - 1;
+	client->head &= mask;
 
 	if (unlikely(client->head == client->tail)) {
 		/*
 		 * This effectively "drops" all unconsumed events, leaving
-		 * EV_SYN/SYN_DROPPED plus the newest event in the queue.
+		 * EV_SYN/SYN_DROPPED, EV_SYN/SYN_REPORT (if required) and
+		 * newest event in the queue.
 		 */
-		client->tail = (client->head - 2) & (client->bufsize - 1);
+		client->head = (client->head - 1) & mask;
+		client->packet_head = client->tail = client->head;
+		__evdev_queue_syn_dropped(client);
 
-		client->buffer[client->tail].time = event->time;
-		client->buffer[client->tail].type = EV_SYN;
-		client->buffer[client->tail].code = SYN_DROPPED;
-		client->buffer[client->tail].value = 0;
-
-		client->packet_head = client->tail;
+		client->buffer[client->head++] = *event;
+		client->head &= mask;
+		/* No need to check for buffer overflow as it just occurred */
 	}
 
 	if (event->type == EV_SYN && event->code == SYN_REPORT) {
@@ -935,11 +948,11 @@ static int evdev_handle_get_val(struct evdev_client *client,
 
 	__evdev_flush_queue(client, type);
 
-	spin_unlock_irq(&client->buffer_lock);
-
 	ret = bits_to_user(mem, maxbit, maxlen, p, compat);
 	if (ret < 0)
-		evdev_queue_syn_dropped(client);
+		__evdev_queue_syn_dropped(client);
+
+	spin_unlock_irq(&client->buffer_lock);
 
 	kfree(mem);
 
-- 
1.7.9.5

