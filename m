From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] Input: ads7846 - add support for AD7843 parts
Date: Tue,  9 Mar 2010 10:00:55 -0500
Message-ID: <1268146855-15835-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:49609 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab0CIO5j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 09:57:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

The AD7873 is almost identical to the ADS7846; the only difference is
related to the Power Management bits PD0 and PD1.  This results in a
slightly different PENIRQ enable behavior.  For the AD7873, VREF should
be turned off during differential measurements.

So, add the AD7873/43 to the list of driver supported devices, and prevent
VREF usage during differential/ratiometric conversion modes.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/input/touchscreen/Kconfig   |    9 +++++----
 drivers/input/touchscreen/ads7846.c |   10 ++++++++++
 include/linux/spi/ads7846.h         |    2 +-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 480c9ac..1bc5184 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -24,17 +24,18 @@ config TOUCHSCREEN_88PM860X
 	  module will be called 88pm860x-ts.
 
 config TOUCHSCREEN_ADS7846
-	tristate "ADS7846/TSC2046 and ADS7843 based touchscreens"
+	tristate "ADS7846/TSC2046/AD7873 and AD(S)7843 based touchscreens"
 	depends on SPI_MASTER
 	depends on HWMON = n || HWMON
 	help
 	  Say Y here if you have a touchscreen interface using the
-	  ADS7846/TSC2046 or ADS7843 controller, and your board-specific
-	  setup code includes that in its table of SPI devices.
+	  ADS7846/TSC2046/AD7873 or ADS7843/AD7843 controller,
+	  and your board-specific setup code includes that in its
+	  table of SPI devices.
 
 	  If HWMON is selected, and the driver is told the reference voltage
 	  on your board, you will also get hwmon interfaces for the voltage
-	  (and on ads7846/tsc2046, temperature) sensors of this chip.
+	  (and on ads7846/tsc2046/ad7873, temperature) sensors of this chip.
 
 	  If unsure, say N (but it's safe to say "Y").
 
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 8b05d8e..d187be0 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -36,6 +36,7 @@
  * TSC2046 is just newer ads7846 silicon.
  * Support for ads7843 tested on Atmel at91sam926x-EK.
  * Support for ads7845 has only been stubbed in.
+ * Support for Analog Devices AD7873 and AD7843 tested.
  *
  * IRQ handling needs a workaround because of a shortcoming in handling
  * edge triggered IRQs on some platforms like the OMAP1/2. These
@@ -984,6 +985,15 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 
 	vref = pdata->keep_vref_on;
 
+	if (ts->model == 7873) {
+		/* The AD7873 is almost identical to the ADS7846
+		 * keep VREF off during differential/ratiometric
+		 * conversion modes
+		 */
+		ts->model = 7846;
+		vref = 0;
+	}
+
 	/* set up the transfers to read touchscreen state; this assumes we
 	 * use formula #2 for pressure, not #3.
 	 */
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index 51948eb..5710c15 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -12,7 +12,7 @@ enum ads7846_filter {
 };
 
 struct ads7846_platform_data {
-	u16	model;			/* 7843, 7845, 7846. */
+	u16	model;			/* 7843, 7845, 7846, 7873. */
 	u16	vref_delay_usecs;	/* 0 for external vref; etc */
 	u16	vref_mv;		/* external vref value, milliVolts */
 	bool	keep_vref_on;		/* set to keep vref on for differential
-- 
1.7.0.2

