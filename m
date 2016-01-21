From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v4 3/4] Input: cyttsp - switch to using device properties
Date: Thu, 21 Jan 2016 20:21:15 +0100
Message-ID: <03a328d762d8ed654095d9a6edf648bc1c7fa262.1453403916.git.oreste.salerno@tomtom.com>
References: <cover.1453403916.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1453403916.git.oreste.salerno@tomtom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com
List-Id: linux-input@vger.kernel.org

Drop support for platform data passed via a C-structure and switch to
device properties instead, which should make the driver compatible
with all platforms: OF, ACPI and static boards. Static boards should
use property sets to communicate device parameters to the driver.

Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
---
 .../bindings/input/touchscreen/cyttsp.txt          |  95 ++++++++++++
 drivers/input/touchscreen/cyttsp_core.c            | 167 ++++++++++++++-------
 drivers/input/touchscreen/cyttsp_core.h            |  10 +-
 drivers/input/touchscreen/cyttsp_i2c.c             |  10 --
 drivers/input/touchscreen/cyttsp_spi.c             |  10 --
 include/linux/input/cyttsp.h                       |  15 --
 6 files changed, 213 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
new file mode 100644
index 0000000..b0fccae
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
@@ -0,0 +1,95 @@
+* Cypress cyttsp touchscreen controller
+
+Required properties:
+ - compatible		: must be "cypress,cyttsp-i2c" or "cypress,cyttsp-spi"
+ - reg			: Device I2C address or SPI chip select number
+ - spi-max-frequency	: Maximum SPI clocking speed of the device (for cyttsp-spi)
+ - interrupt-parent	: the phandle for the gpio controller
+			  (see interrupt binding[0]).
+ - interrupts		: (gpio) interrupt to which the chip is connected
+			  (see interrupt binding[0]).
+ - reset-gpios		: the reset gpio the chip is connected to
+			  (see GPIO binding[1] for more details).
+ - touchscreen-size-x	: horizontal resolution of touchscreen (in pixels)
+ - touchscreen-size-y	: vertical resolution of touchscreen (in pixels)
+ - bootloader-key	: the 8-byte bootloader key that is required to switch
+			  the chip from bootloader mode (default mode) to
+			  application mode.
+			  This property has to be specified as an array of 8
+			  '/bits/ 8' values.
+
+Optional properties:
+ - touchscreen-fuzz-x	: horizontal noise value of the absolute input device
+			  (in pixels)
+ - touchscreen-fuzz-y	: vertical noise value of the absolute input device
+			  (in pixels)
+ - active-distance	: the distance in pixels beyond which a touch must move
+			  before movement is detected and reported by the device.
+			  Valid values: 0-15.
+ - active-interval-ms	: the minimum period in ms between consecutive
+			  scanning/processing cycles when the chip is in active mode.
+			  Valid values: 0-255.
+ - lowpower-interval-ms	: the minimum period in ms between consecutive
+			  scanning/processing cycles when the chip is in low-power mode.
+			  Valid values: 0-2550
+ - touch-timeout-ms	: minimum time in ms spent in the active power state while no
+			  touches are detected before entering low-power mode.
+			  Valid values: 0-2550
+ - use-handshake	: enable register-based handshake (boolean). This should
+			  only be used if the chip is configured to use 'blocking
+			  communication with timeout' (in this case the device
+			  generates an interrupt at the end of every
+			  scanning/processing cycle).
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
+			interrupt-parent = <&gpio0>;
+			interrupts = <28 0>;
+			reset-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+
+			touchscreen-size-x = <800>;
+			touchscreen-size-y = <480>;
+			touchscreen-fuzz-x = <4>;
+			touchscreen-fuzz-y = <7>;
+
+			bootloader-key = /bits/ 8 <0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08>;
+			active-distance = <8>;
+			active-interval-ms = <0>;
+			lowpower-interval-ms = <200>;
+			touch-timeout-ms = <100>;
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
+			interrupt-parent = <&gpio0>;
+			interrupts = <28 0>;
+			reset-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+
+			touchscreen-size-x = <800>;
+			touchscreen-size-y = <480>;
+			touchscreen-fuzz-x = <4>;
+			touchscreen-fuzz-y = <7>;
+
+			bootloader-key = /bits/ 8 <0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08>;
+			active-distance = <8>;
+			active-interval-ms = <0>;
+			lowpower-interval-ms = <200>;
+			touch-timeout-ms = <100>;
+		};
+
+		/* ... */
+	};
diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 10379bc..92b459d 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -30,9 +30,12 @@
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/property.h>
+#include <linux/gpio/consumer.h>
 
 #include "cyttsp_core.h"
 
