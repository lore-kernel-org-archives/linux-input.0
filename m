From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/7] Input: cyttsp - rework Kconfig entries
Date: Mon, 14 Nov 2011 00:15:51 -0800
Message-ID: <20111114081551.10141.84646.stgit@hammer.corenet.prv>
References: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34009 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab1KNIPy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:15:54 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so6951500iag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:15:54 -0800 (PST)
In-Reply-To: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

Rework Kconfig entries to match the style of other drivers supporting
multiple transports: have users select driver core and then appropriate
transport (SPI/I2C) as a sub-option.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/Kconfig |   28 +++++++++++-----------------
 1 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9537404..e377535 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -137,12 +137,12 @@ config TOUCHSCREEN_CY8CTMG110
 	  module will be called cy8ctmg110_ts.
 
 config TOUCHSCREEN_CYTTSP_CORE
-	tristate "Cypress TTSP touchscreen core"
-	depends on INPUT_TOUCHSCREEN
+	tristate "Cypress TTSP touchscreen"
 	help
-          Say Y here if you have a touchscreen interface using one
-          controller from the Cypress TrueTouch(tm) Standard Product
-	  family.
+	  Say Y here if you have a touchscreen using controller from
+	  the Cypress TrueTouch(tm) Standard Product family connected
+	  to your system. You will also need to select appropriate
+	  bus connection below.
 
 	  If unsure, say N.
 
@@ -150,25 +150,19 @@ config TOUCHSCREEN_CYTTSP_CORE
 	  module will be called cyttsp_core.
 
 config TOUCHSCREEN_CYTTSP_I2C
-	tristate "Cypress TTSP i2c touchscreen"
-	depends on I2C && TOUCHSCREEN_CYTTSP_CORE
+	tristate "support I2C bus connection"
+	depends on TOUCHSCREEN_CYTTSP_CORE && I2C
 	help
-	  Say Y here if you have a Cypress TTSP touchscreen
-	  connected to your system with an I2C interface.
-
-	  If unsure, say N.
+	  Say Y here if the touchscreen is connected via I2C bus.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called cyttsp_i2c.
 
 config TOUCHSCREEN_CYTTSP_SPI
-	tristate "Cypress TTSP spi touchscreen"
-	depends on SPI_MASTER && TOUCHSCREEN_CYTTSP_CORE
+	tristate "support SPI bus connection"
+	depends on TOUCHSCREEN_CYTTSP_CORE && SPI_MASTER
 	help
-	  Say Y here if you have a Cypress TTSP touchscreen
-	  connected to your  with an SPI interface.
-
-	  If unsure, say N.
+	  Say Y here if the touchscreen is connected via SPI bus.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called cyttsp_spi.

