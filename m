From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 15/22] input & mfd: ti_am335x_tsc remove remaining platform data pieces
Date: Wed,  5 Jun 2013 18:24:48 +0200
Message-ID: <1370449495-29981-16-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35253 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3FEQ1D (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jun 2013 12:27:03 -0400
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The two header files removed here are unused and have no users as this
platform was never used with platform devices.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/input/ti_am335x_tsc.h         |   35 ---------------------------
 include/linux/mfd/ti_am335x_tscadc.h        |    5 ----
 include/linux/platform_data/ti_am335x_adc.h |   14 -----------
 3 files changed, 54 deletions(-)
 delete mode 100644 include/linux/input/ti_am335x_tsc.h
 delete mode 100644 include/linux/platform_data/ti_am335x_adc.h

diff --git a/include/linux/input/ti_am335x_tsc.h b/include/linux/input/ti_am335x_tsc.h
deleted file mode 100644
index 6a66b4d..0000000
--- a/include/linux/input/ti_am335x_tsc.h
+++ /dev/null
@@ -1,35 +0,0 @@
-#ifndef __LINUX_TI_AM335X_TSC_H
-#define __LINUX_TI_AM335X_TSC_H
-
-/**
- * struct tsc_data	Touchscreen wire configuration
- * @wires:		Wires refer to application modes
- *			i.e. 4/5/8 wire touchscreen support
- *			on the platform.
- * @x_plate_resistance:	X plate resistance.
- * @steps_to_configure:	The sequencer supports a total of
- *			16 programmable steps.
- *			A step configured to read a single
- *			co-ordinate value, can be applied
- *			more number of times for better results.
- * @wire_config:	Different EVM's could have a different order
- *			for connecting wires on touchscreen.
- *			We need to provide an 8 bit number where in
- *			the 1st four bits represent the analog lines
- *			and the next 4 bits represent positive/
- *			negative terminal on that input line.
- *			Notations to represent the input lines and
- *			terminals resoectively is as follows:
- *			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
- *			XP  = 0, XN = 1, YP = 2, YN = 3.
- *
- */
-
-struct tsc_data {
-	int wires;
-	int x_plate_resistance;
-	int steps_to_configure;
-	int wire_config[10];
-};
-
-#endif
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index b6e7ac6..cd8686b 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -127,11 +127,6 @@
 
 #define TSCADC_CELLS		2
 
-struct mfd_tscadc_board {
-	struct tsc_data *tsc_init;
-	struct adc_data *adc_init;
-};
-
 struct ti_tscadc_dev {
 	struct device *dev;
 	void __iomem *tscadc_base;
diff --git a/include/linux/platform_data/ti_am335x_adc.h b/include/linux/platform_data/ti_am335x_adc.h
deleted file mode 100644
index e41d583..0000000
--- a/include/linux/platform_data/ti_am335x_adc.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef __LINUX_TI_AM335X_ADC_H
-#define __LINUX_TI_AM335X_ADC_H
-
-/**
- * struct adc_data	ADC Input information
- * @adc_channels:	Number of analog inputs
- *			available for ADC.
- */
-
-struct adc_data {
-	unsigned int adc_channels;
-};
-
-#endif
-- 
1.7.10.4

