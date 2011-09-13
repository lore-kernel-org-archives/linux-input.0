From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 2/3] TSC-40: fix checkstyle issues
Date: Tue, 13 Sep 2011 10:18:35 +0200
Message-ID: <CAH9NwWfEAag2+d_s3tbNyLV_oi23fTaeXtWvCm8-W+E69fxDcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63152 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab1IMISz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 04:18:55 -0400
Received: by gyg10 with SMTP id 10so234281gyg.19
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 01:18:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: bigeasy@linutronix.de

>From 3e46bad59a19787a23efb4972117243701d973bd Mon Sep 17 00:00:00 2001
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 7 Sep 2011 14:13:29 +0200
Subject: [PATCH 2/3] TSC40: fix checkstyle issues

This patch fixes all found problems.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
drivers/input/touchscreen/tsc40.c |   63 +++++++++++++++++++------------------
1 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/input/touchscreen/tsc40.c
b/drivers/input/touchscreen/tsc40.c
index c9a86cd..b73ef2f 100644
--- a/drivers/input/touchscreen/tsc40.c
+++ b/drivers/input/touchscreen/tsc40.c
@@ -178,7 +178,7 @@ static irqreturn_t tsc_interrupt(struct serio *serio,
{
       struct tsc_ser *ptsc = serio_get_drvdata(serio);

-       switch(ptsc->state) {
+       switch (ptsc->state) {
       case STATE_GET_ID:
               handle_get_id(serio, data);
               break;
@@ -267,7 +267,7 @@ static int tsc_connect(struct serio *serio, struct
serio_driver *drv)
               if (ret)
                       goto fail3;

-               msleep(15);
+               msleep(20);
               ret = tsc_get_id(serio, STATE_GET_ID);
               if (ret)
                       goto fail3;
@@ -276,7 +276,7 @@ static int tsc_connect(struct serio *serio, struct
serio_driver *drv)
               if (ret)
                       goto fail3;

-               msleep(15);
+               msleep(20);

               ret = tsc_get_id(serio, STATE_RESET_GET_ID);
               if (ret)
@@ -285,34 +285,35 @@ static int tsc_connect(struct serio *serio,
struct serio_driver *drv)

       mode = ptsc->data[0];
       switch (mode) {
-               case 0x00:
-                       ptsc->state = STATE_INIT_MODE;
-                       break;
+       case 0x00:
+               ptsc->state = STATE_INIT_MODE;
+               break;

-               case 0x05:
-               case 0x01:
-               case 0x21:
-               case 0x31:
-               case 0x02:
-               case 0x0a:
-               case 0x2a:
-               case 0x3a:
-                       ret = serio_write(serio, TSC10_CMD_RESET);
-                       if (ret)
-                               goto fail3;
-                       msleep(16);
-                       ret = tsc_get_id(serio, STATE_GET_ID);
-                       if (ret)
-                               goto fail3;
-                       if (ptsc->data[0] == 0) {
-                               ptsc->state = STATE_INIT_MODE;
-                               break;
-                       }
-                       dev_err(&serio->dev, "Can't get into init mode
in %x\n", ptsc->data[0]);
+       case 0x05:
+       case 0x01:
+       case 0x21:
+       case 0x31:
+       case 0x02:
+       case 0x0a:
+       case 0x2a:
+       case 0x3a:
+               ret = serio_write(serio, TSC10_CMD_RESET);
+               if (ret)
                       goto fail3;
-               default:
-                       dev_err(&serio->dev, "Unexpected mode: %02x\n", mode);
+               msleep(20);
+               ret = tsc_get_id(serio, STATE_GET_ID);
+               if (ret)
                       goto fail3;
+               if (ptsc->data[0] == 0) {
+                       ptsc->state = STATE_INIT_MODE;
+                       break;
+               }
+               dev_err(&serio->dev, "Can't get into init mode in %x\n",
+                       ptsc->data[0]);
+               goto fail3;
+       default:
+               dev_err(&serio->dev, "Unexpected mode: %02x\n", mode);
+               goto fail3;
       }

       ptsc->idx = 0;
@@ -344,11 +345,11 @@ static int tsc_connect(struct serio *serio,
struct serio_driver *drv)
               goto fail3;

       return 0;
- fail3:
+fail3:
       serio_close(serio);
- fail2:
+fail2:
       serio_set_drvdata(serio, NULL);
- fail1:
+fail1:
       input_free_device(input_dev);
       kfree(ptsc);
       return ret;
--
1.7.4.1
