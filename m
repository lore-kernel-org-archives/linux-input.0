From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH] Input: TPS6507X - define MFD dependencies for touch and regulator
 unit
Date: Mon, 11 Jul 2011 12:50:19 +0200
Message-ID: <4E1AD56B.6080306@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de, yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:48271 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab1GKLVu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 07:21:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

both touchscreen and regulator units are only working if
mfd device is activated. So if mfd support is enabled,
select TPS6507X mfd support automatically.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/input/touchscreen/Kconfig |    3 ++-
 drivers/regulator/Kconfig         |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/input/touchscreen/Kconfig
===================================================================
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -716,7 +716,8 @@
 
 config TOUCHSCREEN_TPS6507X
 	tristate "TPS6507x based touchscreens"
-	depends on I2C
+	depends on I2C && MFD_SUPPORT
+	select TPS6507X
 	help
 	  Say Y here if you have a TPS6507x based touchscreen
 	  controller.
Index: b/drivers/regulator/Kconfig
===================================================================
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -242,7 +242,8 @@
 
 config REGULATOR_TPS6507X
 	tristate "TI TPS6507X Power regulators"
-	depends on I2C
+	depends on I2C && MFD_SUPPORT
+	select TPS6507X
 	help
 	  This driver supports TPS6507X voltage regulator chips. TPS6507X provides
 	  three step-down converters and two general-purpose LDO voltage regulators.

