From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH 6/7] input: use module_spi_driver in misc spi drivers
Date: Mon, 19 Dec 2011 22:23:24 +0800
Message-ID: <1324304605-18193-7-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40758 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab1LSOZA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Dec 2011 09:25:00 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so8615511iae.19
        for <linux-input@vger.kernel.org>; Mon, 19 Dec 2011 06:25:00 -0800 (PST)
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
 drivers/input/misc/ad714x-spi.c  |   12 +-----------
 drivers/input/misc/adxl34x-spi.c |   12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index 875b508..75f6136 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -123,17 +123,7 @@ static struct spi_driver ad714x_spi_driver = {
 	.remove		= __devexit_p(ad714x_spi_remove),
 };
 
-static __init int ad714x_spi_init(void)
-{
-	return spi_register_driver(&ad714x_spi_driver);
-}
-module_init(ad714x_spi_init);
-
-static __exit void ad714x_spi_exit(void)
-{
-	spi_unregister_driver(&ad714x_spi_driver);
-}
-module_exit(ad714x_spi_exit);
+module_spi_driver(ad714x_spi_driver);
 
 MODULE_DESCRIPTION("Analog Devices AD714X Capacitance Touch Sensor SPI Bus Driver");
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
index 34d401e..820a802 100644
--- a/drivers/input/misc/adxl34x-spi.c
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -129,17 +129,7 @@ static struct spi_driver adxl34x_driver = {
 	.remove  = __devexit_p(adxl34x_spi_remove),
 };
 
-static int __init adxl34x_spi_init(void)
-{
-	return spi_register_driver(&adxl34x_driver);
-}
-module_init(adxl34x_spi_init);
-
-static void __exit adxl34x_spi_exit(void)
-{
-	spi_unregister_driver(&adxl34x_driver);
-}
-module_exit(adxl34x_spi_exit);
+module_spi_driver(adxl34x_driver);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("ADXL345/346 Three-Axis Digital Accelerometer SPI Bus Driver");
-- 
1.7.8

