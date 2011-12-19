From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH 5/7] input: use module_i2c_driver in touchscreen i2c driver
Date: Mon, 19 Dec 2011 22:23:23 +0800
Message-ID: <1324304605-18193-6-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55913 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab1LSOY5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Dec 2011 09:24:57 -0500
Received: by mail-gx0-f174.google.com with SMTP id k6so4006254ggd.19
        for <linux-input@vger.kernel.org>; Mon, 19 Dec 2011 06:24:57 -0800 (PST)
In-Reply-To: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Greg Kroah-Hartman <gregkh@suse.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

module_i2c_driver has been queued by commit:
http://git.kernel.org/?p=linux/kernel/git/gregkh/driver-core.git;a=commitdiff;h=7c92784a546d2945b6d6973a30f7134be78eb7a4
in driver-core-next.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/touchscreen/ad7879-i2c.c    |   12 +-----------
 drivers/input/touchscreen/atmel_mxt_ts.c  |   13 +------------
 drivers/input/touchscreen/bu21013_ts.c    |   25 +------------------------
 drivers/input/touchscreen/cy8ctmg110_ts.c |   13 +------------
 drivers/input/touchscreen/eeti_ts.c       |   14 +-------------
 drivers/input/touchscreen/egalax_ts.c     |   13 +------------
 drivers/input/touchscreen/max11801_ts.c   |   13 +------------
 drivers/input/touchscreen/mcs5000_ts.c    |   13 +------------
 drivers/input/touchscreen/migor_ts.c      |   13 +------------
 drivers/input/touchscreen/st1232.c        |   12 +-----------
 drivers/input/touchscreen/tsc2007.c       |   13 +------------
 11 files changed, 11 insertions(+), 143 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index 0dac671..3054354 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -102,17 +102,7 @@ static struct i2c_driver ad7879_i2c_driver = {
 	.id_table	= ad7879_id,
 };
 
-static int __init ad7879_i2c_init(void)
-{
-	return i2c_add_driver(&ad7879_i2c_driver);
-}
-module_init(ad7879_i2c_init);
-
-static void __exit ad7879_i2c_exit(void)
-{
-	i2c_del_driver(&ad7879_i2c_driver);
-}
-module_exit(ad7879_i2c_exit);
+module_i2c_driver(ad7879_i2c_driver);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("AD7879(-1) touchscreen I2C bus driver");
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index a596c27..19d4ea6 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1267,18 +1267,7 @@ static struct i2c_driver mxt_driver = {
 	.id_table	= mxt_id,
 };
 
-static int __init mxt_init(void)
-{
-	return i2c_add_driver(&mxt_driver);
-}
-
-static void __exit mxt_exit(void)
-{
-	i2c_del_driver(&mxt_driver);
-}
-
-module_init(mxt_init);
-module_exit(mxt_exit);
+module_i2c_driver(mxt_driver);
 
 /* Module information */
 MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 902c721..f2d03c0 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -652,30 +652,7 @@ static struct i2c_driver bu21013_driver = {
 	.id_table	=	bu21013_id,
 };
 
