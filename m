From: <hn.chen@weidahitech.com>
Subject: [PATCH] Input: wdt87xx_i2c - fix the flash erase issue
Date: Mon, 5 Sep 2016 17:02:16 +0800
Message-ID: <1473066136-2781-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2322 "EHLO
        ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755301AbcIEJBS (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Sep 2016 05:01:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, HungNien Chen <hn.chen@weidahitech.com>

From: HungNien Chen <hn.chen@weidahitech.com>

Flash erase wait 50ms for the operation completed in last driver.
It will take risk since the spec says the typical is 30ms but the max is
200ms. Replace the value with 200ms for safty.

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/input/touchscreen/wdt87xx_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index 73861ad..2519617 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -23,7 +23,7 @@
 #include <asm/unaligned.h>
 
 #define WDT87XX_NAME		"wdt87xx_i2c"
-#define WDT87XX_DRV_VER		"0.9.7"
+#define WDT87XX_DRV_VER		"0.9.8"
 #define WDT87XX_FW_NAME		"wdt87xx_fw.bin"
 #define WDT87XX_CFG_NAME	"wdt87xx_cfg.bin"
 
@@ -157,6 +157,7 @@
 /* Controller requires minimum 300us between commands */
 #define WDT_COMMAND_DELAY_MS		2
 #define WDT_FLASH_WRITE_DELAY_MS	4
+#define	WDT_FLASH_ERASE_DELAY_MS	200
 #define WDT_FW_RESET_TIME		2500
 
 struct wdt87xx_sys_param {
@@ -726,7 +727,7 @@ static int wdt87xx_write_firmware(struct i2c_client *client, const void *chunk)
 				break;
 			}
 
-			msleep(50);
+			msleep(WDT_FLASH_ERASE_DELAY_MS);
 
 			error = wdt87xx_write_data(client, data, start_addr,
 						   page_size);
-- 
1.9.1

