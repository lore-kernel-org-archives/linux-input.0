From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2 v2] input: wacom_w8001 - resolution wasn't set for ABS_MT_POSITION_X/Y
Date: Fri, 15 Jul 2016 16:25:57 -0700
Message-ID: <1468625157-17766-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32919 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbcGOX0J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jul 2016 19:26:09 -0400
Received: by mail-pf0-f196.google.com with SMTP id i6so6785942pfe.0
        for <linux-input@vger.kernel.org>; Fri, 15 Jul 2016 16:26:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Ping Cheng <pingc@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>

Also, process error handling for input_mt_init_slots before moving
forward.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
v2: splited from PATCH] input: wacom_w8001 - cleanup 2FG touch code,
as suggested by Dmitry.
---
 drivers/input/touchscreen/wacom_w8001.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index fe983e7..7e807af 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -509,13 +509,20 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
 		w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
 
 		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
-		input_mt_init_slots(dev, 2, 0);
+		error = input_mt_init_slots(dev, 2, 0);
+		if (error) {
+			pr_debug("w8001: failed to initialize MT slots: %d\n", error);
+			return error;
+		}
+
 		input_set_abs_params(dev, ABS_MT_POSITION_X,
 					0, touch.x, 0, 0);
 		input_set_abs_params(dev, ABS_MT_POSITION_Y,
 					0, touch.y, 0, 0);
 		input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
 					0, MT_TOOL_MAX, 0, 0);
+		input_abs_set_res(dev, ABS_MT_POSITION_X, touch.panel_res);
+		input_abs_set_res(dev, ABS_MT_POSITION_Y, touch.panel_res);
 
 		strlcat(basename, " 2FG", basename_sz);
 		if (w8001->max_pen_x && w8001->max_pen_y)
-- 
1.8.3.1

