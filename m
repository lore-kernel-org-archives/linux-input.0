From: Wan ZongShun <mcuos.com@gmail.com>
Subject: [PATCH] input: Rename keypad and ts platform driver for w90p910
Date: Mon, 17 Aug 2009 11:55:05 +0800
Message-ID: <4A88D499.30302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:14369 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbZHQDzL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Aug 2009 23:55:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so724861wfd.4
        for <linux-input@vger.kernel.org>; Sun, 16 Aug 2009 20:55:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org

Dear Dmitry,

Due to I modified the corresponding platform device name, 
so I make the patch to rename keypad and ts platform driver
for w90p910 platform.

Thanks!

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 drivers/input/keyboard/w90p910_keypad.c |    4 ++--
 drivers/input/touchscreen/w90p910_ts.c  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
index 24096cd..ada30ee 100644
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -267,7 +267,7 @@ static struct platform_driver w90p910_keypad_driver = {
 	.probe		= w90p910_keypad_probe,
 	.remove		= __devexit_p(w90p910_keypad_remove),
 	.driver		= {
-		.name	= "w90p910-keypad",
+		.name	= "nuc900-keypad",
 		.owner	= THIS_MODULE,
 	},
 };
@@ -288,4 +288,4 @@ module_exit(w90p910_keypad_exit);
 MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
 MODULE_DESCRIPTION("w90p910 keypad driver!");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:w90p910-keypad");
+MODULE_ALIAS("platform:nuc900-keypad");
diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index 6071f58..937dfe4 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -326,7 +326,7 @@ static struct platform_driver w90x900ts_driver = {
 	.probe		= w90x900ts_probe,
 	.remove		= __devexit_p(w90x900ts_remove),
 	.driver		= {
-		.name	= "w90x900-ts",
+		.name	= "nuc900-ts",
 		.owner	= THIS_MODULE,
 	},
 };
@@ -347,4 +347,4 @@ module_exit(w90x900ts_exit);
 MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
 MODULE_DESCRIPTION("w90p910 touch screen driver!");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:w90p910-ts");
+MODULE_ALIAS("platform:nuc900-ts");
-- 
1.5.6.3
