From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: evdev - drop partial events after emptying the buffer
Date: Thu, 31 Dec 2015 03:36:47 +0530
Message-ID: <1451513207-712-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>
List-Id: linux-input@vger.kernel.org

This patch introduces concept to drop partial events in evdev handler
itself after emptying the buffer which are dropped by all evdev
clients in userspace after SYN_DROPPED occurs.
This in turn saves space of partial events in evdev handler buffer
and reduces evdev client reading requests.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..e7b612e 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -58,6 +58,7 @@ struct evdev_client {
 	struct list_head node;
 	unsigned int clk_type;
 	bool revoked;
+	bool drop_pevent; /* specifies whether partial events need to be dropped */
 	unsigned long *evmasks[EV_CNT];
 	unsigned int bufsize;
 	struct input_event buffer[];
@@ -192,6 +193,7 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 {
 	unsigned long flags;
 	unsigned int clk_type;
+	struct input_event *ev;
 
 	switch (clkid) {
 
@@ -218,6 +220,17 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 		spin_lock_irqsave(&client->buffer_lock, flags);
 
 		if (client->head != client->tail) {
+
+			/*
+			 * Set drop_pevent to true if last event packet is
+			 * not stored completely in buffer.
+			 */
+			client->head--;
+			client->head &= client->bufsize - 1;
+			ev = &client->buffer[client->head];
+			if (!(ev->type == EV_SYN && ev->code == SYN_REPORT))
+				client->drop_pevent = true;
+
 			client->packet_head = client->head = client->tail;
 			__evdev_queue_syn_dropped(client);
 		}
@@ -228,31 +241,51 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 	return 0;
 }
 
-static void __pass_event(struct evdev_client *client,
+static bool __pass_event(struct evdev_client *client,
 			 const struct input_event *event)
 {
+	struct input_event *prev_ev;
+
 	client->buffer[client->head++] = *event;
 	client->head &= client->bufsize - 1;
 
 	if (unlikely(client->head == client->tail)) {
 		/*
-		 * This effectively "drops" all unconsumed events, leaving
-		 * EV_SYN/SYN_DROPPED plus the newest event in the queue.
+		 * This effectively "drops" all unconsumed events, storing
+		 * EV_SYN/SYN_DROPPED and the newest event in the queue but
+		 * only if it is not part of partial packet.
+		 * Set drop_pevent to true if last event packet is not stored
+		 * completely in buffer and set to false if SYN_REPORT occurs.
 		 */
+
 		client->tail = (client->head - 2) & (client->bufsize - 1);
 
+		prev_ev = &client->buffer[client->tail];
+		if (!(prev_ev->type == EV_SYN && prev_ev->code == SYN_REPORT)) {
+			client->drop_pevent = true;
+			client->head--;
+			client->head &= client->bufsize - 1;
+		}
+
 		client->buffer[client->tail].time = event->time;
 		client->buffer[client->tail].type = EV_SYN;
 		client->buffer[client->tail].code = SYN_DROPPED;
 		client->buffer[client->tail].value = 0;
 
 		client->packet_head = client->tail;
+
+		if (event->type == EV_SYN && event->code == SYN_REPORT) {
+			client->drop_pevent = false;
+			return true;
+		}
 	}
 
 	if (event->type == EV_SYN && event->code == SYN_REPORT) {
 		client->packet_head = client->head;
 		kill_fasync(&client->fasync, SIGIO, POLL_IN);
 	}
+
+	return false;
 }
 
 static void evdev_pass_values(struct evdev_client *client,
@@ -284,10 +317,18 @@ static void evdev_pass_values(struct evdev_client *client,
 			wakeup = true;
 		}
 
+		/* drop partial events until SYN_REPORT occurs */
+		if (client->drop_pevent) {
+			if (v->type == EV_SYN && v->code == SYN_REPORT)
+				client->drop_pevent = false;
+			continue;
+		}
+
 		event.type = v->type;
 		event.code = v->code;
 		event.value = v->value;
-		__pass_event(client, &event);
+		if (__pass_event(client, &event))
+			wakeup = false;
 	}
 
 	spin_unlock(&client->buffer_lock);
-- 
2.6.2
