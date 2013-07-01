From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] Input: touchscreen: ads7846: add device
 tree bindings
Date: Sun, 30 Jun 2013 18:35:37 -0700
Message-ID: <20130701013537.GB10755@core.coreip.homeip.net>
References: <1372626555-29479-1-git-send-email-zonque@gmail.com>
 <1372626555-29479-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:56530 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab3GABfl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jun 2013 21:35:41 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so4241823pbb.0
        for <linux-input@vger.kernel.org>; Sun, 30 Jun 2013 18:35:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1372626555-29479-2-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com

Hi Daniel,

On Sun, Jun 30, 2013 at 11:09:15PM +0200, Daniel Mack wrote:
> +static struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
> +{
> +	struct ads7846_platform_data *pdata = NULL;
> +	const struct of_device_id *match;
> +	u32 val;
> +
> +	match = of_match_device(ads7846_dt_ids, dev);
> +	if (!match)
> +		return NULL;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return NULL;
> +
> +	pdata->model = (unsigned int) match->data;

The pointer is long so this conversion does generate compile warnings.

> +
> +	if (of_property_read_u32(dev->of_node, "ti,vref-delay-usecs", &val) == 0)
> +		pdata->vref_delay_usecs = val;

Why don't we use u16 properties to match the platform data?

How about the version of the patch below?

Thanks.

-- 
Dmitry

Input: ads7846 - add device tree bindings

From: Daniel Mack <zonque@gmail.com>

Signed-off-by: Daniel Mack <zonque@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/ads7846.txt          |   91 ++++++++++++++++
 drivers/input/touchscreen/ads7846.c                |  115 ++++++++++++++++++--
 2 files changed, 195 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ads7846.txt

diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/ads7846.txt
new file mode 100644
index 0000000..5f7619c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ads7846.txt
@@ -0,0 +1,91 @@
+Device tree bindings for TI's ADS7843, ADS7845, ADS7846, ADS7873, TSC2046
+SPI driven touch screen controllers.
+
+The node for this driver must be a child node of a SPI controller, hence
+all mandatory properties described in
+
+	Documentation/devicetree/bindings/spi/spi-bus.txt
+
+must be specified.
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
+					external vref (u16).
+	ti,vref-mv			The VREF voltage, in millivolts (u16).
+	ti,keep-vref-on			set to keep vref on for differential
+					measurements as well
+	ti,swap-xy			swap x and y axis
+	ti,settle-delay-usec		Settling time of the analog signals;
+					a function of Vcc and the capacitance
+					on the X/Y drivers.  If set to non-zero,
+					two samples are taken with settle_delay
+					us apart, and the second one is used.
+					~150 uSec with 0.01uF caps (u16).
+	ti,penirq-recheck-delay-usecs	If set to non-zero, after samples are
+					taken this delay is applied and penirq
+					is rechecked, to help avoid false
+					events.  This value is affected by the
+					material used to build the touch layer
+					(u16).
+	ti,x-plate-ohms			Resistance of the X-plate,
+					in Ohms (u16).
+	ti,y-plate-ohms			Resistance of the Y-plate,
+					in Ohms (u16).
+	ti,x-min			Minimum value on the X axis (u16).
+	ti,y-min			Minimum value on the Y axis (u16).
+	ti,x-max			Maximum value on the X axis (u16).
+	ti,y-max			Minimum value on the Y axis (u16).
+	ti,pressure-min			Minimum reported pressure value
+					(threshold) - u16.
+	ti,pressure-max			Maximum reported pressure value (u16).
+	ti,debounce-max			Max number of additional readings per
+					sample (u16).
+	ti,debounce-tol			Tolerance used for filtering (u16).
+	ti,debounce-rep			Additional consecutive good readings
+					required after the first two (u16).
+	ti,pendown-gpio-debounce	Platform specific debounce time for the
+					pendown-gpio (u32).
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
+			ti,x-min = /bits/ 16 <0>;
+			ti,x-max = /bits/ 16 <8000>;
+			ti,y-min = /bits/ 16 <0>;
+			ti,y-max = /bits/ 16 <4800>;
+			ti,x-plate-ohms = /bits/ 16 <40>;
+			ti,pressure-max = /bits/ 16 <255>;
+
+			linux,wakeup;
+		};
+	};
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 5ff0419..87ef992 100644
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
@@ -1201,9 +1204,87 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_add_tail(x, m);
 }
 
