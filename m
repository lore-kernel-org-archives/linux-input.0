From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v2 2/3] Input: cyttsp - add device tree support
Date: Tue, 5 Jan 2016 13:59:14 +0100
Message-ID: <97cd8c1d98d7406347e4e48f4c7383a394a2ae93.1451997697.git.oreste.salerno@tomtom.com>
References: <cover.1451997697.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451997697.git.oreste.salerno@tomtom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com
List-Id: linux-input@vger.kernel.org

Add support for retrieving the platform data from the device
tree.

Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
---
 .../bindings/input/touchscreen/cyttsp.txt          |  73 ++++++++++++++
 drivers/input/touchscreen/cyttsp_core.c            | 108 +++++++++++++++++++--
 include/linux/input/cyttsp.h                       |   3 +
 3 files changed, 177 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
new file mode 100644
index 0000000..8e0bcc73
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
@@ -0,0 +1,73 @@
+* Cypress cyttsp touchscreen controller
+
+Required properties:
+- compatible		: must be "cypress,cyttsp-i2c" or "cypress,cyttsp-spi"
+- reg			: Device address
+- spi-max-frequency 	: Maximum SPI clocking speed of the device (for cyttsp-spi)
+- interrupt-parent	: the phandle for the gpio controller
+			  (see interrupt binding[0]).
+- interrupts		: (gpio) interrupt to which the chip is connected
+			  (see interrupt binding[0]).
+- reset-gpios		: the reset gpio the chip is connected to
+			  (see GPIO binding[1] for more details).
+- maxx			: horizontal resolution of touchscreen (in pixels)
+- maxy			: vertical resolution of touchscreen (in pixels)
+- bootloader-key	: the bootloader key used to exit bootloader mode
+
+Optional properties:
+- use_hndshk		: enable handshake bit
+- act_dist		: active distance
+- act_intrvl		: active refresh interval in ms
+- tch_tmout		: active touch timeout in ms
+- lp_intrvl		: low power refresh interval in ms
+
+[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+[1]: Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+	&i2c1 {
+		/* ... */
+		cyttsp@a {
+			compatible = "cypress,cyttsp-i2c";
+			reg = <0xa>;
+			interrupt-parent = <&msm_gpio>;
+			interrupts = <13 0x2008>;
+			reset-gpios = <&msm_gpio 12 0x00>;
+
+			maxx = <800>;
+			maxy = <480>;
+			bootloader-key = /bits/ 8 <0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08>;
+
+			use_hndshk;
+			act_dist = /bits/ 8 <0xF8>;
+			act_intrvl = /bits/ 8 <0x00>;
+			tch_tmout = /bits/ 8 <0xFF>;
+			lp_intrvl = /bits/ 8 <0x0A>;
+		};
+
+		/* ... */
+	};
+
+	&mcspi1 {
+		/* ... */
+		cyttsp@0 {
+			compatible = "cypress,cyttsp-spi";
+			spi-max-frequency = <6000000>;
+			reg = <0>;
+			interrupt-parent = <&msm_gpio>;
+			interrupts = <13 0x2008>;
+			reset-gpios = <&msm_gpio 12 0x00>;
+
+			maxx = <800>;
+			maxy = <480>;
+			bootloader-key = /bits/ 8 <0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08>;
+
+			use_hndshk;
+			act_dist = /bits/ 8 <0xF8>;
+			act_intrvl = /bits/ 8 <0x00>;
+			tch_tmout = /bits/ 8 <0xFF>;
+			lp_intrvl = /bits/ 8 <0x0A>;
+		};
+
+		/* ... */
+	};
diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 5b74e8b..8390236 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -33,6 +33,8 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/gpio/consumer.h>
 
 #include "cyttsp_core.h"
 
@@ -528,18 +530,111 @@ static void cyttsp_close(struct input_dev *dev)
 		cyttsp_disable(ts);
 }
 
