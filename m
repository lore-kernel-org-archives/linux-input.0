From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input:Flush client events on clk_type change
Date: Wed,  7 Jan 2015 10:56:03 -0800
Message-ID: <1420656963-44602-1-git-send-email-aksgarg1989@gmail.com>
References: <aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:48973 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbbAGS4d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Jan 2015 13:56:33 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so1753857wgh.1
        for <linux-input@vger.kernel.org>; Wed, 07 Jan 2015 10:56:32 -0800 (PST)
In-Reply-To: <aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com

From: Anshul Garg <aksgarg1989@gmail.com>

Since the client clk_type is changed , flush pending
events from client buffer and queue SYN_DROPPED event.
Added check for duplicate clk_type change request.

Signed-off-by: Anshul Garg <anshul.g@samsung.com>
---
 drivers/input/evdev.c |   58 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index b1a52ab..223367e 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -62,27 +62,6 @@ struct evdev_client {
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
-/* flush queued events of type @type, caller must hold client->buffer_lock */
 static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 {
 	unsigned int i, head, num;
@@ -160,6 +139,41 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
 	spin_unlock_irqrestore(&client->buffer_lock, flags);
 }
 
+static int evdev_set_clk_type(struct evdev_client *client,
+			struct input_dev *dev, unsigned int clkid)
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
+	spin_lock_irq(&dev->event_lock);
+	spin_lock(&client->buffer_lock);
+	spin_unlock(&dev->event_lock);
+
+	/* Flush clients events after clk_type is changed
+	 * and queue SYN_DROPPED event.*/
+	client->packet_head = client->head = client->tail;
+	spin_unlock_irq(&client->buffer_lock);
+
+	evdev_queue_syn_dropped(client);
+	return 0;
+}
+
+/* flush queued events of type @type, caller must hold client->buffer_lock */
 static void __pass_event(struct evdev_client *client,
 			 const struct input_event *event)
 {
@@ -908,7 +922,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 		if (copy_from_user(&i, p, sizeof(unsigned int)))
 			return -EFAULT;
 
-		return evdev_set_clk_type(client, i);
+		return evdev_set_clk_type(client, dev, i);
 
 	case EVIOCGKEYCODE:
 		return evdev_handle_get_keycode(dev, p);
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
http://www.avast.com