@@ -57,6 +60,7 @@
 #define CY_DELAY_DFLT			20 /* ms */
 #define CY_DELAY_MAX			500
 #define CY_ACT_DIST_DFLT		0xF8
+#define CY_ACT_DIST_MASK		0x0F
 #define CY_HNDSHK_BIT			0x80
 /* device mode bits */
 #define CY_OPERATE_MODE			0x00
@@ -120,7 +124,7 @@ static int ttsp_send_command(struct cyttsp *ts, u8 cmd)
 
 static int cyttsp_handshake(struct cyttsp *ts)
 {
-	if (ts->pdata->use_hndshk)
+	if (ts->use_hndshk)
 		return ttsp_send_command(ts,
 				ts->xy_data.hst_mode ^ CY_HNDSHK_BIT);
 
@@ -142,9 +146,9 @@ static int cyttsp_exit_bl_mode(struct cyttsp *ts)
 	u8 bl_cmd[sizeof(bl_command)];
 
 	memcpy(bl_cmd, bl_command, sizeof(bl_command));
-	if (ts->pdata->bl_keys)
+	if (ts->bl_keys)
 		memcpy(&bl_cmd[sizeof(bl_command) - CY_NUM_BL_KEYS],
-			ts->pdata->bl_keys, CY_NUM_BL_KEYS);
+			ts->bl_keys, CY_NUM_BL_KEYS);
 
 	error = ttsp_write_block_data(ts, CY_REG_BASE,
 				      sizeof(bl_cmd), bl_cmd);
