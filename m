From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH 7/7] input: use module_spi_driver in touchscreen spi drivers
Date: Mon, 19 Dec 2011 22:23:25 +0800
Message-ID: <1324304605-18193-8-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40758 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab1LSOZE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Dec 2011 09:25:04 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so8615511iae.19
        for <linux-input@vger.kernel.org>; Mon, 19 Dec 2011 06:25:04 -0800 (PST)
In-Reply-To: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Greg Kroah-Hartman <gregkh@suse.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

module_spi_driver has been queued by commit:
http://git.kernel.org/?p=linux/kernel/git/gregkh/driver-core.git;a=commitdiff;h=3acbb0142d48713a8f65cde678a54f419801c189
in driver-core-next.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/touchscreen/ad7877.c     |   12 +-----------
 drivers/input/touchscreen/ad7879-spi.c |   12 +-----------
 drivers/input/touchscreen/ads7846.c    |   12 +-----------
 drivers/input/touchscreen/tsc2005.c    |   12 +-----------
 4 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 42ae7a2..532d5eb 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -860,17 +860,7 @@ static struct spi_driver ad7877_driver = {
 	.remove		= __devexit_p(ad7877_remove),
 };
 
-static int __init ad7877_init(void)
-{
-	return spi_register_driver(&ad7877_driver);
-}
-module_init(ad7877_init);
-
-static void __exit ad7877_exit(void)
-{
-	spi_unregister_driver(&ad7877_driver);
-}
-module_exit(ad7877_exit);
+module_spi_driver(ad7877_driver);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("AD7877 touchscreen Driver");
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index 9b2e1c2..db49abf 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -157,17 +157,7 @@ static struct spi_driver ad7879_spi_driver = {
 	.remove		= __devexit_p(ad7879_spi_remove),
 };
 
-static int __init ad7879_spi_init(void)
-{
-	return spi_register_driver(&ad7879_spi_driver);
-}
-module_init(ad7879_spi_init);
-
-static void __exit ad7879_spi_exit(void)
-{
-	spi_unregister_driver(&ad7879_spi_driver);
-}
-module_exit(ad7879_spi_exit);
+module_spi_driver(ad7879_spi_driver);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("AD7879(-1) touchscreen SPI bus driver");
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 23fd901..f02028e 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1433,17 +1433,7 @@ static struct spi_driver ads7846_driver = {
 	.remove		= __devexit_p(ads7846_remove),
 };
 
-static int __init ads7846_init(void)
-{
-	return spi_register_driver(&ads7846_driver);
-}
-module_init(ads7846_init);
-
-static void __exit ads7846_exit(void)
-{
-	spi_unregister_driver(&ads7846_driver);
-}
-module_exit(ads7846_exit);
+module_spi_driver(ads7846_driver);
 
 MODULE_DESCRIPTION("ADS7846 TouchScreen Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index cbf0ff3..a7dc23a 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -747,17 +747,7 @@ static struct spi_driver tsc2005_driver = {
 	.remove	= __devexit_p(tsc2005_remove),
 };
 
-static int __init tsc2005_init(void)
-{
-	return spi_register_driver(&tsc2005_driver);
-}
-module_init(tsc2005_init);
-
-static void __exit tsc2005_exit(void)
-{
-	spi_unregister_driver(&tsc2005_driver);
-}
-module_exit(tsc2005_exit);
+module_spi_driver(tsc2005_driver);
 
 MODULE_AUTHOR("Lauri Leukkunen <lauri.leukkunen@nokia.com>");
 MODULE_DESCRIPTION("TSC2005 Touchscreen Driver");
-- 
1.7.8