-/**
- * bu21013_init() - initializes the bu21013 touchscreen driver
- *
- * This function used to initializes the bu21013
- * touchscreen driver and returns integer.
- */
-static int __init bu21013_init(void)
-{
-	return i2c_add_driver(&bu21013_driver);
-}
-
-/**
- * bu21013_exit() - de-initializes the bu21013 touchscreen driver
- *
- * This function uses to de-initializes the bu21013
- * touchscreen driver and returns none.
- */
-static void __exit bu21013_exit(void)
-{
-	i2c_del_driver(&bu21013_driver);
-}
-
-module_init(bu21013_init);
-module_exit(bu21013_exit);
+module_i2c_driver(bu21013_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Naveen Kumar G <naveen.gaddipati@stericsson.com>");
diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index d8815c5..237753a 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -350,18 +350,7 @@ static struct i2c_driver cy8ctmg110_driver = {
 	.remove		= __devexit_p(cy8ctmg110_remove),
 };
 
-static int __init cy8ctmg110_init(void)
-{
-	return i2c_add_driver(&cy8ctmg110_driver);
-}
-
-static void __exit cy8ctmg110_exit(void)
-{
-	i2c_del_driver(&cy8ctmg110_driver);
-}
-
-module_init(cy8ctmg110_init);
-module_exit(cy8ctmg110_exit);
+module_i2c_driver(cy8ctmg110_driver);
 
 MODULE_AUTHOR("Samuli Konttila <samuli.konttila@aavamobile.com>");
 MODULE_DESCRIPTION("cy8ctmg110 TouchScreen Driver");
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 7f8f538..cab5312 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -320,20 +320,8 @@ static struct i2c_driver eeti_ts_driver = {
 	.id_table = eeti_ts_id,
 };
 
-static int __init eeti_ts_init(void)
-{
-	return i2c_add_driver(&eeti_ts_driver);
-}
-
-static void __exit eeti_ts_exit(void)
-{
-	i2c_del_driver(&eeti_ts_driver);
-}
+module_i2c_driver(eeti_ts_driver);
 
 MODULE_DESCRIPTION("EETI Touchscreen driver");
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
 MODULE_LICENSE("GPL");
-
-module_init(eeti_ts_init);
-module_exit(eeti_ts_exit);
-
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index eadcc2e..70524dd 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -285,18 +285,7 @@ static struct i2c_driver egalax_ts_driver = {
 	.remove		= __devexit_p(egalax_ts_remove),
 };
 
-static int __init egalax_ts_init(void)
-{
-	return i2c_add_driver(&egalax_ts_driver);
-}
-
-static void __exit egalax_ts_exit(void)
-{
-	i2c_del_driver(&egalax_ts_driver);
-}
-
-module_init(egalax_ts_init);
-module_exit(egalax_ts_exit);
+module_i2c_driver(egalax_ts_driver);
 
 MODULE_AUTHOR("Freescale Semiconductor, Inc.");
 MODULE_DESCRIPTION("Touchscreen driver for EETI eGalax touch controller");
diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index 4627fe5..4eab50b 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -255,18 +255,7 @@ static struct i2c_driver max11801_ts_driver = {
 	.remove		= __devexit_p(max11801_ts_remove),
 };
 
-static int __init max11801_ts_init(void)
-{
-	return i2c_add_driver(&max11801_ts_driver);
-}
-
-static void __exit max11801_ts_exit(void)
-{
-	i2c_del_driver(&max11801_ts_driver);
-}
-
-module_init(max11801_ts_init);
-module_exit(max11801_ts_exit);
+module_i2c_driver(max11801_ts_driver);
 
 MODULE_AUTHOR("Zhang Jiejing <jiejing.zhang@freescale.com>");
 MODULE_DESCRIPTION("Touchscreen driver for MAXI MAX11801 controller");
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 2d84c80..b528511 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -302,18 +302,7 @@ static struct i2c_driver mcs5000_ts_driver = {
 	.id_table	= mcs5000_ts_id,
 };
 
-static int __init mcs5000_ts_init(void)
-{
-	return i2c_add_driver(&mcs5000_ts_driver);
-}
-
-static void __exit mcs5000_ts_exit(void)
-{
-	i2c_del_driver(&mcs5000_ts_driver);
-}
-
-module_init(mcs5000_ts_init);
-module_exit(mcs5000_ts_exit);
+module_i2c_driver(mcs5000_ts_driver);
 
 /* Module information */
 MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
diff --git a/drivers/input/touchscreen/migor_ts.c b/drivers/input/touchscreen/migor_ts.c
index 5226194..c038db9 100644
--- a/drivers/input/touchscreen/migor_ts.c
+++ b/drivers/input/touchscreen/migor_ts.c
@@ -242,19 +242,8 @@ static struct i2c_driver migor_ts_driver = {
 	.id_table = migor_ts_id,
 };
 
-static int __init migor_ts_init(void)
-{
-	return i2c_add_driver(&migor_ts_driver);
-}
-
-static void __exit migor_ts_exit(void)
-{
-	i2c_del_driver(&migor_ts_driver);
-}
+module_i2c_driver(migor_ts_driver);
 
 MODULE_DESCRIPTION("MigoR Touchscreen driver");
 MODULE_AUTHOR("Magnus Damm <damm@opensource.se>");
 MODULE_LICENSE("GPL");
-
-module_init(migor_ts_init);
-module_exit(migor_ts_exit);
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 4ab3713..86c71f4 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -257,17 +257,7 @@ static struct i2c_driver st1232_ts_driver = {
 	},
 };
 
-static int __init st1232_ts_init(void)
-{
-	return i2c_add_driver(&st1232_ts_driver);
-}
-module_init(st1232_ts_init);
-
-static void __exit st1232_ts_exit(void)
-{
-	i2c_del_driver(&st1232_ts_driver);
-}
-module_exit(st1232_ts_exit);
+module_i2c_driver(st1232_ts_driver);
 
 MODULE_AUTHOR("Tony SIM <chinyeow.sim.xt@renesas.com>");
 MODULE_DESCRIPTION("SITRONIX ST1232 Touchscreen Controller Driver");
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 1f674cb..1473d23 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -399,18 +399,7 @@ static struct i2c_driver tsc2007_driver = {
 	.remove		= __devexit_p(tsc2007_remove),
 };
 
-static int __init tsc2007_init(void)
-{
-	return i2c_add_driver(&tsc2007_driver);
-}
-
-static void __exit tsc2007_exit(void)
-{
-	i2c_del_driver(&tsc2007_driver);
-}
-
-module_init(tsc2007_init);
-module_exit(tsc2007_exit);
+module_i2c_driver(tsc2007_driver);
 
 MODULE_AUTHOR("Kwangwoo Lee <kwlee@mtekvision.com>");
 MODULE_DESCRIPTION("TSC2007 TouchScreen Driver");
-- 
1.7.8

