From: Architha Chitukuri <a.chitukuri@samsung.com>
Subject: [PATCH] Replace kmalloc with kmalloc_array
Date: Thu, 08 Dec 2016 10:43:24 +0530
Message-ID: <1481174004-2138-1-git-send-email-a.chitukuri@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39995 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbcLHFPu (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Dec 2016 00:15:50 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHU02XOJPAC1D70@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 08 Dec 2016 14:15:48 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitri Torokhov <dmitry.torokhov@gmail.com>, Architha Chitukuri <a.chitukuri@samsung.com>
Cc: linux-input@vger.kernel.org, vidushi.koul@samsung.com, archithachitukuri@gmail.com

From: "a.chitukuri" <a.chitukuri@samsung.com>

Replace kmalloc with a more specific function kmalloc_array
when allocated memory size is a multiplication of: NUMBER*SIZE


Signed-off-by: a.chitukuri <a.chitukuri@samsung.com>
---
 drivers/input/joystick/joydump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
index d1c6e48..7f4dff9 100644
--- a/drivers/input/joystick/joydump.c
+++ b/drivers/input/joystick/joydump.c
@@ -80,7 +80,7 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
 
 	timeout = gameport_time(gameport, 10000); /* 10 ms */
 
-	buf = kmalloc(BUF_SIZE * sizeof(struct joydump), GFP_KERNEL);
+	buf = kmalloc_array(BUF_SIZE, sizeof(struct joydump), GFP_KERNEL);
 	if (!buf) {
 		printk(KERN_INFO "joydump: no memory for testing\n");
 		goto jd_end;
-- 
1.7.9.5

