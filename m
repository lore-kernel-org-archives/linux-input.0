From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input:Evdev Flush pending events on clk change
Date: Fri,  9 Jan 2015 06:13:01 -0800
Message-ID: <1420812782-60962-1-git-send-email-aksgarg1989@gmail.com>
References: <aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:47040 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbbAIONb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2015 09:13:31 -0500
Received: by mail-wg0-f53.google.com with SMTP id x13so8326631wgg.12
        for <linux-input@vger.kernel.org>; Fri, 09 Jan 2015 06:13:29 -0800 (PST)
In-Reply-To: <aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com

From: Anshul Garg <aksgarg1989@gmail.com>

If client clk_type is changed , flush pending events
from client buffer as events time would be incorrect
and queue SYN_DROPPED event.
Added check for duplicate clk_type change request.

Signed-off-by: Anshul Garg <anshul.g@samsung.com>
---
 drivers/input/evdev.c |   56 +++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index b1a52ab..0f72bcb 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -62,26 +62,6 @@ struct evdev_client {
 	struct input_event buffer[];
 };
 
-static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
-{
-	switch (clkid) {
-
-	case CLOCK_REALTIME:
-		client->clk_type = EV_CLK_REAL;
-		break;
-	case CLOCK_MONOTONIC:
-		client->clk_type = EV_CLK_MONO;
-		break;
-	case CLOCK_BOOTTIME:
-		client->clk_type = EV_CLK_BOOT;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /* flush queued events of type @type, caller must hold client->buffer_lock */
 static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 {
@@ -128,8 +108,8 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 	client->head = head;
 }
 
-/* queue SYN_DROPPED event */
-static void evdev_queue_syn_dropped(struct evdev_client *client)
+/* queue SYN_DROPPED event and flush queue if flush parameter is true */
+static void evdev_queue_syn_dropped(struct evdev_client *client, bool flush)
 {
 	unsigned long flags;
 	struct input_event ev;
@@ -148,6 +128,9 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
 
 	spin_lock_irqsave(&client->buffer_lock, flags);
 
+	if (flush)
+		client->packet_head = client->head = client->tail;
+
 	client->buffer[client->head++] = ev;
 	client->head &= client->bufsize - 1;
 
@@ -160,6 +143,33 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
 	spin_unlock_irqrestore(&client->buffer_lock, flags);
 }
 
+/* Set client CLOCK and flush pending events */
+static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
+{
+	if (client->clk_type == clkid)
+		return 0;
+
+	switch (clkid) {
+
+	case CLOCK_REALTIME:
+		client->clk_type = EV_CLK_REAL;
+		break;
+	case CLOCK_MONOTONIC:
+		client->clk_type = EV_CLK_MONO;
+		break;
+	case CLOCK_BOOTTIME:
+		client->clk_type = EV_CLK_BOOT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Flush pending events and queue SYN_DROPPED event.*/
+	evdev_queue_syn_dropped(client, true);
+
+	return 0;
+}
+
 static void __pass_event(struct evdev_client *client,
 			 const struct input_event *event)
 {
@@ -794,7 +804,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
 
 	ret = bits_to_user(mem, maxbit, maxlen, p, compat);
 	if (ret < 0)
-		evdev_queue_syn_dropped(client);
+		evdev_queue_syn_dropped(client, false);
 
 	kfree(mem);
 
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
http://www.avast.com

