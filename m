From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input:Flush client events on clk_type change
Date: Wed,  7 Jan 2015 10:26:25 -0800
Message-ID: <1420655185-24555-1-git-send-email-aksgarg1989@gmail.com>
References: <aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38068 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbbAGS1B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Jan 2015 13:27:01 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so8631626wiv.2
        for <linux-input@vger.kernel.org>; Wed, 07 Jan 2015 10:27:00 -0800 (PST)
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
 drivers/input/evdev.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index b1a52ab..d024fc6 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -62,8 +62,12 @@ struct evdev_client {
 	struct input_event buffer[];
 };
 
-static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
+static int evdev_set_clk_type(struct evdev_client *client,
+			struct input_dev *dev, unsigned int clkid)
 {
+	if (client->clk_type == clkid)
+		return 0;
+
 	switch (clkid) {
 
 	case CLOCK_REALTIME:
@@ -78,7 +82,17 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 	default:
 		return -EINVAL;
 	}
+
+	spin_lock_irq(&dev->event_lock);
+	spin_lock(&client->buffer_lock);
+	spin_unlock(&dev->event_lock);
 
+	/* Flush clients events after clk_type is changed
+	 * and queue SYN_DROPPED event.*/
+	client->packet_head = client->head = client->tail;
+	spin_unlock_irq(&client->buffer_lock);
+
+	evdev_queue_syn_dropped(client);
 	return 0;
 }
 
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

