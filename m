From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] Input: wacom_w8001 - simplify w8001_remove
Date: Sun, 21 Aug 2011 13:15:47 -0700
Message-ID: <1313957747-22796-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1313957747-22796-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39981 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab1HUUPv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Aug 2011 16:15:51 -0400
Received: by iye16 with SMTP id 16so9099172iye.1
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2011 13:15:51 -0700 (PDT)
In-Reply-To: <1313957747-22796-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Jaya Kumar <jayakumar.lkml@gmail.com>

Since touchscreen driver does not handle any events to be sent to the
device we can close serio port first and then unregister the input device.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/wacom_w8001.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 5ece6c1..1f42d91 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -499,12 +499,12 @@ static void w8001_disconnect(struct serio *serio)
 {
 	struct w8001 *w8001 = serio_get_drvdata(serio);
 
-	input_get_device(w8001->dev);
-	input_unregister_device(w8001->dev);
 	serio_close(serio);
-	serio_set_drvdata(serio, NULL);
-	input_put_device(w8001->dev);
+
+	input_unregister_device(w8001->dev);
 	kfree(w8001);
+
+	serio_set_drvdata(serio, NULL);
 }
 
 /*
-- 
1.7.6

