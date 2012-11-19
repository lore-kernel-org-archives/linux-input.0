From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 359/493] input: remove use of __devinitconst
Date: Mon, 19 Nov 2012 13:25:08 -0500
Message-ID: <1353349642-3677-359-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41487 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab2KSSen (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Nov 2012 13:34:43 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com> 
Cc: linux-input@vger.kernel.org 
---
 drivers/input/keyboard/locomokbd.c       | 2 +-
 drivers/input/keyboard/mpr121_touchkey.c | 2 +-
 drivers/input/serio/xilinx_ps2.c         | 2 +-
 drivers/input/touchscreen/st1232.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index e0c55d0..e289246 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -46,7 +46,7 @@ MODULE_LICENSE("GPL");
 #define KEY_CENTER		KEY_F15
 
 static const unsigned char
-locomokbd_keycode[LOCOMOKBD_NUMKEYS] __devinitconst = {
+locomokbd_keycode[LOCOMOKBD_NUMKEYS] = {
 	0, KEY_ESC, KEY_ACTIVITY, 0, 0, 0, 0, 0, 0, 0,				/* 0 - 9 */
 	0, 0, 0, 0, 0, 0, 0, KEY_MENU, KEY_HOME, KEY_CONTACT,			/* 10 - 19 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,						/* 20 - 29 */
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index a2233c4..8ecc725 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -71,7 +71,7 @@ struct mpr121_init_register {
 	u8 val;
 };
 
-static const struct mpr121_init_register init_reg_table[] __devinitconst = {
+static const struct mpr121_init_register init_reg_table[] = {
 	{ MHD_RISING_ADDR,	0x1 },
 	{ NHD_RISING_ADDR,	0x1 },
 	{ MHD_FALLING_ADDR,	0x1 },
diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 5007a21..ed5e8e6 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -355,7 +355,7 @@ static int __devexit xps2_of_remove(struct platform_device *of_dev)
 }
 
 /* Match table for of_platform binding */
-static const struct of_device_id xps2_of_match[] __devinitconst = {
+static const struct of_device_id xps2_of_match[] = {
 	{ .compatible = "xlnx,xps-ps2-1.00.a", },
 	{ /* end of list */ },
 };
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index cc5c1fb..2a71dfd 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -255,7 +255,7 @@ static const struct i2c_device_id st1232_ts_id[] = {
 MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
 
 #ifdef CONFIG_OF
-static const struct of_device_id st1232_ts_dt_ids[] __devinitconst = {
+static const struct of_device_id st1232_ts_dt_ids[] = {
 	{ .compatible = "sitronix,st1232", },
 	{ }
 };
-- 
1.8.0

