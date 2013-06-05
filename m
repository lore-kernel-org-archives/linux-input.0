From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 06/22] input/ti_am33x_tsc: Add DT support
Date: Wed,  5 Jun 2013 18:24:39 +0200
Message-ID: <1370449495-29981-7-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>

Add DT support for client touchscreen driver

[ panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org : use of_get_child_by_name
	instead of of_find_node_by_name ]

Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
[ bigeasy: shift the code to the left, shirnk titsc_parse_dt() by not
           using temp value, change a binding and document them in
	   ti-tsc-adc.txt which also contains ADC binding which will be
	   used later]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 .../bindings/input/touchscreen/ti-tsc-adc.txt      |   44 +++++++++
 drivers/input/touchscreen/ti_am335x_tsc.c          |  102 +++++++++++++++-----
 2 files changed, 123 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
new file mode 100644
index 0000000..491c97b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
@@ -0,0 +1,44 @@
+* TI - TSC ADC (Touschscreen and analog digital converter)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Required properties:
+- child "tsc"
+	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
+		  support on the platform.
+	ti,x-plate-resistance: X plate resistance
+	ti,coordiante-readouts: The sequencer supports a total of 16
+				programmable steps each step is used to
+				read a single coordinate. A single
+                                readout is enough but multiple reads can
+				increase the quality.
+				A value of 5 means, 5 reads for X, 5 for
+				Y and 2 for Z (always). This utilises 12
+				of the 16 software steps available. The
+				remaining 4 can be used by the ADC.
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
+	ti,adc-channels: List of analog inputs available for ADC.
+			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
+
+Example:
+	tscadc: tscadc@44e0d000 {
+		compatible = "ti,am3359-tscadc";
+		tsc {
+			ti,wires = <4>;
+			ti,x-plate-resistance = <200>;
+			ti,coordiante-readouts = <5>;
+			ti,wire-config = <0x00 0x11 0x22 0x33>;
+		};
+
+		adc {
+			ti,adc-channels = <4 5 6 7>;
+		};
+	}
diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index b2f8a46..c876385 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -26,6 +26,8 @@
 #include <linux/io.h>
 #include <linux/input/ti_am335x_tsc.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 
@@ -47,7 +49,7 @@ struct titsc {
 	unsigned int		wires;
 	unsigned int		x_plate_resistance;
 	bool			pen_down;
-	int			steps_to_configure;
+	int			coordiante_readouts;
 	u32			config_inp[4];
 	u32			bit_xp, bit_xn, bit_yp, bit_yn;
 	u32			inp_xp, inp_xn, inp_yp, inp_yn;
@@ -123,7 +125,7 @@ static void titsc_step_config(struct titsc *ts_dev)
 	int i, total_steps;
 
 	/* Configure the Step registers */
-	total_steps = 2 * ts_dev->steps_to_configure;
+	total_steps = 2 * ts_dev->coordiante_readouts;
 
 	config = STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | ts_dev->bit_xp;
@@ -141,7 +143,7 @@ static void titsc_step_config(struct titsc *ts_dev)
 		break;
 	}
 
