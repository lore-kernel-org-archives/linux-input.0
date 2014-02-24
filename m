From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: Add F30 support
Date: Mon, 24 Feb 2014 14:53:27 -0800
Message-ID: <1393282407-3759-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:64849 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbaBXWxb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Feb 2014 17:53:31 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Allie Xiong <axiong@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

RMI4 Function 0x30 provides support for GPIOs, LEDs and mechanical
buttons.  In particular, the mechanical button support is used in
an increasing number of touchpads.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Allie Xiong <axiong@synaptics.com>
Acked-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

 drivers/input/rmi4/Kconfig   |  12 +
 drivers/input/rmi4/Makefile  |   1 +
 drivers/input/rmi4/rmi_f30.c | 618 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/rmi.h          |   7 +-
 4 files changed, 637 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index d0c7b6e..14d5f49 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -63,3 +63,15 @@ config RMI4_F11_PEN
 	  If your system is not recognizing pen touches and you know your
 	  sensor supports pen input, you probably want to turn this feature
 	  off.
+
+config RMI4_F30
+        tristate "RMI4 Function 30 (GPIO LED)"
+        depends on RMI4_CORE
+        help
+          Say Y here if you want to add support for RMI4 function 30.
+
+          Function 30 provides GPIO and LED support for RMI4 devices. This
+	  includes support for buttons on TouchPads and ClickPads.
+
+          To compile this driver as a module, choose M here: the
+          module will be called rmi-f30.
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 5c6bad5..ecffd72 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -3,6 +3,7 @@ rmi_core-y := rmi_bus.o rmi_driver.o rmi_f01.o
 
 # Function drivers
 obj-$(CONFIG_RMI4_F11) += rmi_f11.o
+obj-$(CONFIG_RMI4_F30) += rmi_f30.o
 
 # Transports
 obj-$(CONFIG_RMI4_I2C) += rmi_i2c.o
diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
new file mode 100644
index 0000000..9c711eb
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -0,0 +1,618 @@
+/*
+ * Copyright (c) 2012 - 2014 Synaptics Incorporated
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/rmi.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include "rmi_driver.h"
+
+#define RMI_F30_QUERY_SIZE			2
+
+ /* Defs for Query 0 */
+#define RMI_F30_EXTENDED_PATTERNS		0x01
+#define RMI_F30_HAS_MAPPABLE_BUTTONS		(1 << 1)
+#define RMI_F30_HAS_LED				(1 << 2)
+#define RMI_F30_HAS_GPIO			(1 << 3)
+#define RMI_F30_HAS_HAPTIC			(1 << 4)
+#define RMI_F30_HAS_GPIO_DRV_CTL		(1 << 5)
+#define RMI_F30_HAS_MECH_MOUSE_BTNS		(1 << 6)
+
+/* Defs for Query 1 */
+#define RMI_F30_GPIO_LED_COUNT			0x1F
+
+/* Defs for Control Registers */
+#define RMI_F30_CTRL_1_GPIO_DEBOUNCE		0x01
+#define RMI_F30_CTRL_1_HALT			(1 << 4)
+#define RMI_F30_CTRL_1_HALTED			(1 << 5)
+#define RMI_F30_CTRL_10_NUM_MECH_MOUSE_BTNS	0x03
+
+#define RMI_F30_CTRL_DATA(ctrl_num, max_size) \
+struct rmi_f30_ctrl##ctrl_num##_data { \
+	int address; \
+	int length; \
+	u8 regs[max_size]; \
+}
+
+#define RMI_F30_CTRL_MAX_REGS	32
+#define RMI_F30_CTRL_MAX_BYTES	((RMI_F30_CTRL_MAX_REGS + 7) >> 3)
+
+struct f30_data {
+	/* Query Data */
+	bool has_extended_pattern;
+	bool has_mappable_buttons;
+	bool has_led;
+	bool has_gpio;
+	bool has_haptic;
+	bool has_gpio_driver_control;
+	bool has_mech_mouse_btns;
+	u8 gpioled_count;
+
+	u8 register_count;
+
+	/* Control Register Data */
+	RMI_F30_CTRL_DATA(0, RMI_F30_CTRL_MAX_BYTES)	ctrl_0;
+	RMI_F30_CTRL_DATA(1, 1)				ctrl_1;
+	RMI_F30_CTRL_DATA(2, RMI_F30_CTRL_MAX_BYTES)	ctrl_2;
+	RMI_F30_CTRL_DATA(3, RMI_F30_CTRL_MAX_BYTES)	ctrl_3;
+	RMI_F30_CTRL_DATA(4, RMI_F30_CTRL_MAX_BYTES)	ctrl_4;
+	RMI_F30_CTRL_DATA(5, 6)				ctrl_5;
+	RMI_F30_CTRL_DATA(6, RMI_F30_CTRL_MAX_REGS)	ctrl_6;
+	RMI_F30_CTRL_DATA(7, RMI_F30_CTRL_MAX_REGS)	ctrl_7;
+	RMI_F30_CTRL_DATA(8, RMI_F30_CTRL_MAX_BYTES)	ctrl_8;
+	RMI_F30_CTRL_DATA(9, 1)				ctrl_9;
+	RMI_F30_CTRL_DATA(10, 1)			ctrl_10;
+
+	u8 data_regs[RMI_F30_CTRL_MAX_BYTES];
+	struct rmi_f30_button *gpioled_map;
+
+	char input_phys[NAME_BUFFER_SIZE];
+	struct input_dev *input;
+};
+
+static int rmi_f30_read_control_parameters(struct rmi_device *rmi_dev,
+	struct f30_data *f30)
+{
+	int retval = 0;
+
+	if (f30->ctrl_0.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_0.address,
+				f30->ctrl_0.regs, f30->ctrl_0.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg0 to 0x%x\n",
+				__func__, f30->ctrl_0.address);
+			return retval;
+		}
+	}
+
+	if (f30->ctrl_1.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_1.address,
+				f30->ctrl_1.regs, f30->ctrl_1.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg1 to 0x%x\n",
+				 __func__, f30->ctrl_1.address);
+			return retval;
+		}
+	}
+
+	if (f30->ctrl_2.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_2.address,
+				f30->ctrl_2.regs, f30->ctrl_2.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg2 to 0x%x\n",
+				 __func__, f30->ctrl_2.address);
+			return retval;
+		}
+	}
+
+	if (f30->ctrl_3.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_3.address,
+				f30->ctrl_3.regs, f30->ctrl_3.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg3 to 0x%x\n",
+				 __func__, f30->ctrl_3.address);
+			return retval;
+		}
+	}
+
+	if (f30->ctrl_4.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_4.address,
+				f30->ctrl_4.regs, f30->ctrl_4.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg4 to 0x%x\n",
+				 __func__, f30->ctrl_4.address);
+			return retval;
+		}
+	}
+
+	if (f30->ctrl_5.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_5.address,
+				f30->ctrl_5.regs, f30->ctrl_5.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg5 to 0x%x\n",
+				 __func__, f30->ctrl_5.address);
+			return retval;
+		}
+	}
+
+	if (f30->ctrl_6.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_6.address,
+				f30->ctrl_6.regs, f30->ctrl_6.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg6 to 0x%x\n",
+				 __func__, f30->ctrl_6.address);
+			return retval;
+		}
+	}
+
+	if (f30->ctrl_7.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_7.address,
+				f30->ctrl_1.regs, f30->ctrl_7.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg7 to 0x%x\n",
+				 __func__, f30->ctrl_7.address);
+			return retval;
+		}
+	}
+
+	if (f30->ctrl_8.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_8.address,
+				f30->ctrl_8.regs, f30->ctrl_8.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg8 to 0x%x\n",
+				 __func__, f30->ctrl_8.address);
+			return retval;
+		}
+	}
+
+	if (f30->ctrl_9.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_9.address,
+				f30->ctrl_9.regs, f30->ctrl_9.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg9 to 0x%x\n",
+				 __func__, f30->ctrl_9.address);
+			return retval;
+		}
+	}
+
+	if (f30->ctrl_10.length) {
+		retval = rmi_read_block(rmi_dev, f30->ctrl_10.address,
+				f30->ctrl_10.regs, f30->ctrl_10.length);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"%s : Could not read control reg1 to 0x%x\n",
+				 __func__, f30->ctrl_10.address);
+			return retval;
+		}
+	}
+
+	return 0;
+}
+
+static int rmi_f30_attention(struct rmi_function *fn,
+					unsigned long *irq_bits)
+{
+	struct f30_data *f30 = fn->data;
+	int retval;
+	int gpiled = 0;
+	int value = 0;
+	int i;
+	int reg_num;
+
+	/* Read the gpi led data. */
+	retval = rmi_read_block(fn->rmi_dev, fn->fd.data_base_addr,
+		f30->data_regs, f30->register_count);
+
+	if (retval < 0) {
+		dev_err(&fn->dev, "%s: Failed to read F30 data registers.\n",
+			__func__);
+		return retval;
+	}
+
+	for (reg_num = 0; reg_num < f30->register_count; ++reg_num) {
+		for (i = 0; gpiled < f30->gpioled_count && i < 8; ++i,
+			++gpiled) {
+			if (f30->gpioled_map[gpiled].button != 0) {
+				value = (((f30->data_regs[reg_num] >> i) & 0x01)
+					 == f30->gpioled_map[gpiled].sense);
+
+				dev_dbg(&fn->dev,
+					"%s: call input report key (0x%04x) value (0x%02x)",
+					__func__,
+					f30->gpioled_map[gpiled].button, value);
+				input_report_key(f30->input,
+					f30->gpioled_map[gpiled].button,
+					value);
+			}
+
+		}
+	}
+
+	input_sync(f30->input); /* sync after groups of events */
+	return 0;
+}
+
+static int rmi_f30_register_device(struct rmi_function *fn)
+{
+	int i;
+	int rc;
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	struct f30_data *f30 = fn->data;
+	struct rmi_driver *driver = fn->rmi_dev->driver;
+	struct input_dev *input_dev = input_allocate_device();
+
+	if (!input_dev) {
+		dev_err(&fn->dev, "Failed to allocate input device.\n");
+		return -ENOMEM;
+	}
+
+	f30->input = input_dev;
+
+	if (driver->set_input_params) {
+		rc = driver->set_input_params(rmi_dev, input_dev);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s: Error in setting input device.\n",
+				__func__);
+			goto error_free_device;
+		}
+	}
+	sprintf(f30->input_phys, "%s/input0", dev_name(&fn->dev));
+	input_dev->phys = f30->input_phys;
+	input_dev->dev.parent = &rmi_dev->dev;
+	input_set_drvdata(input_dev, f30);
+
+	/* Set up any input events. */
+	set_bit(EV_SYN, input_dev->evbit);
+	set_bit(EV_KEY, input_dev->evbit);
+	input_dev->keycode = f30->gpioled_map;
+	input_dev->keycodesize = 1;
+	input_dev->keycodemax = f30->gpioled_count;
+	/* set bits for each qpio led pin... */
+	for (i = 0; i < f30->gpioled_count; i++) {
+		if (f30->gpioled_map[i].button != 0) {
+			set_bit(f30->gpioled_map[i].button, input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY,
+						f30->gpioled_map[i].button);
+		}
+	}
+
+	rc = input_register_device(input_dev);
+	if (rc < 0) {
+		dev_err(&fn->dev, "Failed to register input device.\n");
+		goto error_free_device;
+	}
+	return 0;
+
+error_free_device:
+	input_free_device(input_dev);
+
+	return rc;
+}
+
+static int rmi_f30_config(struct rmi_function *fn)
+{
+	struct f30_data *f30 = fn->data;
+	int rc;
+
+	/* Write Control Register values back to device */
+	if (f30->ctrl_0.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_0.address,
+					f30->ctrl_0.regs,
+					f30->ctrl_0.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 0 to 0x%x\n",
+				__func__, rc, f30->ctrl_0.address);
+			return rc;
+		}
+	}
+
+	if (f30->ctrl_1.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_1.address,
+					f30->ctrl_1.regs,
+					f30->ctrl_1.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 1 to 0x%x\n",
+					__func__, rc, f30->ctrl_1.address);
+			return rc;
+		}
+	}
+
+	if (f30->ctrl_2.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_2.address,
+					f30->ctrl_2.regs,
+					f30->ctrl_2.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 2 to 0x%x\n",
+					__func__, rc, f30->ctrl_2.address);
+			return rc;
+		}
+	}
+
+	if (f30->ctrl_3.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_3.address,
+					f30->ctrl_3.regs,
+					f30->ctrl_3.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 3 to 0x%x\n",
+				__func__, rc, f30->ctrl_3.address);
+			return rc;
+		}
+	}
+
+	if (f30->ctrl_4.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_4.address,
+					f30->ctrl_4.regs,
+					f30->ctrl_4.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 4 to 0x%x\n",
+				__func__, rc, f30->ctrl_4.address);
+			return rc;
+		}
+	}
+
+	if (f30->ctrl_5.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_5.address,
+					f30->ctrl_5.regs,
+					f30->ctrl_5.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 5 to 0x%x\n",
+				__func__, rc, f30->ctrl_5.address);
+			return rc;
+		}
+	}
+
+	if (f30->ctrl_6.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_6.address,
+					f30->ctrl_6.regs,
+					f30->ctrl_6.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 6 to 0x%x\n",
+				__func__, rc, f30->ctrl_6.address);
+			return rc;
+		}
+	}
+
+	if (f30->ctrl_7.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_7.address,
+					f30->ctrl_7.regs,
+					f30->ctrl_7.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 7 to 0x%x\n",
+				__func__, rc, f30->ctrl_7.address);
+			return rc;
+		}
+	}
+
+	if (f30->ctrl_8.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_8.address,
+					f30->ctrl_8.regs,
+					f30->ctrl_8.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 8 to 0x%x\n",
+				__func__, rc, f30->ctrl_8.address);
+			return rc;
+		}
+	}
+
+	if (f30->ctrl_9.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_9.address,
+					f30->ctrl_9.regs,
+					f30->ctrl_9.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 9 to 0x%x\n",
+				__func__, rc, f30->ctrl_9.address);
+			return rc;
+		}
+	}
+
+	if (f30->ctrl_10.length) {
+		rc = rmi_write_block(fn->rmi_dev, f30->ctrl_10.address,
+					f30->ctrl_10.regs,
+					f30->ctrl_10.length);
+		if (rc < 0) {
+			dev_err(&fn->dev, "%s error %d: Could not write control 10 to 0x%x\n",
+				__func__, rc, f30->ctrl_10.address);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+static inline int rmi_f30_initialize(struct rmi_function *fn)
+{
+	struct f30_data *f30;
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	struct rmi_device_platform_data *pdata;
+	int retval = 0;
+	int control_address;
+	u8 buf[RMI_F30_QUERY_SIZE];
+
+	f30 = devm_kzalloc(&fn->dev, sizeof(struct f30_data),
+			   GFP_KERNEL);
+	if (!f30) {
+		dev_err(&fn->dev, "Failed to allocate f30_data.\n");
+		return -ENOMEM;
+	}
+	fn->data = f30;
+
+	retval = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr, buf,
+				RMI_F30_QUERY_SIZE);
+
+	if (retval < 0) {
+		dev_err(&fn->dev, "Failed to read query register.\n");
+		return retval;
+	}
+
+	f30->has_extended_pattern = buf[0] & RMI_F30_EXTENDED_PATTERNS;
+	f30->has_mappable_buttons = buf[0] & RMI_F30_HAS_MAPPABLE_BUTTONS;
+	f30->has_led = buf[0] & RMI_F30_HAS_LED;
+	f30->has_gpio = buf[0] & RMI_F30_HAS_GPIO;
+	f30->has_haptic = buf[0] & RMI_F30_HAS_HAPTIC;
+	f30->has_gpio_driver_control = buf[0] & RMI_F30_HAS_GPIO_DRV_CTL;
+	f30->has_mech_mouse_btns = buf[0] & RMI_F30_HAS_MECH_MOUSE_BTNS;
+	f30->gpioled_count = buf[1] & RMI_F30_GPIO_LED_COUNT;
+
+	f30->register_count = (f30->gpioled_count + 7) >> 3;
+
+	control_address = fn->fd.control_base_addr;
+
+	/* Allocate buffers for the control registers */
+	if (f30->has_led && f30->has_led) {
+		f30->ctrl_0.address = control_address;
+		f30->ctrl_0.length = f30->register_count;
+		control_address += f30->ctrl_0.length;
+	}
+
+	f30->ctrl_1.address = control_address;
+	f30->ctrl_1.length = sizeof(u8);
+	control_address += f30->ctrl_1.length;
+
+	if (f30->has_gpio) {
+		f30->ctrl_2.address = control_address;
+		f30->ctrl_2.length = f30->register_count;
+		control_address += f30->ctrl_2.length;
+
+		f30->ctrl_3.address = control_address;
+		f30->ctrl_3.length = f30->register_count;
+		control_address += f30->ctrl_3.length;
+	}
+
+	if (f30->has_led) {
+		f30->ctrl_4.address = control_address;
+		f30->ctrl_4.length = f30->register_count;
+		control_address += f30->ctrl_4.length;
+
+		if (f30->has_extended_pattern)
+			f30->ctrl_5.length = 6;
+		else
+			f30->ctrl_5.length = 2;
+
+		f30->ctrl_5.address = control_address;
+		control_address += f30->ctrl_5.length;
+	}
+
+	if (f30->has_led || f30->has_gpio_driver_control) {
+		/* control 6 uses a byte per gpio/led */
+		f30->ctrl_6.address = control_address;
+		f30->ctrl_6.length = f30->gpioled_count;
+		control_address += f30->ctrl_6.length;
+
+	}
+
+	if (f30->has_mappable_buttons) {
+		/* control 7 uses a byte per gpio/led */
+		f30->ctrl_7.address = control_address;
+		f30->ctrl_7.length = f30->gpioled_count;
+		control_address += f30->ctrl_7.length;
+	}
+
+	if (f30->has_haptic) {
+		f30->ctrl_8.address = control_address;
+		f30->ctrl_8.length = f30->register_count;
+		control_address += f30->ctrl_8.length;
+
+		f30->ctrl_9.address = control_address;
+		f30->ctrl_9.length = sizeof(u8);
+		control_address += f30->ctrl_9.length;
+	}
+
+	if (f30->has_mech_mouse_btns) {
+		f30->ctrl_10.address = control_address;
+		f30->ctrl_10.length = sizeof(u8);
+		control_address += f30->ctrl_10.length;
+	}
+
+	f30->gpioled_map = devm_kzalloc(&fn->dev,
+				f30->gpioled_count
+				* sizeof(struct rmi_f30_button),
+				GFP_KERNEL);
+	if (!f30->gpioled_map) {
+		dev_err(&fn->dev, "Failed to allocate button map.\n");
+		return -ENOMEM;
+	}
+
+	pdata = to_rmi_platform_data(rmi_dev);
+	if (pdata) {
+		if (!pdata->gpioled_map) {
+			dev_warn(&fn->dev,
+				"%s - gpioled_map is NULL", __func__);
+		} else if (pdata->gpioled_map->ngpioleds < f30->gpioled_count) {
+			dev_warn(&fn->dev,
+				"Platform Data gpioled map size (%d) is less then the number of buttons on device (%d) - ignored\n",
+				pdata->gpioled_map->ngpioleds,
+				f30->gpioled_count);
+		} else if (!pdata->gpioled_map->map) {
+			dev_warn(&fn->dev,
+				 "Platform Data button map is missing!\n");
+		} else {
+			int i;
+			for (i = 0; i < f30->gpioled_count; i++)
+				memcpy(&f30->gpioled_map[i],
+					&pdata->gpioled_map->map[i],
+					sizeof(struct rmi_f30_button));
+		}
+	}
+
+	retval = rmi_f30_read_control_parameters(rmi_dev, f30);
+	if (retval < 0) {
+		dev_err(&fn->dev,
+			"Failed to initialize F19 control params.\n");
+		return retval;
+	}
+
+	return 0;
+}
+
+static int rmi_f30_probe(struct rmi_function *fn)
+{
+	int rc;
+
+	rc = rmi_f30_initialize(fn);
+	if (rc < 0)
+		goto error_exit;
+
+	rc = rmi_f30_register_device(fn);
+	if (rc < 0)
+		goto error_exit;
+
+	return 0;
+
+error_exit:
+	return rc;
+
+}
+
+static struct rmi_function_handler rmi_f30_handler = {
+	.driver = {
+		.name = "rmi_f30",
+	},
+	.func = 0x30,
+	.probe = rmi_f30_probe,
+	.config = rmi_f30_config,
+	.attention = rmi_f30_attention,
+};
+
+module_rmi_driver(rmi_f30_handler);
+
+MODULE_AUTHOR("Allie Xiong <axiong@synaptics.com>");
+MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com>");
+MODULE_DESCRIPTION("RMI F30 module");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 735e978..889a627 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -139,9 +139,14 @@ struct rmi_button_map {
 	u8 *map;
 };
 
+struct rmi_f30_button {
+	u16 button;
+	int sense;
+};
+
 struct rmi_f30_gpioled_map {
 	u8 ngpioleds;
-	u8 *map;
+	struct rmi_f30_button *map;
 };
 
 /**
