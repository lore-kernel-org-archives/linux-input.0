From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] [v7] Input: evdev: fix bug of dropping full valid packet after
 syn_dropped
Date: Thu, 14 Jan 2016 22:18:16 +0530
Message-ID: <1452790096-13463-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57910 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbcANQsd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jan 2016 11:48:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com, s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <a.mathur@samsung.com>

If last event in old queue that was dropped was EV_SYN/SYN_REPORT, then
lets generate EV_SYN/SYN_REPORT immediately after queing EV_SYN/SYN_DROPPED
so that clients would not ignore next valid full packet events.

v7:
Includes change only in clock_change and pass_event function
(not for evdev_handle_get_val to be on safer side)

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c |   57 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..0a376e7 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -192,6 +192,7 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 {
 	unsigned long flags;
 	unsigned int clk_type;
+	struct input_event ev;
 
 	switch (clkid) {
 
@@ -218,8 +219,25 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 		spin_lock_irqsave(&client->buffer_lock, flags);
 
 		if (client->head != client->tail) {
-			client->packet_head = client->head = client->tail;
+			/* Store last event occurred */
+			client->head--;
+			client->head &= client->bufsize - 1;
+			ev = client->buffer[client->head];
+
+			client->packet_head = client->tail = client->head = 0;
 			__evdev_queue_syn_dropped(client);
+
+			/*
+			 * If last packet is completely stored, queue SYN_REPORT
+			 * so that clients would not ignore next full packet.
+			 * Use SYN_DROPPED time for SYN_REPORT event and no need
+			 * to check for head overflow as it was set to 0 index.
+			 */
+			if (ev.type == EV_SYN && ev.code == SYN_REPORT) {
+				ev.time = client->buffer[0].time;
+				client->buffer[client->head++] = ev;
+				client->packet_head = client->head;
+			}
 		}
 
 		spin_unlock_irqrestore(&client->buffer_lock, flags);
@@ -231,22 +249,39 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 static void __pass_event(struct evdev_client *client,
 			 const struct input_event *event)
 {
+	struct input_event *prev_ev;
+	unsigned int mask = client->bufsize - 1;
+
 	client->buffer[client->head++] = *event;
-	client->head &= client->bufsize - 1;
+	client->head &= mask;
 
 	if (unlikely(client->head == client->tail)) {
+		/* Store previous event occurred before newest event */
+		prev_ev = &client->buffer[(client->head - 2) & mask];
+
+		client->packet_head = client->tail = client->head;
+
+		/* Queue SYN_DROPPED event */
+		client->buffer[client->head].time = event->time;
+		client->buffer[client->head].type = EV_SYN;
+		client->buffer[client->head].code = SYN_DROPPED;
+		client->buffer[client->head++].value = 0;
+		client->head &= mask;
+
 		/*
-		 * This effectively "drops" all unconsumed events, leaving
-		 * EV_SYN/SYN_DROPPED plus the newest event in the queue.
+		 * Queue SYN_REPORT event, if last packet was completely stored
+		 * so that clients would not ignore upcoming full packet
 		 */
-		client->tail = (client->head - 2) & (client->bufsize - 1);
-
-		client->buffer[client->tail].time = event->time;
-		client->buffer[client->tail].type = EV_SYN;
-		client->buffer[client->tail].code = SYN_DROPPED;
-		client->buffer[client->tail].value = 0;
+		if (prev_ev->type == EV_SYN && prev_ev->code == SYN_REPORT) {
+			prev_ev->time = event->time;
+			client->buffer[client->head++] = *prev_ev;
+			client->head &= mask;
+			client->packet_head = client->head;
+		}
 
-		client->packet_head = client->tail;
+		/* Queue newest event (Empty SYN_REPORT are already dropped) */
+		client->buffer[client->head++] = *event;
+		client->head &= mask;
 	}
 
 	if (event->type == EV_SYN && event->code == SYN_REPORT) {
-- 
1.7.9.5