@@ -217,14 +221,14 @@ static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
 {
 	int retval = 0;
 
-	if (ts->pdata->act_intrvl != CY_ACT_INTRVL_DFLT ||
-	    ts->pdata->tch_tmout != CY_TCH_TMOUT_DFLT ||
-	    ts->pdata->lp_intrvl != CY_LP_INTRVL_DFLT) {
+	if (ts->act_intrvl != CY_ACT_INTRVL_DFLT ||
+	    ts->tch_tmout != CY_TCH_TMOUT_DFLT ||
+	    ts->lp_intrvl != CY_LP_INTRVL_DFLT) {
 
 		u8 intrvl_ray[] = {
-			ts->pdata->act_intrvl,
-			ts->pdata->tch_tmout,
-			ts->pdata->lp_intrvl
+			ts->act_intrvl,
+			ts->tch_tmout,
+			ts->lp_intrvl
 		};
 
 		/* set intrvl registers */
@@ -263,7 +267,7 @@ out:
 
 static int cyttsp_act_dist_setup(struct cyttsp *ts)
 {
-	u8 act_dist_setup = ts->pdata->act_dist;
+	u8 act_dist_setup = ts->act_dist;
 
 	/* Init gesture; active distance setup */
 	return ttsp_write_block_data(ts, CY_REG_ACT_DIST,
@@ -528,45 +532,107 @@ static void cyttsp_close(struct input_dev *dev)
 		cyttsp_disable(ts);
 }
 
+static int cyttsp_parse_properties(struct cyttsp *ts)
+{
+	struct device *dev = ts->dev;
+	u32 dt_value;
+	int ret;
+
+	ts->bl_keys = devm_kzalloc(dev, CY_NUM_BL_KEYS, GFP_KERNEL);
+	if (!ts->bl_keys)
+		return -ENOMEM;
+
+	/* Set some default values */
+	ts->use_hndshk = false;
+	ts->act_dist = CY_ACT_DIST_DFLT;
+	ts->act_intrvl = CY_ACT_INTRVL_DFLT;
+	ts->tch_tmout = CY_TCH_TMOUT_DFLT;
+	ts->lp_intrvl = CY_LP_INTRVL_DFLT;
+
+	ret = device_property_read_u8_array(dev, "bootloader-key",
+					    ts->bl_keys, CY_NUM_BL_KEYS);
+	if (ret) {
+		dev_err(dev,
+			"bootloader-key property could not be retrieved\n");
+		return ret;
+	}
+
+	ts->use_hndshk = device_property_present(dev, "use-handshake");
+
+	if (!device_property_read_u32(dev, "active-distance", &dt_value)) {
+		if (dt_value > 15) {
+			dev_err(dev, "active-distance (%u) must be [0-15]\n",
+				dt_value);
+			return -EINVAL;
+		}
+		ts->act_dist &= ~CY_ACT_DIST_MASK;
+		ts->act_dist |= dt_value;
+	}
+
+	if (!device_property_read_u32(dev, "active-interval-ms", &dt_value)) {
+		if (dt_value > 255) {
+			dev_err(dev, "active-interval-ms (%u) must be [0-255]\n",
+				dt_value);
+			return -EINVAL;
+		}
+		ts->act_intrvl = dt_value;
+	}
+
+	if (!device_property_read_u32(dev, "lowpower-interval-ms", &dt_value)) {
+		if (dt_value > 2550) {
+			dev_err(dev, "lowpower-interval-ms (%u) must be [0-2550]\n",
+				dt_value);
+			return -EINVAL;
+		}
+		/* Register value is expressed in 0.01s / bit */
+		ts->lp_intrvl = dt_value / 10;
+	}
+
+	if (!device_property_read_u32(dev, "touch-timeout-ms", &dt_value)) {
+		if (dt_value > 2550) {
+			dev_err(dev, "touch-timeout-ms (%u) must be [0-2550]\n",
+				dt_value);
+			return -EINVAL;
+		}
+		/* Register value is expressed in 0.01s / bit */
+		ts->tch_tmout = dt_value/10;
+	}
+
+	return 0;
+}
+
 struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 			    struct device *dev, int irq, size_t xfer_buf_size)
 {
-	const struct cyttsp_platform_data *pdata = dev_get_platdata(dev);
 	struct cyttsp *ts;
 	struct input_dev *input_dev;
 	int error;
 
-	if (!pdata || !pdata->name || irq <= 0) {
-		error = -EINVAL;
-		goto err_out;
-	}
-
 	ts = devm_kzalloc(dev, sizeof(*ts) + xfer_buf_size, GFP_KERNEL);
 	input_dev = devm_input_allocate_device(dev);
-	if (!ts || !input_dev) {
-		error = -ENOMEM;
-		goto err_out;
-	}
+	if (!ts || !input_dev)
+		return ERR_PTR(-ENOMEM);
 
 	ts->dev = dev;
 	ts->input = input_dev;
-	ts->pdata = dev_get_platdata(dev);
 	ts->bus_ops = bus_ops;
 	ts->irq = irq;
 
+	ts->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ts->reset_gpio)) {
+		error = PTR_ERR(ts->reset_gpio);
+		dev_err(dev, "Failed to request reset gpio, error %d\n", error);
+		return ERR_PTR(error);
+	}
+
+	error = cyttsp_parse_properties(ts);
+	if (error)
+		return ERR_PTR(error);
+
 	init_completion(&ts->bl_ready);
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
 
-	if (pdata->init) {
-		error = pdata->init();
-		if (error) {
-			dev_err(ts->dev, "platform init failed, err: %d\n",
-				error);
-			goto err_out;
-		}
-	}
-
-	input_dev->name = pdata->name;
+	input_dev->name = "cyttsp";
 	input_dev->phys = ts->phys;
 	input_dev->id.bustype = bus_ops->bustype;
 	input_dev->dev.parent = ts->dev;
@@ -576,59 +642,46 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 
 	input_set_drvdata(input_dev, ts);
 
-	__set_bit(EV_ABS, input_dev->evbit);
-	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
-			     0, pdata->maxx, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
-			     0, pdata->maxy, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
-			     0, CY_MAXZ, 0, 0);
+	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
+	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
+	touchscreen_parse_properties(input_dev, true);
+	if (!input_abs_get_max(input_dev, ABS_MT_POSITION_X) ||
+	    !input_abs_get_max(input_dev, ABS_MT_POSITION_Y)) {
+		dev_err(dev, "Touchscreen size is not specified\n");
+		return ERR_PTR(-EINVAL);
+	}
 
 	error = input_mt_init_slots(input_dev, CY_MAX_ID, 0);
 	if (error) {
 		dev_err(dev, "Unable to init MT slots.\n");
-		goto err_platform_exit;
+		return ERR_PTR(error);
 	}
 
 	error = devm_request_threaded_irq(dev, ts->irq, NULL, cyttsp_irq,
 					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					  pdata->name, ts);
+					  "cyttsp", ts);
 	if (error) {
 		dev_err(ts->dev, "failed to request IRQ %d, err: %d\n",
 			ts->irq, error);
-		goto err_platform_exit;
+		return ERR_PTR(error);
 	}
 
 	disable_irq(ts->irq);
 
 	error = cyttsp_power_on(ts);
 	if (error)
