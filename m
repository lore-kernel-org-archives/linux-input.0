From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH] Input: TPS6507X - add MFD dependency
Date: Mon, 11 Jul 2011 16:16:24 +0200
Message-ID: <4E1B05B8.1020006@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:56087 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222Ab1GKORB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 10:17:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

touchscreen unit is only working if mfd device is activated, so
define it as dependency. I2C dependency is obsolete, cause
TPS6507X itself depends on it.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/input/touchscreen/Kconfig
===================================================================
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -716,7 +716,7 @@
 
 config TOUCHSCREEN_TPS6507X
 	tristate "TPS6507x based touchscreens"
-	depends on I2C
+	depends on TPS6507X
 	help
 	  Say Y here if you have a TPS6507x based touchscreen
 	  controller.