+#ifdef CONFIG_OF
+static const struct cyttsp_platform_data *cyttsp_parse_dt(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct cyttsp_platform_data *pdata;
+	u8 dt_value;
+	int ret;
+	static const char err_msg[] =
+		"property not provided in the device tree";
+
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->bl_keys = devm_kzalloc(dev, CY_NUM_BL_KEYS, GFP_KERNEL);
+	if (!pdata->bl_keys)
+		return ERR_PTR(-ENOMEM);
+
+	/* Set some default values */
+	pdata->act_dist = CY_ACT_DIST_DFLT;
+	pdata->act_intrvl = CY_ACT_INTRVL_DFLT;
+	pdata->tch_tmout = CY_TCH_TMOUT_DFLT;
+	pdata->lp_intrvl = CY_LP_INTRVL_DFLT;
+	pdata->name = "cyttsp";
+
+	ret = of_property_read_u32(np, "maxx", &pdata->maxx);
+	if (ret) {
+		dev_err(dev, "maxx %s\n", err_msg);
+		return ERR_PTR(ret);
+	}
+
+	ret = of_property_read_u32(np, "maxy", &pdata->maxy);
+	if (ret) {
+		dev_err(dev, "maxy %s\n", err_msg);
+		return ERR_PTR(ret);
+	}
+
+	pdata->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(pdata->reset_gpio)) {
+		ret = PTR_ERR(pdata->reset_gpio);
+		dev_err(dev, "error acquiring reset gpio: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	ret = of_property_read_u8_array(np, "bootloader-key",
+			pdata->bl_keys, CY_NUM_BL_KEYS);
+	if (ret) {
+		dev_err(dev, "bootloader-key %s\n", err_msg);
+		return ERR_PTR(ret);
+	}
+
+	pdata->use_hndshk = of_property_read_bool(np, "use_hndshk");
+
+	if (!of_property_read_u8(np, "act_dist", &dt_value))
+		pdata->act_dist = dt_value;
+
+	if (!of_property_read_u8(np, "act_intrvl", &dt_value))
+		pdata->act_intrvl = dt_value;
+
+	if (!of_property_read_u8(np, "tch_tmout", &dt_value))
+		pdata->tch_tmout = dt_value;
+
+	if (!of_property_read_u8(np, "lp_intrvl", &dt_value))
+		pdata->lp_intrvl = dt_value;
+
+	return pdata;
+}
+#else
+static const struct cyttsp_platform_data *cyttsp_parse_dt(struct device *dev)
+{
+	return ERR_PTR(-ENOENT);
+}
+#endif
+
+static const struct cyttsp_platform_data *
+cyttsp_get_platform_data(struct device *dev)
+{
+	const struct cyttsp_platform_data *pdata;
+
+	pdata = dev_get_platdata(dev);
+	if (pdata)
+		return pdata;
+
+	pdata = cyttsp_parse_dt(dev);
+	if (!IS_ERR(pdata) || PTR_ERR(pdata) != -ENOENT)
+		return pdata;
+
+	dev_err(dev, "No platform data specified\n");
+	return ERR_PTR(-EINVAL);
+}
+
 struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 			    struct device *dev, int irq, size_t xfer_buf_size)
 {
-	const struct cyttsp_platform_data *pdata = dev_get_platdata(dev);
+	const struct cyttsp_platform_data *pdata;
 	struct cyttsp *ts;
 	struct input_dev *input_dev;
 	int error;
 
-	if (!pdata || !pdata->name || irq <= 0) {
-		error = -EINVAL;
-		goto err_out;
-	}
+	pdata = cyttsp_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return ERR_CAST(pdata);
 
 	ts = kzalloc(sizeof(*ts) + xfer_buf_size, GFP_KERNEL);
 	input_dev = input_allocate_device();
@@ -550,7 +645,7 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 
 	ts->dev = dev;
 	ts->input = input_dev;
-	ts->pdata = dev_get_platdata(dev);
+	ts->pdata = pdata;
 	ts->bus_ops = bus_ops;
 	ts->irq = irq;
 
@@ -618,7 +713,6 @@ err_platform_exit:
 err_free_mem:
 	input_free_device(input_dev);
 	kfree(ts);
-err_out:
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(cyttsp_probe);
diff --git a/include/linux/input/cyttsp.h b/include/linux/input/cyttsp.h
index d7c2520..92a9d52 100644
--- a/include/linux/input/cyttsp.h
+++ b/include/linux/input/cyttsp.h
@@ -29,6 +29,8 @@
 #ifndef _CYTTSP_H_
 #define _CYTTSP_H_
 
+#include <linux/gpio/consumer.h>
+
 #define CY_SPI_NAME "cyttsp-spi"
 #define CY_I2C_NAME "cyttsp-i2c"
 /* Active Power state scanning/processing refresh interval */
@@ -51,6 +53,7 @@ struct cyttsp_platform_data {
 	int (*init)(void);
 	void (*exit)(void);
 	char *name;
+	struct gpio_desc *reset_gpio;
 	u8 *bl_keys;
 };
 
-- 
1.9.1
