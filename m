From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: Enable WM97xx touchscreen sub-drivers by default
Date: Thu, 24 Jul 2008 14:41:07 +0100
Message-ID: <1216906867-5058-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1216905308-4723-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58094 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751014AbYGXNlJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jul 2008 09:41:09 -0400
In-Reply-To: <1216905308-4723-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Currently the support for each WM97xx touchscreen model is compiled out
by default, meaning that the default configuration when the driver is
built is for it to support no hardware.  This is suboptimal and leads to
problems like distribution kernels shipping a non-functional driver.

Change the default to support all controllers and update the help text
to reflect this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Resubmit, after proofreading.

 drivers/input/touchscreen/Kconfig |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index e573665..7606120 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -237,29 +237,26 @@ config TOUCHSCREEN_WM97XX
 config TOUCHSCREEN_WM9705
 	bool "WM9705 Touchscreen interface support"
 	depends on TOUCHSCREEN_WM97XX
+	default y
 	help
-	  Say Y here if you have a Wolfson Microelectronics WM9705
-	  touchscreen controller connected to your system.
-
-	  If unsure, say N.
+	  Say Y here to enable support for the Wolfson Microelectronics
+	  WM9705 touchscreen controller.
 
 config TOUCHSCREEN_WM9712
 	bool "WM9712 Touchscreen interface support"
 	depends on TOUCHSCREEN_WM97XX
+	default y
 	help
-	  Say Y here if you have a Wolfson Microelectronics WM9712
-	  touchscreen controller connected to your system.
-
-	  If unsure, say N.
+	  Say Y here to enable support for the Wolfson Microelectronics
+	  WM9712 touchscreen controller.
 
 config TOUCHSCREEN_WM9713
 	bool "WM9713 Touchscreen interface support"
 	depends on TOUCHSCREEN_WM97XX
+	default y
 	help
-	  Say Y here if you have a Wolfson Microelectronics WM9713 touchscreen
-	  controller connected to your system.
-
-	  If unsure, say N.
+	  Say Y here to enable support for the Wolfson Microelectronics
+	  WM9713 touchscreen controller.
 
 config TOUCHSCREEN_WM97XX_MAINSTONE
 	tristate "WM97xx Mainstone accelerated touch"
-- 
1.5.6.3

