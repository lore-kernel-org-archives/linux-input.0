From: Tatsunosuke Tobita <junkpainting@gmail.com>
Subject: [PATCH] Input:Modification on Kconfig&Makefile
Date: Mon,  3 Oct 2011 17:26:55 +0900
Message-ID: <1317630415-2449-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:37998 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab1JCI1T (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2011 04:27:19 -0400
Received: by pzk1 with SMTP id 1so11169122pzk.1
        for <linux-input@vger.kernel.org>; Mon, 03 Oct 2011 01:27:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

Modify Kconfig&Makefile for Wacom Stylus I2C support

Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
---
 drivers/input/touchscreen/Kconfig  |   11 +++++++++++
 drivers/input/touchscreen/Makefile |    2 ++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index cabd9e5..ac7b08e 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -726,4 +726,15 @@ config TOUCHSCREEN_TPS6507X
 	  To compile this driver as a module, choose M here: the
 	  module will be called tps6507x_ts.
 
+config TOUCHSCREEN_WACOM_I2C
+	tristate "Wacom Tablet support(I2C)"
+	depends on I2C
+	help
+	 Say Y here if you want to use the I2C version of the Wacom Pen.
+	 Make sure to say Y to "Mouse support" (CONFIG_INPUT_MOUSEDEV)
+	 and/or "Event interface support" (CONFIG_INPUT_EVDEV) as well.
+
+	 To compile this driver as a module, choose M here: the module
+	 will be called wacom_i2c.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 282d6f7..c2b683b 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -5,6 +5,7 @@
 # Each configuration option enables a list of files.
 
 wm97xx-ts-y := wm97xx-core.o
+wacom_i2c-ts-objs := wacom_i2c_func.o wacom_i2c.o
 
 obj-$(CONFIG_TOUCHSCREEN_88PM860X)	+= 88pm860x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_AD7877)	+= ad7877.o
@@ -60,3 +61,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
+obj-$(CONFIG_TOUCHSCREEN_WACOM_I2C)	+= wacom_i2c-ts.o
-- 
1.7.1