+#ifndef CONFIG_OF
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
+static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
+{
+	struct ads7846_platform_data *pdata;
+	struct device_node *node = dev->of_node;
+	const struct of_device_id *match;
+
+	if (!node) {
+		dev_err(dev, "Device does not have associated DT data\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	match = of_match_device(ads7846_dt_ids, dev);
+	if (!match) {
+		dev_err(dev, "Unknown device model\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->model = (unsigned long)match->data;
+
+	of_property_read_u16(node, "ti,vref-delay-usecs",
+			     &pdata->vref_delay_usecs);
+	of_property_read_u16(node, "ti,vref-mv", &pdata->vref_mv);
+	pdata->keep_vref_on = of_property_read_bool(node, "ti,keep-vref-on");
+
+	pdata->swap_xy = of_property_read_bool(node, "ti,swap-xy");
+
+	of_property_read_u16(node, "ti,settle-delay-usec",
+			     &pdata->settle_delay_usecs);
+	of_property_read_u16(node, "ti,penirq-recheck-delay-usecs",
+			     &pdata->penirq_recheck_delay_usecs);
+
+	of_property_read_u16(node, "ti,x-plate-ohms", &pdata->x_plate_ohms);
+	of_property_read_u16(node, "ti,y-plate-ohms", &pdata->y_plate_ohms);
+
+	of_property_read_u16(node, "ti,x-min", &pdata->x_min);
+	of_property_read_u16(node, "ti,y-min", &pdata->y_min);
+	of_property_read_u16(node, "ti,x-max", &pdata->x_max);
+	of_property_read_u16(node, "ti,y-max", &pdata->y_max);
+
+	of_property_read_u16(node, "ti,pressure-min", &pdata->pressure_min);
+	of_property_read_u16(node, "ti,pressure-max", &pdata->pressure_max);
+
+	of_property_read_u16(node, "ti,debounce-max", &pdata->debounce_max);
+	of_property_read_u16(node, "ti,debounce-tol", &pdata->debounce_tol);
+	of_property_read_u16(node, "ti,debounce-rep", &pdata->debounce_rep);
+
+	of_property_read_u32(node, "ti,pendown-gpio-debounce",
+			     &pdata->gpio_pendown_debounce);
+
+	pdata->wakeup = of_property_read_bool(node, "linux,wakeup");
+
+	pdata->gpio_pendown = of_get_named_gpio(dev->of_node, "pendown-gpio", 0);
+
+	return pdata;
+}
+#else
+static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
+{
+	dev_err(dev, "no platform data defined\n");
+	return ERR_PTR(-EINVAL);
+}
+#endif
+
 static int ads7846_probe(struct spi_device *spi)
 {
-	const struct ads7846_platform_data *pdata = dev_get_platdata(&spi->dev);
+	const struct ads7846_platform_data *pdata;
 	struct ads7846 *ts;
 	struct ads7846_packet *packet;
 	struct input_dev *input_dev;
@@ -1212,22 +1293,18 @@ static int ads7846_probe(struct spi_device *spi)
 
 	if (!spi->irq) {
 		dev_dbg(&spi->dev, "no IRQ?\n");
-		return -ENODEV;
-	}
-
-	if (!pdata) {
-		dev_dbg(&spi->dev, "no platform data?\n");
-		return -ENODEV;
+		return -EINVAL;
 	}
 
 	/* don't exceed max specified sample rate */
 	if (spi->max_speed_hz > (125000 * SAMPLE_BITS)) {
-		dev_dbg(&spi->dev, "f(sample) %d KHz?\n",
+		dev_err(&spi->dev, "f(sample) %d KHz?\n",
 				(spi->max_speed_hz/SAMPLE_BITS)/1000);
 		return -EINVAL;
 	}
 
-	/* We'd set TX word size 8 bits and RX word size to 13 bits ... except
+	/*
+	 * We'd set TX word size 8 bits and RX word size to 13 bits ... except
 	 * that even if the hardware can do that, the SPI controller driver
 	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
 	 */
@@ -1250,17 +1327,25 @@ static int ads7846_probe(struct spi_device *spi)
 	ts->packet = packet;
 	ts->spi = spi;
 	ts->input = input_dev;
-	ts->vref_mv = pdata->vref_mv;
-	ts->swap_xy = pdata->swap_xy;
 
 	mutex_init(&ts->lock);
 	init_waitqueue_head(&ts->wait);
 
+	pdata = dev_get_platdata(&spi->dev);
+	if (!pdata) {
+		pdata = ads7846_probe_dt(&spi->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
+
 	ts->model = pdata->model ? : 7846;
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
 	ts->pressure_max = pdata->pressure_max ? : ~0;
 
+	ts->vref_mv = pdata->vref_mv;
+	ts->swap_xy = pdata->swap_xy;
+
 	if (pdata->filter != NULL) {
 		if (pdata->filter_init != NULL) {
 			err = pdata->filter_init(pdata, &ts->filter_data);
@@ -1370,6 +1455,13 @@ static int ads7846_probe(struct spi_device *spi)
 
 	device_init_wakeup(&spi->dev, pdata->wakeup);
 
+	/*
+	 * If device does not carry platform data we must have allocated it
+	 * when parsing DT data.
+	 */
+	if (!dev_get_platdata(&spi->dev))
+		devm_kfree(&spi->dev, (void *)pdata);
+
 	return 0;
 
  err_remove_attr_group:
@@ -1437,6 +1529,7 @@ static struct spi_driver ads7846_driver = {
 		.name	= "ads7846",
 		.owner	= THIS_MODULE,
 		.pm	= &ads7846_pm,
+		.of_match_table = of_match_ptr(ads7846_dt_ids),
 	},
 	.probe		= ads7846_probe,
 	.remove		= ads7846_remove,
