From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH v3] input: Add support for the Semtech SX8634 controller
Date: Mon, 23 Jul 2012 22:48:37 +0200
Message-ID: <1343076517-23233-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58872 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab2GWUsp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jul 2012 16:48:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org

This commit adds support for the Semtech SX8634 Capacitive Button and
Slider Touch controller.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

---
Changes in v3:
- use non-managed version of request_threaded_irq() to safely handle
  device/driver removal
- drop power-management stubs
- use gpio_request_one()

Changes in v2:
- add OF device table
- use smtc vendor prefix
- fix build warnings
- add power-gpios property

 Documentation/devicetree/bindings/input/sx8634.txt |  58 ++
 drivers/input/misc/Kconfig                         |  10 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/sx8634.c                        | 766 +++++++++++++++++++++
 include/linux/input/sx8634.h                       |  33 +
 5 files changed, 868 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/sx8634.txt
 create mode 100644 drivers/input/misc/sx8634.c
 create mode 100644 include/linux/input/sx8634.h

diff --git a/Documentation/devicetree/bindings/input/sx8634.txt b/Documentation/devicetree/bindings/input/sx8634.txt
new file mode 100644
index 0000000..65e2e10
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/sx8634.txt
@@ -0,0 +1,58 @@
+Semtech SX8634 Capacitive Button and Slider Touch Controller
+
+The SX8634 controller is configured with the following properties:
+
+  Required properties:
+  - compatible: "smtc,sx8634"
+  - reg: I2C bus address of the device
+  - interrupts: interrupt number of the device
+  - #address-cells: must be <1>
+  - #size-cells: must be <0>
+
+  Optional Properties:
+  - threshold: number of ticks required to detect a touch/release
+    - range: 0x00 to 0xff
+    - default: 0xa0
+  - sensitivity: sensitivity of the sensors
+    - range: 0x0 to 0x7
+    - default: 0x0
+
+Each capacitive sensor is configured via a separate sub-node:
+
+  Required Properties:
+  - reg: sensor index
+  - label: name of the sensor
+  - linux,code: Keycode to emit for buttons. If absent, the capacitive sensor
+    is part of the slider element.
+
+  Optional Properties:
+  - threshold: overrides the global threshold setting
+  - sensitivity: overrides the global sensitivity setting
+
+Example:
+
+	keypad: sx8634@2b {
+		compatible = "smtc,sx8634";
+		reg = <0x2b>;
+
+		interrupt-parent = <&gpioext>;
+		interrupts = <3>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		threshold = <0xa0>;
+		sensitivity = <7>;
+
+		cap@1 {
+			reg = <1>;
+			label = "Up";
+			linux,code = <103>; /* KEY_UP */
+		};
+
+		cap@2 {
+			reg = <2>;
+			label = "Down";
+			linux,code = <108>; /* KEY_DOWN */
+		};
+	};
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7faf4a7..61e48e5 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -577,6 +577,16 @@ config INPUT_CMA3000_I2C
 	  To compile this driver as a module, choose M here: the
 	  module will be called cma3000_d0x_i2c.
 
+config INPUT_SX8634
+	tristate "Semtech SX8634"
+	depends on I2C
+	default n
+	help
+	  Say Y here if you want to use the Semtech SX8634 controller.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called sx8634.
+
 config INPUT_XEN_KBDDEV_FRONTEND
 	tristate "Xen virtual keyboard and mouse support"
 	depends on XEN
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index f55cdf4..7a86fac 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -53,5 +53,6 @@ obj-$(CONFIG_INPUT_TWL6040_VIBRA)	+= twl6040-vibra.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
 obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
+obj-$(CONFIG_INPUT_SX8634)		+= sx8634.o
 obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
