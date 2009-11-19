From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: polled device - schedule first poll immediately
Date: Wed, 18 Nov 2009 23:04:45 -0800
Message-ID: <20091119070445.GC3010@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:43638 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbZKSHEn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 02:04:43 -0500
Received: by pxi10 with SMTP id 10so1424604pxi.33
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2009 23:04:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>

It does not make sense to wait poll_interval before performing first
read after opening the device, schedule the read immediately instead.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input-polldev.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)


diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 094f4b9..9628be6 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -88,8 +88,7 @@ static int input_open_polled_device(struct input_dev *input)
 	if (dev->open)
 		dev->open(dev);
 
-	queue_delayed_work(polldev_wq, &dev->work,
-			   msecs_to_jiffies(dev->poll_interval));
+	queue_delayed_work(polldev_wq, &dev->work, 0);
 
 	return 0;
 }
-- 
Dmitry