-		goto err_platform_exit;
+		return ERR_PTR(error);
 
 	error = input_register_device(input_dev);
 	if (error) {
 		dev_err(ts->dev, "failed to register input device: %d\n",
 			error);
-		goto err_platform_exit;
+		return ERR_PTR(error);
 	}
-
 	return ts;
-
-err_platform_exit:
-	if (pdata->exit)
-		pdata->exit();
-err_out:
-	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(cyttsp_probe);
 
-void cyttsp_remove(struct cyttsp *ts)
-{
-	if (ts->pdata->exit)
-		ts->pdata->exit();
-}
-EXPORT_SYMBOL_GPL(cyttsp_remove);
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard touchscreen driver core");
 MODULE_AUTHOR("Cypress");
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index 0707411..7835e2b 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -129,7 +129,6 @@ struct cyttsp {
 	int irq;
 	struct input_dev *input;
 	char phys[32];
-	const struct cyttsp_platform_data *pdata;
 	const struct cyttsp_bus_ops *bus_ops;
 	struct cyttsp_bootloader_data bl_data;
 	struct cyttsp_sysinfo_data sysinfo_data;
@@ -138,12 +137,19 @@ struct cyttsp {
 	enum cyttsp_state state;
 	bool suspended;
 
+	struct gpio_desc *reset_gpio;
+	bool use_hndshk;
+	u8 act_dist;
+	u8 act_intrvl;
+	u8 tch_tmout;
+	u8 lp_intrvl;
+	u8 *bl_keys;
+
 	u8 xfer_buf[] ____cacheline_aligned;
 };
 
 struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 			    struct device *dev, int irq, size_t xfer_buf_size);
-void cyttsp_remove(struct cyttsp *ts);
 
 int cyttsp_i2c_write_block_data(struct device *dev, u8 *xfer_buf, u16 addr,
 		u8 length, const void *values);
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index eee51b3..1edfdba 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -56,15 +56,6 @@ static int cyttsp_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int cyttsp_i2c_remove(struct i2c_client *client)
-{
-	struct cyttsp *ts = i2c_get_clientdata(client);
-
-	cyttsp_remove(ts);
-
-	return 0;
-}
-
 static const struct i2c_device_id cyttsp_i2c_id[] = {
 	{ CY_I2C_NAME, 0 },
 	{ }
@@ -77,7 +68,6 @@ static struct i2c_driver cyttsp_i2c_driver = {
 		.pm	= &cyttsp_pm_ops,
 	},
 	.probe		= cyttsp_i2c_probe,
-	.remove		= cyttsp_i2c_remove,
 	.id_table	= cyttsp_i2c_id,
 };
 
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index bbeeb24..3c9d18b 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -170,22 +170,12 @@ static int cyttsp_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int cyttsp_spi_remove(struct spi_device *spi)
-{
-	struct cyttsp *ts = spi_get_drvdata(spi);
-
-	cyttsp_remove(ts);
-
-	return 0;
-}
-
 static struct spi_driver cyttsp_spi_driver = {
 	.driver = {
 		.name	= CY_SPI_NAME,
 		.pm	= &cyttsp_pm_ops,
 	},
 	.probe  = cyttsp_spi_probe,
-	.remove = cyttsp_spi_remove,
 };
 
 module_spi_driver(cyttsp_spi_driver);
diff --git a/include/linux/input/cyttsp.h b/include/linux/input/cyttsp.h
index 5af7c66..586c8c9 100644
--- a/include/linux/input/cyttsp.h
+++ b/include/linux/input/cyttsp.h
@@ -40,19 +40,4 @@
 /* Active distance in pixels for a gesture to be reported */
 #define CY_ACT_DIST_DFLT 0xF8 /* pixels */
 
-struct cyttsp_platform_data {
-	u32 maxx;
-	u32 maxy;
-	bool use_hndshk;
-	u8 act_dist;	/* Active distance */
-	u8 act_intrvl;  /* Active refresh interval; ms */
-	u8 tch_tmout;   /* Active touch timeout; ms */
-	u8 lp_intrvl;   /* Low power refresh interval; ms */
-	int (*init)(void);
-	void (*exit)(void);
-	char *name;
-	s16 irq_gpio;
-	u8 *bl_keys;
-};
-
 #endif /* _CYTTSP_H_ */
-- 
1.9.1
