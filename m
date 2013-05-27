From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 14/19] Documentation/DT bindings: add info for TI TSC ADC
Date: Mon, 27 May 2013 21:12:01 +0200
Message-ID: <1369681926-22185-15-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The platform data structs are killed here because there are no users in
tree (nobody sets the structs up, the RO usage is beeing removed) and the
documentation about the parameters is saved here.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 .../bindings/input/touchscreen/ti-tsc-adc.txt      |   38 ++++++++++++++++++++
 include/linux/input/ti_am335x_tsc.h                |   35 ------------------
 include/linux/mfd/ti_am335x_tscadc.h               |    5 ---
 include/linux/platform_data/ti_am335x_adc.h        |   14 --------
 4 files changed, 38 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
 delete mode 100644 include/linux/input/ti_am335x_tsc.h
 delete mode 100644 include/linux/platform_data/ti_am335x_adc.h

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
new file mode 100644
index 0000000..e533e9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
@@ -0,0 +1,38 @@
+* TI - TSC ADC (Touschscreen and analog digital converter)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Required properties:
+- child "tsc"
+	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
+		  support on the platform.
+	ti,x-plate-resistance: X plate resistance
+	ti,steps-to-configure: The sequencer supports a total of 16
+			       programmable steps. A step configured to read a
+			       single co-ordinate value. Can be applied more
+			       number of times for better results.
+	ti,wire-config: Different boards could have a different order for
+			connecting wires on touchscreen. We need to provide an
+			8 bit number where in the 1st four bits represent the
+			analog lines and the next 4 bits represent positive/
+			negative terminal on that input line. Notations to
+			represent the input lines and terminals resoectively
+			is as follows:
+			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
+			XP  = 0, XN = 1, YP = 2, YN = 3.
+- child "adc"
+	ti,adc-channels: Number of analog inputs available for ADC
+
+Example:
+	tscadc: tscadc@44e0d000 {
+		compatible = "ti,ti-tscadc";
+		tsc {
+			ti,wires = <4>;
+			ti,x-plate-resistance = <200>;
+			ti,steps-to-configure = <5>;
+			ti,wire-config = <0x00 0x11 0x22 0x33>;
+		};
+
+		adc {
+			ti,adc-channels = <4>;
+		};
+	}
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
index 50a245f..c985262 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -128,11 +128,6 @@
 
 #define TSCADC_CELLS		2
 
-struct mfd_tscadc_board {
-	struct tsc_data *tsc_init;
-	struct adc_data *adc_init;
-};
-
 struct ti_tscadc_dev {
 	struct device *dev;
 	struct regmap *regmap_tscadc;
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
