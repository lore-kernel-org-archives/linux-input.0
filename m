From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/9] Input: serio_raw - use dev_*() for messages
Date: Wed,  5 Oct 2011 22:08:12 -0700
Message-ID: <1317877696-7719-5-git-send-email-dmitry.torokhov@gmail.com>
References: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37992 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab1JFFI1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 01:08:27 -0400
Received: by mail-yw0-f46.google.com with SMTP id 5so2265031ywb.19
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 22:08:27 -0700 (PDT)
In-Reply-To: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thomas Tuttle <ttuttle@chromium.org>

This will ensure our reporting is consistent with the rest of the system.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/serio_raw.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index a5afc7c..396a17f 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -279,7 +279,7 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 	int err;
 
 	if (!(serio_raw = kzalloc(sizeof(struct serio_raw), GFP_KERNEL))) {
-		printk(KERN_ERR "serio_raw.c: can't allocate memory for a device\n");
+		dev_dbg(&serio->dev, "can't allocate memory for a device\n");
 		return -ENOMEM;
 	}
 
@@ -311,13 +311,14 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 	}
 
 	if (err) {
-		printk(KERN_INFO "serio_raw: failed to register raw access device for %s\n",
+		dev_err(&serio->dev,
+			"failed to register raw access device for %s\n",
 			serio->phys);
 		goto out_close;
 	}
 
-	printk(KERN_INFO "serio_raw: raw access enabled on %s (%s, minor %d)\n",
-		serio->phys, serio_raw->name, serio_raw->dev.minor);
+	dev_info(&serio->dev, "raw access enabled on %s (%s, minor %d)\n",
+		 serio->phys, serio_raw->name, serio_raw->dev.minor);
 	goto out;
 
 out_close:
@@ -337,7 +338,8 @@ static int serio_raw_reconnect(struct serio *serio)
 	struct serio_driver *drv = serio->drv;
 
 	if (!drv || !serio_raw) {
-		printk(KERN_DEBUG "serio_raw: reconnect request, but serio is disconnected, ignoring...\n");
+		dev_dbg(&serio->dev,
+			"reconnect request, but serio is disconnected, ignoring...\n");
 		return -1;
 	}
 
-- 
1.7.6.4

