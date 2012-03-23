From: Tatsunosuke Tobita <junkpainting@gmail.com>
Subject: [PATCH] Input:Add support for Wacom Stylus with I2C interface.
Date: Fri, 23 Mar 2012 14:38:45 +0900
Message-ID: <1332481125-6194-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51281 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab2CWFjD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Mar 2012 01:39:03 -0400
Received: by yenl12 with SMTP id l12so2462680yen.19
        for <linux-input@vger.kernel.org>; Thu, 22 Mar 2012 22:39:03 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

This modification sets up for adding support for Wacom I2C Stylus Device.

Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
---
 drivers/input/touchscreen/Kconfig  |   11 +++++++++++
 drivers/input/touchscreen/Makefile |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 3488ffe..cae448e 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -738,4 +738,15 @@ config TOUCHSCREEN_TPS6507X
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
index f957676..61bbfc8 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
+obj-$(CONFIG_TOUCHSCREEN_WACOM_I2C)	+= wacom_i2c.o
-- 
1.7.1