-	for (i = 1; i <= ts_dev->steps_to_configure; i++) {
+	for (i = 1; i <= ts_dev->coordiante_readouts; i++) {
 		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
 		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
@@ -163,7 +165,7 @@ static void titsc_step_config(struct titsc *ts_dev)
 		break;
 	}
 
-	for (i = (ts_dev->steps_to_configure + 1); i <= total_steps; i++) {
+	for (i = (ts_dev->coordiante_readouts + 1); i <= total_steps; i++) {
 		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
 		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
@@ -218,7 +220,7 @@ static void titsc_read_coordinates(struct titsc *ts_dev,
 		read = titsc_readl(ts_dev, REG_FIFO0);
 		channel = read & 0xf0000;
 		channel = channel >> 0x10;
-		if ((channel >= 0) && (channel < ts_dev->steps_to_configure)) {
+		if ((channel >= 0) && (channel < ts_dev->coordiante_readouts)) {
 			read &= 0xfff;
 			diff = abs(read - prev_val_x);
 			if (diff < prev_diff_x) {
@@ -231,8 +233,8 @@ static void titsc_read_coordinates(struct titsc *ts_dev,
 		read = titsc_readl(ts_dev, REG_FIFO1);
 		channel = read & 0xf0000;
 		channel = channel >> 0x10;
-		if ((channel >= ts_dev->steps_to_configure) &&
-			(channel < (2 * ts_dev->steps_to_configure - 1))) {
+		if ((channel >= ts_dev->coordiante_readouts) &&
+			(channel < (2 * ts_dev->coordiante_readouts - 1))) {
 			read &= 0xfff;
 			diff = abs(read - prev_val_y);
 			if (diff < prev_diff_y) {
@@ -310,6 +312,62 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
+					struct titsc *ts_dev)
+{
+	struct device_node *node = tscadc_dev->dev->of_node;
+	int err;
+
+	if (!node)
+		return -EINVAL;
+
+	node = of_get_child_by_name(node, "tsc");
+	if (!node)
+		return -EINVAL;
+	err = of_property_read_u32(node, "ti,wires", &ts_dev->wires);
+	if (err < 0)
+		return err;
+	switch (ts_dev->wires) {
+	case 4:
+	case 5:
+	case 8:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32(node, "ti,x-plate-resistance",
+			&ts_dev->x_plate_resistance);
+	if (err < 0)
+		return err;
+
+	err = of_property_read_u32(node, "ti,coordiante-readouts",
+			&ts_dev->coordiante_readouts);
+	if (err < 0)
+		return err;
+
+	return of_property_read_u32_array(node, "ti,wire-config",
+			ts_dev->config_inp, ARRAY_SIZE(ts_dev->config_inp));
+}
+
+static int titsc_parse_pdata(struct ti_tscadc_dev *tscadc_dev,
+					struct titsc *ts_dev)
+{
+	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
+
+	if (!pdata)
+		return -EINVAL;
+
+	ts_dev->wires = pdata->tsc_init->wires;
+	ts_dev->x_plate_resistance =
+		pdata->tsc_init->x_plate_resistance;
+	ts_dev->steps_to_configure =
+		pdata->tsc_init->steps_to_configure;
+	memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
+		sizeof(pdata->tsc_init->wire_config));
+	return 0;
+}
+
 /*
  * The functions for inserting/removing driver as a module.
  */
@@ -319,16 +377,8 @@ static int titsc_probe(struct platform_device *pdev)
 	struct titsc *ts_dev;
 	struct input_dev *input_dev;
 	struct ti_tscadc_dev *tscadc_dev = ti_tscadc_dev_get(pdev);
-	struct mfd_tscadc_board	*pdata;
 	int err;
 
-	pdata = tscadc_dev->dev->platform_data;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "Could not find platform data\n");
-		return -EINVAL;
-	}
-
 	/* Allocate memory for device */
 	ts_dev = kzalloc(sizeof(struct titsc), GFP_KERNEL);
 	input_dev = input_allocate_device();
@@ -342,11 +392,17 @@ static int titsc_probe(struct platform_device *pdev)
 	ts_dev->mfd_tscadc = tscadc_dev;
 	ts_dev->input = input_dev;
 	ts_dev->irq = tscadc_dev->irq;
-	ts_dev->wires = pdata->tsc_init->wires;
-	ts_dev->x_plate_resistance = pdata->tsc_init->x_plate_resistance;
-	ts_dev->steps_to_configure = pdata->tsc_init->steps_to_configure;
-	memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
-			sizeof(pdata->tsc_init->wire_config));
+
+	if (tscadc_dev->dev->platform_data)
+		err = titsc_parse_pdata(tscadc_dev, ts_dev);
+	else
+		err = titsc_parse_dt(tscadc_dev, ts_dev);
+
+	if (err) {
+		dev_err(&pdev->dev, "Could not find platform data\n");
+		err = -EINVAL;
+		goto err_free_mem;
+	}
 
 	err = request_irq(ts_dev->irq, titsc_irq,
 			  0, pdev->dev.driver->name, ts_dev);
@@ -362,7 +418,7 @@ static int titsc_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 	titsc_step_config(ts_dev);
-	titsc_writel(ts_dev, REG_FIFO0THR, ts_dev->steps_to_configure);
+	titsc_writel(ts_dev, REG_FIFO0THR, ts_dev->coordiante_readouts);
 
 	input_dev->name = "ti-tsc";
 	input_dev->dev.parent = &pdev->dev;
@@ -398,7 +454,7 @@ static int titsc_remove(struct platform_device *pdev)
 	free_irq(ts_dev->irq, ts_dev);
 
 	/* total steps followed by the enable mask */
-	steps = 2 * ts_dev->steps_to_configure + 2;
+	steps = 2 * ts_dev->coordiante_readouts + 2;
 	steps = (1 << steps) - 1;
 	am335x_tsc_se_clr(ts_dev->mfd_tscadc, steps);
 
@@ -439,7 +495,7 @@ static int titsc_resume(struct device *dev)
 	}
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
-			ts_dev->steps_to_configure);
+			ts_dev->coordiante_readouts);
 	return 0;
 }
 
-- 
1.7.10.4
