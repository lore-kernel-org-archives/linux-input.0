From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH 2/7] input: use module_i2c_driver int keyboard i2c driver
Date: Mon, 19 Dec 2011 22:23:20 +0800
Message-ID: <1324304605-18193-3-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40758 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab1LSOYq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Dec 2011 09:24:46 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so8615511iae.19
        for <linux-input@vger.kernel.org>; Mon, 19 Dec 2011 06:24:46 -0800 (PST)
In-Reply-To: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Greg Kroah-Hartman <gregkh@suse.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

module_i2c_driver has added by commit:
http://git.kernel.org/?p=linux/kernel/git/gregkh/driver-core.git;a=commitdiff;h=7c92784a546d2945b6d6973a30f7134be78eb7a4
in driver-core-next.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/keyboard/adp5588-keys.c    |   12 +-----------
 drivers/input/keyboard/adp5589-keys.c    |   12 +-----------
 drivers/input/keyboard/lm8323.c          |   12 +-----------
 drivers/input/keyboard/max7359_keypad.c  |   12 +-----------
 drivers/input/keyboard/mcs_touchkey.c    |   13 +------------
 drivers/input/keyboard/mpr121_touchkey.c |   12 +-----------
 drivers/input/keyboard/qt1070.c          |   12 +-----------
 drivers/input/keyboard/qt2160.c          |   12 +-----------
 8 files changed, 8 insertions(+), 89 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 4a7f534..39ebffa 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -653,17 +653,7 @@ static struct i2c_driver adp5588_driver = {
 	.id_table = adp5588_id,
 };
 
-static int __init adp5588_init(void)
-{
-	return i2c_add_driver(&adp5588_driver);
-}
-module_init(adp5588_init);
-
-static void __exit adp5588_exit(void)
-{
-	i2c_del_driver(&adp5588_driver);
-}
-module_exit(adp5588_exit);
+module_i2c_driver(adp5588_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 02b5d53..74e6032 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -1108,17 +1108,7 @@ static struct i2c_driver adp5589_driver = {
 	.id_table = adp5589_id,
 };
 
-static int __init adp5589_init(void)
-{
-	return i2c_add_driver(&adp5589_driver);
-}
-module_init(adp5589_init);
-
-static void __exit adp5589_exit(void)
-{
-	i2c_del_driver(&adp5589_driver);
-}
-module_exit(adp5589_exit);
+module_i2c_driver(adp5589_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 21823bf..39ac278 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -851,17 +851,7 @@ static struct i2c_driver lm8323_i2c_driver = {
 };
 MODULE_DEVICE_TABLE(i2c, lm8323_id);
 
-static int __init lm8323_init(void)
-{
-	return i2c_add_driver(&lm8323_i2c_driver);
-}
-module_init(lm8323_init);
-
-static void __exit lm8323_exit(void)
-{
-	i2c_del_driver(&lm8323_i2c_driver);
-}
-module_exit(lm8323_exit);
+module_i2c_driver(lm8323_i2c_driver);
 
 MODULE_AUTHOR("Timo O. Karjalainen <timo.o.karjalainen@nokia.com>");
 MODULE_AUTHOR("Daniel Stone");
diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index 5afe35a..8edada8 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -316,17 +316,7 @@ static struct i2c_driver max7359_i2c_driver = {
 	.id_table	= max7359_ids,
 };
 
-static int __init max7359_init(void)
-{
-	return i2c_add_driver(&max7359_i2c_driver);
-}
-module_init(max7359_init);
-
-static void __exit max7359_exit(void)
-{
-	i2c_del_driver(&max7359_i2c_driver);
-}
-module_exit(max7359_exit);
+module_i2c_driver(max7359_i2c_driver);
 
 MODULE_AUTHOR("Kim Kyuwon <q1.kim@samsung.com>");
 MODULE_DESCRIPTION("MAX7359 Key Switch Controller Driver");
diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index af1aab3..64a0ca4 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -274,18 +274,7 @@ static struct i2c_driver mcs_touchkey_driver = {
 	.id_table	= mcs_touchkey_id,
 };
 
-static int __init mcs_touchkey_init(void)
-{
-	return i2c_add_driver(&mcs_touchkey_driver);
-}
-
-static void __exit mcs_touchkey_exit(void)
-{
-	i2c_del_driver(&mcs_touchkey_driver);
-}
-
-module_init(mcs_touchkey_init);
-module_exit(mcs_touchkey_exit);
+module_i2c_driver(mcs_touchkey_driver);
 
 /* Module information */
 MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 1c1615d..caa218a 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -330,17 +330,7 @@ static struct i2c_driver mpr_touchkey_driver = {
 	.remove		= __devexit_p(mpr_touchkey_remove),
 };
 
-static int __init mpr_touchkey_init(void)
-{
-	return i2c_add_driver(&mpr_touchkey_driver);
-}
-module_init(mpr_touchkey_init);
-
-static void __exit mpr_touchkey_exit(void)
-{
-	i2c_del_driver(&mpr_touchkey_driver);
-}
-module_exit(mpr_touchkey_exit);
+module_i2c_driver(mpr_touchkey_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Zhang Jiejing <jiejing.zhang@freescale.com>");
diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index b21bf5b..0b7b2f8 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -258,17 +258,7 @@ static struct i2c_driver qt1070_driver = {
 	.remove		= __devexit_p(qt1070_remove),
 };
 
-static int __init qt1070_init(void)
-{
-	return i2c_add_driver(&qt1070_driver);
-}
-module_init(qt1070_init);
-
-static void __exit qt1070_exit(void)
-{
-	i2c_del_driver(&qt1070_driver);
-}
-module_exit(qt1070_exit);
+module_i2c_driver(qt1070_driver);
 
 MODULE_AUTHOR("Bo Shen <voice.shen@atmel.com>");
 MODULE_DESCRIPTION("Driver for AT42QT1070 QTouch sensor");
diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index fac6951..e7a5e36 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -379,17 +379,7 @@ static struct i2c_driver qt2160_driver = {
 	.remove		= __devexit_p(qt2160_remove),
 };
 
-static int __init qt2160_init(void)
-{
-	return i2c_add_driver(&qt2160_driver);
-}
-module_init(qt2160_init);
-
-static void __exit qt2160_cleanup(void)
-{
-	i2c_del_driver(&qt2160_driver);
-}
-module_exit(qt2160_cleanup);
+module_i2c_driver(qt2160_driver);
 
 MODULE_AUTHOR("Raphael Derosso Pereira <raphaelpereira@gmail.com>");
 MODULE_DESCRIPTION("Driver for AT42QT2160 Touch Sensor");
-- 
1.7.8

