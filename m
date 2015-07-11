From: HungNien Chen <hn.chen@weidahitech.com>
Subject: [PATCH] Input: wdt87xx_i2c - Change the sleep time to 2500ms after the sw reset
Date: Sat, 11 Jul 2015 22:36:42 +0800
Message-ID: <1436625402-4501-1-git-send-email-hn.chen@weidahitech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2275 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbbGKOhW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jul 2015 10:37:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, charliemooney@google.com, HungNien Chen <hn.chen@weidahitech.com>

 The original value is 200ms, it includes the loading fw & boot up to
 the main function. After that, the main function will do algorithm
 initialized and touch calibrtion about 1.1 second. The touch
 calibration will change controller freq to scan the best working freq 
 and it has risk to make the i2c data error when doing fw update. 
 We extend the sleep to 2500ms after the sw reset to skip this period time.

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/input/touchscreen/wdt87xx_i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index b97cb4f..cfd1487 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -157,6 +157,7 @@
 /* Controller requires minimum 300us between commands */
 #define WDT_COMMAND_DELAY_MS		2
 #define WDT_FLASH_WRITE_DELAY_MS	4
+#define	WDT_FW_RESET_TIME		2500
 
 struct wdt87xx_sys_param {
 	u16	fw_id;
@@ -413,7 +414,7 @@ static int wdt87xx_sw_reset(struct i2c_client *client)
 	}
 
 	/* Wait the device to be ready */
-	msleep(200);
+	msleep(WDT_FW_RESET_TIME);
 
 	return 0;
 }
-- 
1.9.1

