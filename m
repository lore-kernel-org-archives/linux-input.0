From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] Input: ADP5588: add support for ADP5587 devices
Date: Mon, 18 Jan 2010 23:52:52 -0500
Message-ID: <1263876772-6502-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:43844 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932122Ab0ASEwm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 23:52:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

The ADP5587 is quite similar to the ADP5588 but features a greater I/O
voltage range and lacks the Dual Light Sensor Interface.  This new part
is also supported by this driver.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/input/keyboard/Kconfig        |    4 ++--
 drivers/input/keyboard/adp5588-keys.c |    6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 02c836e..c72283c 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -35,10 +35,10 @@ config KEYBOARD_ADP5520
 	  be called adp5520-keys.
 
 config KEYBOARD_ADP5588
-	tristate "ADP5588 I2C QWERTY Keypad and IO Expander"
+	tristate "ADP5588/87 I2C QWERTY Keypad and IO Expander"
 	depends on I2C
 	help
-	  Say Y here if you want to use a ADP5588 attached to your
+	  Say Y here if you want to use a ADP5588/87 attached to your
 	  system I2C bus.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 1edb596..b5142d2 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -1,6 +1,7 @@
 /*
  * File: drivers/input/keyboard/adp5588_keys.c
- * Description:  keypad driver for ADP5588 I2C QWERTY Keypad and IO Expander
+ * Description:  keypad driver for ADP5588 and ADP5587
+ *		 I2C QWERTY Keypad and IO Expander
  * Bugs: Enter bugs at http://blackfin.uclinux.org/
  *
  * Copyright (C) 2008-2009 Analog Devices Inc.
@@ -327,6 +328,7 @@ static const struct dev_pm_ops adp5588_dev_pm_ops = {
 
 static const struct i2c_device_id adp5588_id[] = {
 	{ KBUILD_MODNAME, 0 },
+	{ "adp5587-keys", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adp5588_id);
@@ -357,5 +359,5 @@ module_exit(adp5588_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("ADP5588 Keypad driver");
+MODULE_DESCRIPTION("ADP5588/87 Keypad driver");
 MODULE_ALIAS("platform:adp5588-keys");
-- 
1.6.6

