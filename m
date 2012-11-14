From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/5] Input: tca8418_keypad - move device ID tables closer to where they are used
Date: Wed, 14 Nov 2012 08:48:06 -0800
Message-ID: <1352911688-5001-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43345 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423100Ab2KNQsP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Nov 2012 11:48:15 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so409408pad.19
        for <linux-input@vger.kernel.org>; Wed, 14 Nov 2012 08:48:15 -0800 (PST)
In-Reply-To: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: linux-input@vger.kernel.org

This matches structure of most other input drivers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 7f2869f..35340c3 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -110,21 +110,6 @@
 #define KEY_EVENT_CODE		0x7f
 #define KEY_EVENT_VALUE		0x80
 
-
-static const struct i2c_device_id tca8418_id[] = {
-	{ TCA8418_NAME, 8418, },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, tca8418_id);
-
-#ifdef CONFIG_OF
-static const struct of_device_id tca8418_dt_ids[] __devinitconst = {
-	{ .compatible = "ti,tca8418", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, tca8418_dt_ids);
-#endif
-
 struct tca8418_keypad {
 	unsigned int irq;
 	unsigned int row_shift;
@@ -419,6 +404,20 @@ static int __devexit tca8418_keypad_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id tca8418_id[] = {
+	{ TCA8418_NAME, 8418, },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tca8418_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id tca8418_dt_ids[] __devinitconst = {
+	{ .compatible = "ti,tca8418", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tca8418_dt_ids);
+#endif
+
 static struct i2c_driver tca8418_keypad_driver = {
 	.driver = {
 		.name	= TCA8418_NAME,
-- 
1.7.11.7

