From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH RESEND v2 2/2] Input: touchscreen: ads7846: add device tree bindings
Date: Wed, 22 May 2013 19:58:00 +0200
Message-ID: <1369245480-18595-2-git-send-email-zonque@gmail.com>
References: <1369245480-18595-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:47892 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303Ab3EVR5p (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 May 2013 13:57:45 -0400
In-Reply-To: <1369245480-18595-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: broonie@kernel.org, grant.likely@linaro.org, dmitry.torokhov@gmail.com, agust@denx.de, chf@fritzc.com, Daniel Mack <zonque@gmail.com>

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/input/ads7846.txt          |  86 ++++++++++++++++
 drivers/input/touchscreen/ads7846.c                | 109 ++++++++++++++++++++-
 2 files changed, 194 insertions(+), 1 deletion(-)
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
index 198677d..b78354b 100644
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
@@ -1201,12 +1204,110 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
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
+static struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
+{
+	struct ads7846_platform_data *pdata = NULL;
+	const struct of_device_id *match;
+	u32 val;
+
+	match = of_match_device(ads7846_dt_ids, dev);
+	if (!match)
+		return NULL;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->model = (unsigned int) match->data;
+
+	if (of_property_read_u32(dev->of_node, "ti,vref-delay-usecs", &val) == 0)
+		pdata->vref_delay_usecs = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,vref-mv", &val) == 0)
+		pdata->vref_mv = val;
+
+	if (of_get_property(dev->of_node, "ti,keep-vref-on", NULL))
+		pdata->keep_vref_on = true;
+
+	if (of_get_property(dev->of_node, "ti,swap-xy", NULL))
+		pdata->swap_xy = true;
+
+	if (of_property_read_u32(dev->of_node, "ti,settle-delay-usec",
+				 &val) == 0)
+		pdata->settle_delay_usecs = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,penirq-recheck-delay-usecs",
+				 &val) == 0)
+		pdata->penirq_recheck_delay_usecs = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,x-plate-ohms", &val) == 0)
+		pdata->x_plate_ohms = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,y-plate-ohms", &val) == 0)
+		pdata->y_plate_ohms = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,x-min", &val) == 0)
+		pdata->x_min = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,y-min", &val) == 0)
+		pdata->y_min = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,x-max", &val) == 0)
+		pdata->x_max = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,y-max", &val) == 0)
+		pdata->y_max = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,pressure-min", &val) == 0)
+		pdata->pressure_min = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,pressure-max", &val) == 0)
+		pdata->pressure_max = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,debounce-max", &val) == 0)
+		pdata->debounce_max = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,debounce-tol", &val) == 0)
+		pdata->debounce_tol = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,debounce-rep", &val) == 0)
+		pdata->debounce_rep = val;
+
+	if (of_property_read_u32(dev->of_node, "ti,pendown-gpio-debounce",
+				 &val) == 0)
+		pdata->gpio_pendown_debounce = val;
+
+	pdata->gpio_pendown = of_get_named_gpio(dev->of_node, "pendown-gpio", 0);
+
+	if (of_get_property(dev->of_node, "linux,wakeup", NULL))
+		pdata->wakeup = true;
+
+	return pdata;
+}
+#else
+static inline struct ads7846_platform_data ads7846_probe_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int ads7846_probe(struct spi_device *spi)
 {
 	struct ads7846 *ts;
 	struct ads7846_packet *packet;
 	struct input_dev *input_dev;
-	struct ads7846_platform_data *pdata = spi->dev.platform_data;
+	struct ads7846_platform_data *pdata = NULL;
 	unsigned long irq_flags;
 	int err;
 
@@ -1215,6 +1316,11 @@ static int ads7846_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
+	if (spi->dev.platform_data)
+		pdata = spi->dev.platform_data;
+	else
+		pdata = ads7846_probe_dt(&spi->dev);
+
 	if (!pdata) {
 		dev_dbg(&spi->dev, "no platform data?\n");
 		return -ENODEV;
@@ -1445,6 +1551,7 @@ static struct spi_driver ads7846_driver = {
 		.name	= "ads7846",
 		.owner	= THIS_MODULE,
 		.pm	= &ads7846_pm,
+		.of_match_table = of_match_ptr(ads7846_dt_ids),
 	},
 	.probe		= ads7846_probe,
 	.remove		= ads7846_remove,
-- 
1.8.1.4

