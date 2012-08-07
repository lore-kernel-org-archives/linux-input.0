From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] Input: Fix edt-ft5x06 build error seen if CONFIG_DEBUG_FS is not defined
Date: Mon,  6 Aug 2012 20:02:05 -0700
Message-ID: <1344308525-11262-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:59474 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599Ab2HGDCK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Aug 2012 23:02:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Simon Budig <simon.budig@kernelconcepts.de>

Fix:

edt-ft5x06.c: In function edt_ft5x06_ts_remove:
edt-ft5x06.c:846:14: error: struct edt_ft5x06_ts_data has no member named
raw_buffer

Cc: Simon Budig <simon.budig@kernelconcepts.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/edt-ft5x06.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 9afc777..b06a5e3 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -602,6 +602,7 @@ edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
 {
 	if (tsdata->debug_dir)
 		debugfs_remove_recursive(tsdata->debug_dir);
+	kfree(tsdata->raw_buffer);
 }
 
 #else
@@ -843,7 +844,6 @@ static int __devexit edt_ft5x06_ts_remove(struct i2c_client *client)
 	if (gpio_is_valid(pdata->reset_pin))
 		gpio_free(pdata->reset_pin);
 
-	kfree(tsdata->raw_buffer);
 	kfree(tsdata);
 
 	return 0;
-- 
1.7.9.7

