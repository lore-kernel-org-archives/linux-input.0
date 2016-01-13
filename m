From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] [v5]Input: evdev: fix bug of dropping full valid packet after
 syn_dropped
Date: Wed, 13 Jan 2016 17:27:41 +0530
Message-ID: <1452686262-6684-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com, s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <a.mathur@samsung.com>
List-Id: linux-input@vger.kernel.org

If last event in old queue that was dropped was EV_SYN/SYN_REPORT, then
lets generate EV_SYN/SYN_REPORT immediately after queing EV_SYN/SYN_DROPPED
so that clients would not ignore next valid full packet events.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c |   45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..0bc7b98 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -156,7 +156,12 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
 	struct input_event ev;
+	struct input_event *prev_ev;
 	ktime_t time;
+	unsigned int mask = client->bufsize - 1;
+
+	/* store previous event */
+	prev_ev = &client->buffer[(client->head - 1) & mask];
 
 	time = client->clk_type == EV_CLK_REAL ?
 			ktime_get_real() :
@@ -170,13 +175,28 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
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
+
+	/*
+	 * If last packet was completely stored, then queue SYN_REPORT
+	 * so that clients would not ignore next valid full packet
+	 */
+	if (prev_ev->type == EV_SYN && prev_ev->code == SYN_REPORT) {
+		prev_ev->time = ev.time;
+		client->buffer[client->head++] = *prev_ev;
+		client->head &= mask;
+		client->packet_head = client->head;
+
+		/* drop queue but keep our SYN_DROPPED & SYN_REPORT event */
+		if (unlikely(client->head == client->tail))
+			client->tail = (client->head - 2) & mask;
+	}
 }
 
 static void evdev_queue_syn_dropped(struct evdev_client *client)
@@ -235,18 +255,19 @@ static void __pass_event(struct evdev_client *client,
 	client->head &= client->bufsize - 1;
 
 	if (unlikely(client->head == client->tail)) {
+		client->packet_head = client->tail;
+		__evdev_queue_syn_dropped(client);
+
 		/*
-		 * This effectively "drops" all unconsumed events, leaving
-		 * EV_SYN/SYN_DROPPED plus the newest event in the queue.
+		 * Store newest event in the queue,
+		 * but if it is SYN_REPORT then it is already stored by
+		 * __evdev_queue_syn_dropped, so should not be stored again.
+		 * As buffer overrun just occurred so no need to check here.
 		 */
-		client->tail = (client->head - 2) & (client->bufsize - 1);
-
-		client->buffer[client->tail].time = event->time;
-		client->buffer[client->tail].type = EV_SYN;
-		client->buffer[client->tail].code = SYN_DROPPED;
-		client->buffer[client->tail].value = 0;
-
-		client->packet_head = client->tail;
+		if (event->type != EV_SYN && event->code != SYN_REPORT) {
+			client->buffer[client->head++] = *event;
+			client->head &= client->bufsize - 1;
+		}
 	}
 
 	if (event->type == EV_SYN && event->code == SYN_REPORT) {
-- 
1.7.9.5
