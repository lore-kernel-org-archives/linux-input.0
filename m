From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input:Flush client events after clk_type change
Date: Tue,  6 Jan 2015 06:02:33 -0800
Message-ID: <1420552953-23932-1-git-send-email-aksgarg1989@gmail.com>
References: <anshul.g>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:64675 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451AbbAFODE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 09:03:04 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so29356693wgh.32
        for <linux-input@vger.kernel.org>; Tue, 06 Jan 2015 06:03:03 -0800 (PST)
In-Reply-To: <anshul.g>
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
 drivers/input/evdev.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index b1a52ab..91330e1 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -64,6 +64,9 @@ struct evdev_client {
 
 static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 {
+	if (client->clk_type == clkid)
+		return 0;
+
 	switch (clkid) {
 
 	case CLOCK_REALTIME:
@@ -78,7 +81,11 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 	default:
 		return -EINVAL;
 	}
-
+
+	/* Flush clients events after clk_type is changed
+	 * and queue SYN_DROPPED event.*/
+	client->packet_head = client->head = client->tail;
+	evdev_queue_syn_dropped(client);
 	return 0;
 }
 
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
http://www.avast.com

