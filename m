From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Evdev: Fix bug in checking duplicate clock change request
Date: Thu, 29 Oct 2015 01:38:32 +0530
Message-ID: <1446062912-9181-1-git-send-email-aniroop.mathur@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35254 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbbJ1UIh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Oct 2015 16:08:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: aniroop.mathur@gmail.com, a.mathur@samsung.com

From: Aniroop Mathur <a.mathur@samsung.com>

clk_type and clkid stores different predefined clock identification
values so they cannot be compared for checking duplicate clock change
request. Therefore, lets fix it to avoid unexpected results.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
Signed-off-by: Aniroop Mathur <aniroop.mathur@gmail.com>
---
 drivers/input/evdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 08d4964..0d40f6f 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -56,7 +56,7 @@ struct evdev_client {
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
-	int clk_type;
+	unsigned int clk_type;
 	bool revoked;
 	unsigned int bufsize;
 	struct input_event buffer[];
@@ -146,9 +146,7 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
 static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 {
 	unsigned long flags;
-
-	if (client->clk_type == clkid)
-		return 0;
+	unsigned int prev_clk_type = client->clk_type;
 
 	switch (clkid) {
 
@@ -165,6 +163,10 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 		return -EINVAL;
 	}
 
+	/* No need to flush if clk_type is same as before */
+	if (client->clk_type == prev_clk_type)
+		return 0;
+
 	/*
 	 * Flush pending events and queue SYN_DROPPED event,
 	 * but only if the queue is not empty.
-- 
2.6.2

