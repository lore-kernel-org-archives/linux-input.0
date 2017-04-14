From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH v2] input: touchscreen: ar1021_i2c: highlight support for AR1020
Date: Fri, 14 Apr 2017 08:02:56 +0200
Message-ID: <1492149776-14696-1-git-send-email-martin.kepplinger@ginzinger.com>
References: <20170413203532.thktt4yhqsg34cvc@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:57387 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdDNGDH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Apr 2017 02:03:07 -0400
In-Reply-To: <20170413203532.thktt4yhqsg34cvc@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh@kernel.org, dmitry.torokhov@gmail.com
Cc: christian.gmeiner@gmail.com, linux@roeck-us.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>

ar1021_i2c simply also supports the ar1020 device I'm using. This is
tested. They also share the same datasheet:

   http://ww1.microchip.com/downloads/en/DeviceDoc/40001393C.pdf

So let users see that they have a compatible in front of them by adding
AR1020 to the driver's description.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

revision history
----------------
v2: leave compatible string untouched. only add description.
v1: initial idea.


 drivers/input/touchscreen/Kconfig      | 4 ++--
 drivers/input/touchscreen/ar1021_i2c.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 33c62e5..535b91a 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -96,8 +96,8 @@ config TOUCHSCREEN_AR1021_I2C
 	tristate "Microchip AR1021 i2c touchscreen"
 	depends on I2C && OF
 	help
-	  Say Y here if you have the Microchip AR1021 touchscreen controller
-	  chip in your system.
+	  Say Y here if you have the Microchip AR1020 or AR1021 touchscreen
+	  controller chip in your system.
 
 	  If unsure, say N.
 
diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index 2e7500e..03784d2 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -1,5 +1,5 @@
 /*
- * Microchip AR1021 driver for I2C
+ * Microchip AR1020 and AR1021 driver for I2C
  *
  * Author: Christian Gmeiner <christian.gmeiner@gmail.com>
  *
@@ -175,5 +175,5 @@ static struct i2c_driver ar1021_i2c_driver = {
 module_i2c_driver(ar1021_i2c_driver);
 
 MODULE_AUTHOR("Christian Gmeiner <christian.gmeiner@gmail.com>");
-MODULE_DESCRIPTION("Microchip AR1021 I2C Driver");
+MODULE_DESCRIPTION("Microchip AR1020 and AR1021 I2C Driver");
 MODULE_LICENSE("GPL");
-- 
2.1.4

