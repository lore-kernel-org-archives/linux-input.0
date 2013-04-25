From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] Input: touchscreen: ads7846: add device tree bindings
Date: Thu, 25 Apr 2013 13:33:53 +0200
Message-ID: <1366889633-12577-2-git-send-email-zonque@gmail.com>
References: <1366889633-12577-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:43984 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757606Ab3DYLnl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Apr 2013 07:43:41 -0400
In-Reply-To: <1366889633-12577-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: broonie@kernel.org, grant.likely@linaro.org, dmitry.torokhov@gmail.com, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com, Daniel Mack <zonque@gmail.com>

This patch adds device tree bindings to the ads7846 driver, and
documents the required and optional binding properties.

Successfully tested on an OMAP3 board.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/input/ads7846.txt          |  86 ++++++++++
 drivers/input/touchscreen/ads7846.c                | 189 ++++++++++++++++-----
 2 files changed, 231 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ads7846.txt

diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/ads7846.txt
new file mode 100644
index 0000000..ac564a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ads7846.txt
@@ -0,0 +1,86 @@
+Device tree bindings for TI's ADS7843, ADS7845, ADS7846, ADS7873, TSC2046
+SPI driven touch screen controllers.
+
+The node for this driver must be a child node of a SPI controller, hence
+all mandatory properties described in
+
+	Documentation/devicetree/bindings/spi/spi-bus.txt
+
+must be specified..
+
+Additional required properties:
+
+	compatible		Must be one of the following, depending on the
+				model:
+					"ti,tsc2046"
+					"ti,ads7843"
+					"ti,ads7845"
+					"ti,ads7846"
+					"ti,ads7873"
+
+	interrupt-parent
+	interrupts		An interrupt node describing the IRQ line the chip's
+				!PENIRQ pin is connected to.
+	vcc-supply		A regulator node for the supply voltage.
+
+
+Optional properties:
+
+	ti,vref-delay-usecs		vref supply delay in usecs, 0 for
+					external vref
+	ti,vref-mv			The VREF voltage, in millivolts.
+	ti,keep-vref-on			set to keep vref on for differential
+					measurements as well.
+	ti,swap-xy			swap x and y axis
+	ti,settle-delay-usec		Settling time of the analog signals;
+					a function of Vcc and the capacitance
+					on the X/Y drivers.  If set to non-zero,
+					two samples are taken with settle_delay
+					us apart, and the second one is used.
+					~150 uSec with 0.01uF caps.
+	ti,penirq-recheck-delay-usecs	If set to non-zero, after samples are
+					taken this delay is applied and penirq
+					is rechecked, to help avoid false
+					events.  This value is affected by the
+					material used to build the touch layer.
+	ti,x-plate-ohms			Resistance of the X-plate, in Ohms.
+	ti,y-plate-ohms			Resistance of the Y-plate, in Ohms.
+	ti,x-min			Minimum value on the X axis.
+	ti,y-min			Minimum value on the Y axis.
+	ti,x-max			Maximum value on the X axis.
+	ti,y-max			Minimum value on the Y axis.
+	ti,pressure-min			Minimum reported pressure value (threshold).
+	ti,pressure-max			Maximum reported pressure value.
+	ti,debounce-max			Max number of additional readings per sample.
+	ti,debounce-tol			Tolerance used for filtering.
+	ti,debounce-rep			Additional consecutive good readings
+					required after the first two.
+	ti,pendown-gpio-debounce	Platform specific debounce time for the
+					pendown-gpio.
+	pendown-gpio			GPIO handle describing the pin the !PENIRQ
+					line is connected to.
+	linux,wakeup			use any event on touchscreen as wakeup event.
+
+
+Example for a TSC2046 chip connected to an McSPI controller of an OMAP SoC::
+
+	spi_controller {
+		tsc2046@0 {
+			reg = <0>;	/* CS0 */
+			compatible = "ti,tsc2046";
+			interrupt-parent = <&gpio1>;
+			interrupts = <8 0>;	/* BOOT6 / GPIO 8 */
+			spi-max-frequency = <1000000>;
+			pendown-gpio = <&gpio1 8 0>;
+			vcc-supply = <&reg_vcc3>;
+
+			ti,x-min = <0>;
+			ti,x-max = <8000>;
+			ti,y-min = <0>;
+			ti,y-max = <4800>;
+			ti,x-plate-ohms = <40>;
+			ti,pressure-max = <255>;
+
+			linux,wakeup;
+		};
+	};
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 1c9c83a..31d1879 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -27,6 +27,9 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_device.h>
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
@@ -1202,6 +1205,99 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts)
 	spi_message_add_tail(x, m);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id ads7846_dt_ids[] = {
+	{ .compatible = "ti,tsc2046",	.data = (void *) 7846 },
+	{ .compatible = "ti,ads7843",	.data = (void *) 7843 },
+	{ .compatible = "ti,ads7845",	.data = (void *) 7845 },
+	{ .compatible = "ti,ads7846",	.data = (void *) 7846 },
+	{ .compatible = "ti,ads7873",	.data = (void *) 7873 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads7846_dt_ids);
+
+static int ads7846_probe_dt(struct device *dev, struct ads7846 *ts)
+{
+	const struct of_device_id *match;
+	u32 val;
+
+	match = of_match_device(ads7846_dt_ids, dev);
+	if (!match)
+		return -ENODEV;
+
+	ts->model = (unsigned int) match->data;
+
+	if (of_property_read_u32(dev->of_node, "ti,vref-delay-usecs", &val) == 0)
+		ts->vref_delay_usecs = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,vref-mv", &val) == 0)
+		ts->vref_mv = val;
+
+	if (of_get_property(dev->of_node, "ti,keep-vref-on", NULL))
+		ts->keep_vref_on = true;
+
+	if (of_get_property(dev->of_node, "ti,swap-xy", NULL))
+		ts->swap_xy = true;
+
+	if (of_property_read_u32(dev->of_node, "ti,settle-delay-usec",
+				 &val) == 0)
+		ts->settle_delay_usecs = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,penirq-recheck-delay-usecs",
+				 &val) == 0)
+		ts->penirq_recheck_delay_usecs = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,x-plate-ohms", &val) == 0)
+		ts->x_plate_ohms = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,y-plate-ohms", &val) == 0)
+		ts->y_plate_ohms = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,x-min", &val) == 0)
+		ts->x_min = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,y-min", &val) == 0)
+		ts->y_min = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,x-max", &val) == 0)
+		ts->x_max = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,y-max", &val) == 0)
+		ts->y_max = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,pressure-min", &val) == 0)
+		ts->pressure_min = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,pressure-max", &val) == 0)
+		ts->pressure_max = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,debounce-max", &val) == 0)
+		ts->debounce_max = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,debounce-tol", &val) == 0)
+		ts->debounce_tol = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,debounce-rep", &val) == 0)
+		ts->debounce_rep = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,pendown-gpio-debounce",
+				 &val) == 0)
+		ts->gpio_pendown_debounce = val;
+
+	ts->gpio_pendown = of_get_named_gpio(dev->of_node, "pendown-gpio", 0);
+
+	if (of_get_property(dev->of_node, "linux,wakeup", NULL))
+		ts->wakeup = true;
+
+	return 0;
+}
+#else
+static inline struct ads7846_platform_data ads7846_probe_dt(struct device *dev)
+{
+	return -ENODEV;
+}
+#endif
+
 static int ads7846_probe(struct spi_device *spi)
 {
 	struct ads7846 *ts;
@@ -1216,11 +1312,6 @@ static int ads7846_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	if (!pdata) {
-		dev_dbg(&spi->dev, "no platform data?\n");
-		return -ENODEV;
-	}
-
 	/* don't exceed max specified sample rate */
 	if (spi->max_speed_hz > (125000 * SAMPLE_BITS)) {
 		dev_dbg(&spi->dev, "f(sample) %d KHz?\n",
@@ -1247,39 +1338,52 @@ static int ads7846_probe(struct spi_device *spi)
 	}
 
 	spi_set_drvdata(spi, ts);
-
 	ts->packet = packet;
 	ts->spi = spi;
 	ts->input = input_dev;
-	ts->vref_mv = pdata->vref_mv;
-	ts->swap_xy = pdata->swap_xy;
-
 	mutex_init(&ts->lock);
 	init_waitqueue_head(&ts->wait);
 
-	ts->model = pdata->model;
-	ts->keep_vref_on = pdata->keep_vref_on;
-	ts->swap_xy = pdata->swap_xy;
-	ts->vref_delay_usecs = pdata->vref_delay_usecs;
-	ts->x_plate_ohms = pdata->x_plate_ohms;
-	ts->y_plate_ohms = pdata->y_plate_ohms;
-	ts->x_min = pdata->x_min;
-	ts->x_max = pdata->x_max;
-	ts->y_min = pdata->y_min;
-	ts->y_max = pdata->y_max;
-	ts->pressure_min = pdata->pressure_min;
-	ts->pressure_max = pdata->pressure_max;
-	ts->debounce_max = pdata->debounce_max;
-	ts->debounce_tol = pdata->debounce_tol;
-	ts->debounce_rep = pdata->debounce_rep;
-	ts->gpio_pendown = pdata->gpio_pendown;
-	ts->gpio_pendown_debounce = pdata->gpio_pendown_debounce;
-	ts->penirq_recheck_delay_usecs = pdata->penirq_recheck_delay_usecs;
-	ts->filter = pdata->filter;
-	ts->filter_cleanup = pdata->filter_cleanup;
-	ts->wait_for_sync = pdata->wait_for_sync;
-	ts->wakeup = pdata->wakeup;
-	ts->irq_flags = pdata->irq_flags;
+	if (pdata) {
+		ts->vref_mv = pdata->vref_mv;
+		ts->swap_xy = pdata->swap_xy;
+		ts->model = pdata->model;
+		ts->keep_vref_on = pdata->keep_vref_on;
+		ts->swap_xy = pdata->swap_xy;
+		ts->vref_delay_usecs = pdata->vref_delay_usecs;
+		ts->x_plate_ohms = pdata->x_plate_ohms;
+		ts->y_plate_ohms = pdata->y_plate_ohms;
+		ts->x_min = pdata->x_min;
+		ts->x_max = pdata->x_max;
+		ts->y_min = pdata->y_min;
+		ts->y_max = pdata->y_max;
+		ts->pressure_min = pdata->pressure_min;
+		ts->pressure_max = pdata->pressure_max;
+		ts->debounce_max = pdata->debounce_max;
+		ts->debounce_tol = pdata->debounce_tol;
+		ts->debounce_rep = pdata->debounce_rep;
+		ts->gpio_pendown = pdata->gpio_pendown;
+		ts->gpio_pendown_debounce = pdata->gpio_pendown_debounce;
+		ts->penirq_recheck_delay_usecs = pdata->penirq_recheck_delay_usecs;
+		ts->filter = pdata->filter;
+		ts->filter_cleanup = pdata->filter_cleanup;
+		ts->wait_for_sync = pdata->wait_for_sync;
+		ts->wakeup = pdata->wakeup;
+		ts->irq_flags = pdata->irq_flags;
+
+		if (pdata->filter && pdata->filter_init) {
+			err = pdata->filter_init(pdata, &ts->filter_data);
+			if (err < 0)
+				goto err_free_mem;
+		}
+	} else {
+		err = ads7846_probe_dt(&spi->dev, ts);
+		if (err < 0) {
+			dev_dbg(&spi->dev, "no platform data and no DT match?\n");
+			err = -ENODEV;
+			goto err_free_mem;
+		}
+	}
 
 	if (ts->model == 0)
 		ts->model = 7846;
@@ -1296,19 +1400,15 @@ static int ads7846_probe(struct spi_device *spi)
 	if (ts->wait_for_sync == NULL)
 		ts->wait_for_sync = null_wait_for_sync;
 
-	if (pdata->filter != NULL) {
-		if (pdata->filter_init != NULL) {
-			err = pdata->filter_init(pdata, &ts->filter_data);
-			if (err < 0)
-				goto err_free_mem;
+	if (ts->filter == NULL) {
+		if (ts->debounce_max) {
+			if (ts->debounce_max < 2)
+				ts->debounce_max = 2;
+			ts->filter = ads7846_debounce_filter;
+			ts->filter_data = ts;
+		} else {
+			ts->filter = ads7846_no_filter;
 		}
-	} else if (ts->debounce_max) {
-		if (ts->debounce_max < 2)
-			ts->debounce_max = 2;
-		ts->filter = ads7846_debounce_filter;
-		ts->filter_data = ts;
-	} else {
-		ts->filter = ads7846_no_filter;
 	}
 
 	err = ads7846_setup_pendown(spi, ts);
@@ -1461,6 +1561,7 @@ static struct spi_driver ads7846_driver = {
 		.name	= "ads7846",
 		.owner	= THIS_MODULE,
 		.pm	= &ads7846_pm,
+		.of_match_table = of_match_ptr(ads7846_dt_ids),
 	},
 	.probe		= ads7846_probe,
 	.remove		= ads7846_remove,
-- 
1.8.1.4

