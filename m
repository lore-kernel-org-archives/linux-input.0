From: Tatsunosuke Tobita <junkpainting@gmail.com>
Subject: [PATCH] Input: Modified on Kconfig and Makefile for adding  Wacom Stylus for I2C
Date: Wed, 19 Oct 2011 15:35:49 +0900
Message-ID: <1319006149-8600-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38515 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab1JSGgH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Oct 2011 02:36:07 -0400
Received: by yxp4 with SMTP id 4so1365393yxp.19
        for <linux-input@vger.kernel.org>; Tue, 18 Oct 2011 23:36:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>


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

