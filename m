From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] Input:mouse:synaptics_i2c - Change 1 to true for bool type
Date: Mon, 25 May 2015 22:48:44 +0530
Message-ID: <1432574324-3198-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33194 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbEYRS5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 13:18:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>

The variable no_decel is bool type so assigning true
instead of 1.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 878f184..a8998ba 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -185,7 +185,7 @@
 #define NO_DATA_SLEEP_MSECS	(MSEC_PER_SEC / 4)
 
 /* Control touchpad's No Deceleration option */
-static bool no_decel = 1;
+static bool no_decel = true;
 module_param(no_decel, bool, 0644);
 MODULE_PARM_DESC(no_decel, "No Deceleration. Default = 1 (on)");
 
-- 
1.7.9.5