diff --git a/drivers/input/misc/sx8634.c b/drivers/input/misc/sx8634.c
new file mode 100644
index 0000000..471d387
--- /dev/null
+++ b/drivers/input/misc/sx8634.c
@@ -0,0 +1,766 @@
+/*
+ * Copyright (C) 2011-2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+
+#include <linux/input/sx8634.h>
+
+#define I2C_IRQ_SRC 0x00
+#define I2C_IRQ_SRC_MODE (1 << 0)
+#define I2C_IRQ_SRC_COMPENSATION (1 << 1)
+#define I2C_IRQ_SRC_BUTTONS (1 << 2)
+#define I2C_IRQ_SRC_SLIDER (1 << 3)
+#define I2C_IRQ_SRC_GPI (1 << 4)
+#define I2C_IRQ_SRC_SPM (1 << 5)
+#define I2C_IRQ_SRC_NVM (1 << 6)
+#define I2C_IRQ_SRC_READY (1 << 7)
+
+#define I2C_CAP_STAT_MSB 0x01
+#define I2C_CAP_STAT_LSB 0x02
+#define I2C_SLD_POS_MSB 0x03
+#define I2C_SLD_POS_LSB 0x04
+#define I2C_GPI_STAT 0x07
+#define I2C_SPM_STAT 0x08
+#define I2C_COMP_OP_MODE 0x09
+#define I2C_GPO_CTRL 0x0a
+#define I2C_GPP_PIN_ID 0x0b
+#define I2C_GPP_INTENSITY 0x0c
+#define I2C_SPM_CFG 0x0d
+#define I2C_SPM_CFG_WRITE (0 << 3)
+#define I2C_SPM_CFG_READ (1 << 3)
+#define I2C_SPM_CFG_OFF (0 << 4)
+#define I2C_SPM_CFG_ON (1 << 4)
+#define I2C_SPM_BASE 0x0e
+#define I2C_SPM_KEY_MSB 0xac
+#define I2C_SPM_KEY_LSB 0xad
+#define I2C_SOFT_RESET 0xb1
+
+#define SPM_CFG 0x00
+#define SPM_CAP_MODE_MISC 0x09
+
+#define SPM_CAP_MODE(x) (((x) <= 3) ? 0x0c : (((x) <= 7) ? 0x0b : 0x0a))
+#define SPM_CAP_MODE_SHIFT(x) (((x) & 3) * 2)
+#define SPM_CAP_MODE_MASK 0x3
+#define SPM_CAP_MODE_MASK_SHIFTED(x) (SPM_CAP_MODE_MASK << SPM_CAP_MODE_SHIFT(x))
+
+#define SPM_CAP_SENS(x) (0x0d + ((x) / 2))
+#define SPM_CAP_SENS_MAX 0x7
+#define SPM_CAP_SENS_SHIFT(x) (((x) & 1) ? 0 : 4)
+#define SPM_CAP_SENS_MASK 0x7
+#define SPM_CAP_SENS_MASK_SHIFTED(x) (SPM_CAP_SENS_MASK << SPM_CAP_SENS_SHIFT(x))
+
+#define SPM_CAP_THRESHOLD(x) (0x13 + (x))
+#define SPM_CAP_THRESHOLD_MAX 0xff
+
+#define SPM_BLOCK_SIZE 8
+#define SPM_NUM_BLOCKS 16
+#define SPM_SIZE (SPM_BLOCK_SIZE * SPM_NUM_BLOCKS)
+
+#define SLD_POS_STEP 12
+
+struct sx8634 {
+	struct i2c_client *client;
+	struct input_dev *input;
+	unsigned short keycodes[SX8634_NUM_CAPS];
+	unsigned long spm_dirty;
+	u8 *spm_cache;
+	u16 slider_max;
+	u16 status;
+	int power_gpio;
+};
+
+static int spm_wait(struct i2c_client *client)
+{
+	unsigned int retries = 32;
+	int err;
+
+	do {
+		err = i2c_smbus_read_byte_data(client, I2C_IRQ_SRC);
+		if (err < 0)
+			return err;
+
+		if (err & I2C_IRQ_SRC_SPM)
+			break;
+
+		msleep(10);
+	} while (--retries);
+
+	return retries ? 0 : -ETIMEDOUT;
+}
+
+static ssize_t spm_read_block(struct i2c_client *client, loff_t offset,
+		void *buffer, size_t size)
+{
+	u8 enable = I2C_SPM_CFG_ON | I2C_SPM_CFG_READ;
+	int err;
+
+	BUG_ON(size < SPM_BLOCK_SIZE);
+	BUG_ON((offset & 7) != 0);
+
+	err = i2c_smbus_write_byte_data(client, I2C_SPM_CFG, enable);
+	if (err < 0)
+		return err;
+
+	err = i2c_smbus_write_byte_data(client, I2C_SPM_BASE, offset);
+	if (err < 0)
+		return err;
+
+	err = i2c_smbus_read_i2c_block_data(client, 0, SPM_BLOCK_SIZE, buffer);
+	if (err < 0)
+		return err;
+
+	err = i2c_smbus_write_byte_data(client, I2C_SPM_CFG, I2C_SPM_CFG_OFF);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static ssize_t spm_write_block(struct i2c_client *client, loff_t offset,
+		const void *buffer, size_t size)
+{
+	u8 enable = I2C_SPM_CFG_ON | I2C_SPM_CFG_WRITE;
+	int err;
+
+	BUG_ON(size < SPM_BLOCK_SIZE);
+	BUG_ON((offset & 7) != 0);
+
+	err = i2c_smbus_write_byte_data(client, I2C_SPM_CFG, enable);
+	if (err < 0)
+		return err;
+
+	err = i2c_smbus_write_byte_data(client, I2C_SPM_BASE, offset);
+	if (err < 0)
+		return err;
+
+	err = i2c_smbus_write_i2c_block_data(client, 0, SPM_BLOCK_SIZE, buffer);
+	if (err < 0)
+		return err;
+
+	err = i2c_smbus_write_byte_data(client, I2C_SPM_CFG, I2C_SPM_CFG_OFF);
+	if (err < 0)
+		return err;
+
+	err = spm_wait(client);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static ssize_t sx8634_spm_load(struct sx8634 *sx)
+{
+	loff_t offset;
+	ssize_t err;
+
+	if (sx->spm_dirty != 0)
+		dev_warn(&sx->client->dev, "discarding modified SPM cache\n");
+
+	memset(sx->spm_cache, 0, SPM_SIZE);
+
+	for (offset = 0; offset < SPM_SIZE; offset += SPM_BLOCK_SIZE) {
+		err = spm_read_block(sx->client, offset,
+				sx->spm_cache + offset, SPM_BLOCK_SIZE);
+		if (err < 0) {
+			dev_err(&sx->client->dev, "spm_read_block(): %d\n",
+					err);
+			return err;
+		}
+	}
+
+	sx->spm_dirty = 0;
+
+	return 0;
+}
+
+static ssize_t sx8634_spm_sync(struct sx8634 *sx)
+{
+	int bit;
+
+	for_each_set_bit(bit, &sx->spm_dirty, SPM_NUM_BLOCKS) {
+		loff_t offset = bit * SPM_BLOCK_SIZE;
+		ssize_t err;
+
+		err = spm_write_block(sx->client, offset,
+				sx->spm_cache + offset, SPM_BLOCK_SIZE);
+		if (err < 0) {
+			dev_err(&sx->client->dev, "spm_write_block(): %d\n",
+					err);
+			return err;
+		}
+	}
+
+	sx->spm_dirty = 0;
+
+	return 0;
+}
+
+static int sx8634_spm_read(struct sx8634 *sx, unsigned int offset, u8 *value)
+{
+	if (offset >= SPM_SIZE)
+		return -ENXIO;
+
+	*value = sx->spm_cache[offset];
+
+	return 0;
+}
+
+static int sx8634_spm_write(struct sx8634 *sx, unsigned int offset, u8 value)
+{
+	if (offset >= SPM_SIZE)
+		return -ENXIO;
+
+	sx->spm_dirty |= BIT(offset / SPM_BLOCK_SIZE);
+	sx->spm_cache[offset] = value;
+
+	return 0;
+}
+
+static int sx8634_reset(struct sx8634 *sx)
+{
+	unsigned int retries = 32;
+	int err;
+
+	err = i2c_smbus_write_byte_data(sx->client, I2C_SOFT_RESET, 0xde);
+	if (err < 0)
+		return err;
+
+	err = i2c_smbus_write_byte_data(sx->client, I2C_SOFT_RESET, 0x00);
+	if (err < 0)
+		return err;
+
+	do {
+		err = i2c_smbus_read_byte_data(sx->client, I2C_IRQ_SRC);
+		if (err < 0)
+			return err;
+
+		if (err & I2C_IRQ_SRC_READY)
+			break;
+
+		msleep(10);
+	} while (--retries);
+
+	return retries ? 0 : -ETIMEDOUT;
+}
+
+static irqreturn_t sx8634_irq(int irq, void *data)
+{
+	struct sx8634 *sx = data;
+	bool need_sync = false;
+	u8 pending;
+	int err;
+
+	err = i2c_smbus_read_byte_data(sx->client, I2C_IRQ_SRC);
+	if (err < 0) {
+		dev_err(&sx->client->dev, "failed to read IRQ source register: %d\n", err);
+		return IRQ_NONE;
+	}
+
+	pending = err;
+
+	if (pending & I2C_IRQ_SRC_COMPENSATION)
+		dev_dbg(&sx->client->dev, "compensation complete\n");
+
+	if (pending & I2C_IRQ_SRC_BUTTONS) {
+		unsigned long changed;
+		unsigned int cap;
+		u16 status;
+
+		err = i2c_smbus_read_byte_data(sx->client, I2C_CAP_STAT_MSB);
+		if (err < 0) {
+			dev_err(&sx->client->dev, "failed to read MSB: %d\n", err);
+			return IRQ_NONE;
+		}
+
+		status = err << 8;
+
+		err = i2c_smbus_read_byte_data(sx->client, I2C_CAP_STAT_LSB);
+		if (err < 0) {
+			dev_err(&sx->client->dev, "failed to read LSB: %d\n", err);
+			return IRQ_NONE;
+		}
+
+		status |= err;
+
+		changed = status ^ sx->status;
+
+		for_each_set_bit(cap, &changed, SX8634_NUM_CAPS) {
+			unsigned int level = (status & BIT(cap)) ? 1 : 0;
+			input_report_key(sx->input, sx->keycodes[cap], level);
+			need_sync = true;
+		}
+
+		sx->status = status;
+	}
+
+	if (pending & I2C_IRQ_SRC_SLIDER) {
+		u16 position;
+
+		err = i2c_smbus_read_byte_data(sx->client, I2C_SLD_POS_MSB);
+		if (err < 0) {
+			dev_err(&sx->client->dev, "failed to read MSB: %d\n",
+					err);
+			return IRQ_NONE;
+		}
+
+		position = err << 8;
+
+		err = i2c_smbus_read_byte_data(sx->client, I2C_SLD_POS_LSB);
+		if (err < 0) {
+			dev_err(&sx->client->dev, "failed to read LSB: %d\n",
+					err);
+			return IRQ_NONE;
+		}
+
+		position |= err;
+
+		input_report_abs(sx->input, ABS_MISC, position);
+	}
+
+	if (need_sync || (pending & I2C_IRQ_SRC_SLIDER))
+		input_sync(sx->input);
+
+	if (pending & I2C_IRQ_SRC_GPI)
+		dev_dbg(&sx->client->dev, "%s(): GPI event\n", __func__);
+
+	if (pending & I2C_IRQ_SRC_SPM)
+		dev_dbg(&sx->client->dev, "%s(): SPM event\n", __func__);
+
+	if (pending & I2C_IRQ_SRC_NVM)
+		dev_dbg(&sx->client->dev, "%s(): NVM event\n", __func__);
+
+	if (pending & I2C_IRQ_SRC_READY)
+		dev_dbg(&sx->client->dev, "%s(): ready event\n", __func__);
+
+	return IRQ_HANDLED;
+}
+
+static int sx8634_set_mode(struct sx8634 *sx, unsigned int cap, enum sx8634_cap_mode mode)
+{
+	u8 value = 0;
+	int err;
+
+	if ((cap >= SX8634_NUM_CAPS) || (mode == SX8634_CAP_MODE_RESERVED))
+		return -EINVAL;
+
+	err = sx8634_spm_read(sx, SPM_CAP_MODE(cap), &value);
+	if (err < 0)
+		return err;
+
+	value &= ~SPM_CAP_MODE_MASK_SHIFTED(cap);
+	value |= (mode & SPM_CAP_MODE_MASK) << SPM_CAP_MODE_SHIFT(cap);
+
+	err = sx8634_spm_write(sx, SPM_CAP_MODE(cap), value);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int sx8634_set_sensitivity(struct sx8634 *sx, unsigned int cap,
+		u8 sensitivity)
+{
+	u8 value = 0;
+	int err = 0;
+
+	if (cap >= SX8634_NUM_CAPS)
+		return -EINVAL;
+
+	err = sx8634_spm_read(sx, SPM_CAP_SENS(cap), &value);
+	if (err < 0)
+		return err;
+
+	value &= ~SPM_CAP_SENS_MASK_SHIFTED(cap);
+	value |= (sensitivity & SPM_CAP_SENS_MASK) << SPM_CAP_SENS_SHIFT(cap);
+
+	err = sx8634_spm_write(sx, SPM_CAP_SENS(cap), value);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int sx8634_set_threshold(struct sx8634 *sx, unsigned int cap,
+		u8 threshold)
+{
+	int err;
+
+	if (cap >= SX8634_NUM_CAPS)
+		return -EINVAL;
+
+	err = sx8634_spm_write(sx, SPM_CAP_THRESHOLD(cap), threshold);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int sx8634_setup(struct sx8634 *sx, struct sx8634_platform_data *pdata)
+{
+	bool slider = false;
+	unsigned int i;
+	int err;
+
+	err = sx8634_reset(sx);
+	if (err < 0)
+		return err;
+
+	err = sx8634_spm_load(sx);
+	if (err < 0)
+		return err;
+
+	/* disable all capacitive sensors */
+	for (i = 0; i < SX8634_NUM_CAPS; i++) {
+		err = sx8634_set_mode(sx, i, SX8634_CAP_MODE_DISABLED);
+		if (err < 0)
+			return err;
+	}
+
+	err = sx8634_spm_sync(sx);
+	if (err < 0)
+		return err;
+
+	err = sx8634_spm_load(sx);
+	if (err < 0)
+		return err;
+
+	/* configure capacitive sensor parameters */
+	for (i = 0; i < SX8634_NUM_CAPS; i++) {
+		struct sx8634_cap *cap = &pdata->caps[i];
+
+		err = sx8634_set_sensitivity(sx, i, cap->sensitivity);
+		if (err < 0)
+			dev_err(&sx->client->dev, "%s failed: %d\n",
+					"sx8634_set_sensitivity()", err);
+
+		err = sx8634_set_threshold(sx, i, cap->threshold);
+		if (err < 0)
+			dev_err(&sx->client->dev, "%s failed: %d\n",
+					"sx8634_set_threshold()", err);
+	}
+
+	err = sx8634_spm_sync(sx);
+	if (err < 0)
+		return err;
+
+	err = sx8634_spm_load(sx);
+	if (err < 0)
+		return err;
+
+	/* enable individual cap sensitivity */
+	err = sx8634_spm_write(sx, SPM_CAP_MODE_MISC, 0x04);
+	if (err < 0)
+		return err;
+
+	/* enable capacitive sensors */
+	for (i = 0; i < SX8634_NUM_CAPS; i++) {
+		struct sx8634_cap *cap = &pdata->caps[i];
+
+		if (cap->mode == SX8634_CAP_MODE_BUTTON) {
+			input_set_capability(sx->input, EV_KEY, cap->keycode);
+			sx->keycodes[i] = cap->keycode;
+		}
+
+		if (cap->mode == SX8634_CAP_MODE_SLIDER) {
+			if (slider)
+				sx->slider_max += SLD_POS_STEP;
+
+			slider = true;
+		}
+
+		err = sx8634_set_mode(sx, i, cap->mode);
+		if (err < 0)
+			dev_err(&sx->client->dev, "%s failed: %d\n",
+					"sx8634_set_mode()", err);
+	}
+
+	err = sx8634_spm_sync(sx);
+	if (err < 0)
+		return err;
+
+	sx->input->id.bustype = BUS_I2C;
+	sx->input->id.product = 0;
+	sx->input->id.version = 0;
+	sx->input->name = "sx8634";
+	sx->input->dev.parent = &sx->client->dev;
+
+	/* setup slider */
+	if (slider) {
+		input_set_abs_params(sx->input, ABS_MISC, 0, sx->slider_max,
+				0, 0);
+		input_set_capability(sx->input, EV_ABS, ABS_MISC);
+	}
+
+	return 0;
+}
+
+static ssize_t sx8634_spm_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sx8634 *sx = i2c_get_clientdata(client);
+	ssize_t len = 0;
+	size_t i, j;
+	int err;
+
+	err = sx8634_spm_load(sx);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < SPM_SIZE; i += SPM_BLOCK_SIZE) {
+		const char *prefix = "";
+
+		for (j = 0; j < SPM_BLOCK_SIZE; j++) {
+			len += sprintf(buf + len, "%s%02x", prefix,
+					sx->spm_cache[i + j]);
+			prefix = " ";
+		}
+
+		len += sprintf(buf + len, "\n");
+	}
+
+	return len;
+}
+
+static DEVICE_ATTR(spm, 0664, sx8634_spm_show, NULL);
+
+static struct attribute *sx8634_attributes[] = {
+	&dev_attr_spm.attr,
+	NULL
+};
+
+static const struct attribute_group sx8634_attr_group = {
+	.attrs = sx8634_attributes,
+};
+
+static int sx8634_parse_dt(struct device *dev, struct sx8634_platform_data *pdata)
+{
+	struct device_node *node = dev->of_node;
+	struct device_node *child = NULL;
+	u32 sensitivity_def = 0x00;
+	u32 threshold_def = 0xa0;
+	int err;
+
+	if (!node)
+		return -ENODEV;
+
+	memset(pdata, 0, sizeof(*pdata));
+
+	err = of_property_read_u32(node, "threshold", &threshold_def);
+	if (err < 0) {
+	}
+
+	if (threshold_def > SPM_CAP_THRESHOLD_MAX) {
+		dev_info(dev, "invalid threshold: %u, using %u\n",
+				threshold_def, SPM_CAP_THRESHOLD_MAX);
+		threshold_def = SPM_CAP_THRESHOLD_MAX;
+	}
+
+	err = of_property_read_u32(node, "sensitivity", &sensitivity_def);
+	if (err < 0) {
+	}
+
+	if (sensitivity_def > SPM_CAP_SENS_MAX) {
+		dev_info(dev, "invalid sensitivity: %u, using %u\n",
+				sensitivity_def, SPM_CAP_SENS_MAX);
+		sensitivity_def = SPM_CAP_SENS_MAX;
+	}
+
+	while ((child = of_get_next_child(node, child))) {
+		u32 sensitivity = sensitivity_def;
+		u32 threshold = threshold_def;
+		struct sx8634_cap *cap;
+		u32 keycode;
+		u32 index;
+
+		err = of_property_read_u32(child, "reg", &index);
+		if (err < 0) {
+		}
+
+		if (index >= SX8634_NUM_CAPS) {
+			dev_err(dev, "invalid cap index: %u\n", index);
+			continue;
+		}
+
+		cap = &pdata->caps[index];
+
+		err = of_property_read_u32(child, "threshold", &threshold);
+		if (err < 0) {
+		}
+
+		cap->threshold = threshold;
+
+		err = of_property_read_u32(child, "sensitivity", &sensitivity);
+		if (err < 0) {
+		}
+
+		cap->sensitivity = sensitivity;
+
+		err = of_property_read_u32(child, "linux,code", &keycode);
+		if (err == 0) {
+			cap->mode = SX8634_CAP_MODE_BUTTON;
+			cap->keycode = keycode;
+		} else {
+			cap->mode = SX8634_CAP_MODE_SLIDER;
+		}
+	}
+
+	pdata->power_gpio = of_get_named_gpio(node, "power-gpios", 0);
+
+	return 0;
+}
+
+static int __devinit sx8634_i2c_probe(struct i2c_client *client,
+				      const struct i2c_device_id *id)
+{
+	struct sx8634_platform_data *pdata = client->dev.platform_data;
+	struct device_node *node = client->dev.of_node;
+	struct sx8634_platform_data defpdata;
+	struct sx8634 *sx;
+	int err = 0;
+
+	if (IS_ENABLED(CONFIG_OF) && node) {
+		client->irq = irq_of_parse_and_map(node, 0);
+		if (client->irq == NO_IRQ)
+			return -EPROBE_DEFER;
+	}
+
+	if (!pdata) {
+		if (!IS_ENABLED(CONFIG_OF))
+			return -ENODEV;
+
+		err = sx8634_parse_dt(&client->dev, &defpdata);
+		if (err < 0)
+			return err;
+
+		pdata = &defpdata;
+	}
+
+	sx = devm_kzalloc(&client->dev, sizeof(*sx), GFP_KERNEL);
+	if (!sx)
+		return -ENOMEM;
+
+	sx->spm_cache = devm_kzalloc(&client->dev, SPM_SIZE, GFP_KERNEL);
+	if (!sx->spm_cache)
+		return -ENOMEM;
+
+	sx->input = input_allocate_device();
+	if (!sx->input)
+		return -ENOMEM;
+
+	sx->power_gpio = pdata->power_gpio;
+	sx->client = client;
+
+	if (gpio_is_valid(sx->power_gpio)) {
+		err = gpio_request_one(sx->power_gpio, GPIOF_OUT_INIT_HIGH,
+				       "sx8634 power");
+		if (err < 0) {
+			dev_err(&client->dev,
+				"failed to request power GPIO#%u: %d\n",
+				sx->power_gpio, err);
+			goto free_input_device;
+		}
+
+		msleep(150);
+	}
+
+	err = sx8634_setup(sx, pdata);
+	if (err < 0)
+		goto free_power_gpio;
+
+	err = sysfs_create_group(&client->dev.kobj, &sx8634_attr_group);
+	if (err < 0)
+		goto free_power_gpio;
+
+	err = request_threaded_irq(client->irq, NULL, sx8634_irq, IRQF_ONESHOT,
+				   "sx8634", sx);
+	if (err < 0) {
+		dev_err(&client->dev, "can't allocate IRQ#%d\n", client->irq);
+		goto remove_sysfs;
+	}
+
+	/* clear interrupts */
+	err = i2c_smbus_read_byte_data(client, I2C_IRQ_SRC);
+	if (err < 0) {
+		dev_err(&client->dev, "can't clear interrupts: %d\n", err);
+		goto free_irq;
+	}
+
+	err = input_register_device(sx->input);
+	if (err < 0)
+		goto free_irq;
+
+	i2c_set_clientdata(client, sx);
+
+	return 0;
+
+free_irq:
+	free_irq(client->irq, sx);
+remove_sysfs:
+	sysfs_remove_group(&client->dev.kobj, &sx8634_attr_group);
+free_power_gpio:
+	if (gpio_is_valid(sx->power_gpio)) {
+		gpio_direction_output(sx->power_gpio, 0);
+		gpio_free(sx->power_gpio);
+	}
+free_input_device:
+	input_free_device(sx->input);
+	return err;
+}
+
+static int __devexit sx8634_i2c_remove(struct i2c_client *client)
+{
+	struct sx8634 *sx = i2c_get_clientdata(client);
+
+	free_irq(client->irq, sx);
+	input_unregister_device(sx->input);
+	sysfs_remove_group(&client->dev.kobj, &sx8634_attr_group);
+
+	if (gpio_is_valid(sx->power_gpio)) {
+		gpio_direction_output(sx->power_gpio, 0);
+		gpio_free(sx->power_gpio);
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id sx8634_i2c_ids[] = {
+	{ "sx8634", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sx8634_i2c_ids);
+
+#ifdef CONFIG_OF
+static const struct of_device_id sx8634_of_match[] = {
+	{ .compatible = "smtc,sx8634", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sx8634_of_match);
+#endif
+
+static struct i2c_driver sx8634_driver = {
+	.driver = {
+		.name = "sx8634",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(sx8634_of_match),
+	},
+	.probe = sx8634_i2c_probe,
+	.remove = __devexit_p(sx8634_i2c_remove),
+	.id_table = sx8634_i2c_ids,
+};
+module_i2c_driver(sx8634_driver);
+
+MODULE_AUTHOR("Thierry Reding <thierry.reding@avionic-design.de>");
+MODULE_DESCRIPTION("Semtech SX8634 Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/input/sx8634.h b/include/linux/input/sx8634.h
new file mode 100644
index 0000000..9b371fe
--- /dev/null
+++ b/include/linux/input/sx8634.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2011-2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_INPUT_SX8634_H__
+#define __LINUX_INPUT_SX8634_H__
+
+#define SX8634_NUM_CAPS 12
+
+enum sx8634_cap_mode {
+	SX8634_CAP_MODE_DISABLED,
+	SX8634_CAP_MODE_BUTTON,
+	SX8634_CAP_MODE_SLIDER,
+	SX8634_CAP_MODE_RESERVED
+};
+
+struct sx8634_cap {
+	enum sx8634_cap_mode mode;
+	unsigned short keycode;
+	u8 sensitivity;
+	u8 threshold;
+};
+
+struct sx8634_platform_data {
+	struct sx8634_cap caps[SX8634_NUM_CAPS];
+	int power_gpio;
+};
+
+#endif
-- 
1.7.11.2

