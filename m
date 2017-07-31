From: Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH v2] serio: PS2 gpio bit banging driver for the serio bus
Date: Tue,  1 Aug 2017 00:35:57 +0200
Message-ID: <20170731223557.23845-1-danilokrummrich@dk-develop.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs01.dk-develop.de ([213.136.71.231]:39407 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdGaWgA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Jul 2017 18:36:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linus.walleij@linaro.org

This driver provides PS2 serio bus support by implementing bit banging
with the GPIO API. The GPIO pins, data and clock, can be configured with
a node in the device tree or by static platform data.

Writing to a device is supported as well, though it is not recommended as
the timings to be halt given by libps2 are very tough and difficult to
reach with bit banging. Therefore it can be configured (also in DT and
pdata) whether the serio write function should be available for clients.

This driver is for development purposes and not for productive use.
However, this driver can be useful e.g. when no USB port is available or
using old peripherals is desired as PS2 controllers getting rare.

This driver was tested on a RPI1 and on Hikey960 and it worked well
together with the atkbd driver.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
v2: Removed one verbose print statement, changed another one to dev_dbg.
---
 .../devicetree/bindings/serio/ps2-gpio.txt         |  20 +
 Documentation/gpio/drivers-on-gpio.txt             |   5 +
 drivers/input/serio/Kconfig                        |  10 +
 drivers/input/serio/Makefile                       |   1 +
 drivers/input/serio/ps2-gpio.c                     | 438 +++++++++++++++++++++
 include/linux/ps2-gpio.h                           |  27 ++
 6 files changed, 501 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
 create mode 100644 drivers/input/serio/ps2-gpio.c
 create mode 100644 include/linux/ps2-gpio.h

diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.txt b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
new file mode 100644
index 0000000..828a5b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
@@ -0,0 +1,20 @@
+Device-Tree bindings for ps2 gpio driver
+
+Required properties:
+	- compatible = "ps2-gpio";
+	- gpios: data and clock gpio
+
+Optional properties:
+	- ps2-gpio,write-enable: Indicates whether write function is provided
+	to serio device. Most probably providing the write fn will not work,
+	because of the tough timing libps2 requires.
+
+Example nodes:
+
+ps2@0 {
+	compatible = "ps2-gpio";
+	gpios = <&gpio 24 0 /* data */
+		 &gpio 23 0 /* clock */
+		>;
+	i2c-gpio,write-enable = <0>;
+};
diff --git a/Documentation/gpio/drivers-on-gpio.txt b/Documentation/gpio/drivers-on-gpio.txt
index 3065132..b106e72 100644
--- a/Documentation/gpio/drivers-on-gpio.txt
+++ b/Documentation/gpio/drivers-on-gpio.txt
@@ -84,6 +84,11 @@ hardware descriptions such as device tree or ACPI:
   NAND flash MTD subsystem and provides chip access and partition parsing like
   any other NAND driving hardware.
 
+- ps2-gpio: drivers/input/serio/ps2-gpio.c is used to drive an PS2 serio bus,
+  data and clock line, by bit banging two GPIO lines. It will appear as any
+  other serio bus to the system and makes it possible to connect drivers for
+  e.g. keyboards and other PS2 protocol based devices.
+
 Apart from this there are special GPIO drivers in subsystems like MMC/SD to
 read card detect and write protect GPIO lines, and in the TTY serial subsystem
 to emulate MCTRL (modem control) signals CTS/RTS by using two GPIO lines. The
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index c3d05b4..abca0e0 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -292,6 +292,16 @@ config SERIO_SUN4I_PS2
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun4i-ps2.
 
+config SERIO_GPIO_PS2
+	tristate "GPIO PS/2 bit banging driver"
+	help
+	  Say Y here if you want PS/2 bit banging support via GPIO.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gpio-ps2.
+
+	  If you are unsure, say N.
+
 config USERIO
 	tristate "User space serio port driver support"
 	help
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
index 2374ef9..767bd9b 100644
--- a/drivers/input/serio/Makefile
+++ b/drivers/input/serio/Makefile
@@ -30,4 +30,5 @@ obj-$(CONFIG_SERIO_APBPS2)	+= apbps2.o
 obj-$(CONFIG_SERIO_OLPC_APSP)	+= olpc_apsp.o
 obj-$(CONFIG_HYPERV_KEYBOARD)	+= hyperv-keyboard.o
 obj-$(CONFIG_SERIO_SUN4I_PS2)	+= sun4i-ps2.o
+obj-$(CONFIG_SERIO_GPIO_PS2)	+= ps2-gpio.o
 obj-$(CONFIG_USERIO)		+= userio.o
diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
new file mode 100644
index 0000000..cc9287e
--- /dev/null
+++ b/drivers/input/serio/ps2-gpio.c
@@ -0,0 +1,438 @@
+/*
+ * GPIO based serio bus driver for bit banging the PS2 protocol
+ *
+ * Author: Danilo Krummrich <danilokrummrich@dk-develop.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+#include <linux/ps2-gpio.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/jiffies.h>
+#include <linux/delay.h>
+
+#define DRIVER_NAME		"ps2-gpio"
+
+#define PS2_MODE_RX		0
+#define PS2_MODE_TX		1
+
+#define PS2_START_BIT		0
+#define PS2_DATA_BIT0		1
+#define PS2_DATA_BIT1		2
+#define PS2_DATA_BIT2		3
+#define PS2_DATA_BIT3		4
+#define PS2_DATA_BIT4		5
+#define PS2_DATA_BIT5		6
+#define PS2_DATA_BIT6		7
+#define PS2_DATA_BIT7		8
+#define PS2_PARITY_BIT		9
+#define PS2_STOP_BIT		10
+#define PS2_ACK_BIT		11
+
+#define PS2_DEV_RET_ACK		0xfa
+#define PS2_DEV_RET_NACK	0xfe
+
+#define PS2_CMD_RESEND		0xfe
+
+struct ps2_gpio_data {
+	struct device *dev;
+	struct serio *serio;
+	unsigned char mode;
+	unsigned int gpio_clk;
+	unsigned int gpio_data;
+	unsigned int write_enable;
+	unsigned int irq;
+	unsigned char rx_cnt;
+	unsigned char rx_byte;
+	unsigned char tx_cnt;
+	unsigned char tx_byte;
+	struct delayed_work tx_work;
+};
+
+static int ps2_gpio_open(struct serio *serio)
+{
+	struct ps2_gpio_data *drvdata = serio->port_data;
+
+	enable_irq(drvdata->irq);
+	return 0;
+}
+
+static void ps2_gpio_close(struct serio *serio)
+{
+	struct ps2_gpio_data *drvdata = serio->port_data;
+
+	disable_irq(drvdata->irq);
+}
+
+static int ps2_gpio_write(struct serio *serio, unsigned char val)
+{
+	struct ps2_gpio_data *drvdata = serio->port_data;
+
+	drvdata->mode = PS2_MODE_TX;
+	drvdata->tx_byte = val;
+	/* Make sure ISR running on other CPU notice changes. */
+	barrier();
+	disable_irq_nosync(drvdata->irq);
+	gpio_direction_output(drvdata->gpio_clk, 0);
+	schedule_delayed_work(&drvdata->tx_work, usecs_to_jiffies(200));
+
+	return 0;
+}
+
+static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
+{
+	unsigned char byte, cnt;
+	int data;
+	int rxflags = 0;
+	static unsigned long old_jiffies;
+
+	byte = drvdata->rx_byte;
+	cnt = drvdata->rx_cnt;
+
+	if (old_jiffies == 0)
+		old_jiffies = jiffies;
+
+	if ((jiffies - old_jiffies) > usecs_to_jiffies(100)) {
+		dev_err(drvdata->dev,
+			"RX: timeout, probably we missed an interrupt\n");
+		goto err;
+	}
+	old_jiffies = jiffies;
+
+	data = gpio_get_value(drvdata->gpio_data);
+	if (unlikely(data < 0)) {
+		dev_err(drvdata->dev, "RX: failed to get gpio %u value: %d\n",
+			drvdata->gpio_data, data);
+		goto err;
+	}
+
+	switch (cnt) {
+	case PS2_START_BIT:
+		/* start bit should be low */
+		if (unlikely(data)) {
+			dev_err(drvdata->dev, "RX: start bit should be low\n");
+			goto err;
+		}
+		break;
+	case PS2_DATA_BIT0:
+	case PS2_DATA_BIT1:
+	case PS2_DATA_BIT2:
+	case PS2_DATA_BIT3:
+	case PS2_DATA_BIT4:
+	case PS2_DATA_BIT5:
+	case PS2_DATA_BIT6:
+	case PS2_DATA_BIT7:
+		/* processing data bits */
+		if (data)
+			byte |= (data << (cnt - 1));
+		break;
+	case PS2_PARITY_BIT:
+		/* check odd parity */
+		if (!((hweight8(byte) & 1) ^ data)) {
+			rxflags |= SERIO_PARITY;
+			dev_warn(drvdata->dev, "RX: parity error\n");
+			if (!drvdata->write_enable)
+				goto err;
+		}
+		/* Let's send the data without waiting for the stop bit to be
+		 * sent. It may happen that we miss the stop bit. When this
+		 * happens we have no way to recover from this, certainly
+		 * missing the parity bit would be recognized when processing
+		 * the stop bit. When missing both, data is lost.
+		 * Additionally, we do not send spurious ACK's and NACK's.
+		 */
+		if (byte == PS2_DEV_RET_NACK)
+			goto err;
+		if (byte == PS2_DEV_RET_ACK)
+			break;
+		serio_interrupt(drvdata->serio, byte, rxflags);
+		dev_dbg(drvdata->dev, "RX: sending byte 0x%x\n", byte);
+		break;
+	case PS2_STOP_BIT:
+		/* stop bit should be high */
+		if (unlikely(!data)) {
+			dev_err(drvdata->dev, "RX: stop bit should be high\n");
+			goto err;
+		}
+		cnt = byte = 0;
+		old_jiffies = 0;
+		goto end; /* success */
+	default:
+		dev_err(drvdata->dev, "RX: got out of sync with the device\n");
+		goto err;
+	}
+
+	cnt++;
+	goto end; /* success */
+
+err:
+	cnt = byte = 0;
+	old_jiffies = 0;
+	ps2_gpio_write(drvdata->serio, PS2_CMD_RESEND);
+end:
+	drvdata->rx_cnt = cnt;
+	drvdata->rx_byte = byte;
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
+{
+	unsigned char byte, cnt;
+	int data;
+	static unsigned long old_jiffies;
+
+	cnt = drvdata->tx_cnt;
+	byte = drvdata->tx_byte;
+
+	if (old_jiffies == 0)
+		old_jiffies = jiffies;
+
+	if ((jiffies - old_jiffies) > usecs_to_jiffies(100)) {
+		dev_err(drvdata->dev,
+			"TX: timeout, probably we missed an interrupt\n");
+		goto err;
+	}
+	old_jiffies = jiffies;
+
+	switch (cnt) {
+	case PS2_START_BIT:
+		/* should never happen */
+		dev_err(drvdata->dev,
+			"TX: start bit should have been sent already\n");
+		goto err;
+	case PS2_DATA_BIT0:
+	case PS2_DATA_BIT1:
+	case PS2_DATA_BIT2:
+	case PS2_DATA_BIT3:
+	case PS2_DATA_BIT4:
+	case PS2_DATA_BIT5:
+	case PS2_DATA_BIT6:
+	case PS2_DATA_BIT7:
+		data = byte & (1 << (cnt - 1));
+		break;
+	case PS2_PARITY_BIT:
+		/* do odd parity */
+		data = !(hweight8(byte) & 1);
+		break;
+	case PS2_STOP_BIT:
+		/* release data line to generate stop bit */
+		gpio_direction_input(drvdata->gpio_data);
+		break;
+	case PS2_ACK_BIT:
+		gpio_direction_input(drvdata->gpio_data);
+		data = gpio_get_value(drvdata->gpio_data);
+		if (data)
+			dev_warn(drvdata->dev, "TX: received NACK, retry\n");
+		if (data)
+			goto err;
+		drvdata->mode = PS2_MODE_RX;
+		/* Make sure ISR running on other CPU notice mode change. */
+		barrier();
+		cnt = 1;
+		old_jiffies = 0;
+		goto end; /* success */
+	default:
+		/* Probably we missed the stop bit. Therefore we release data
+		 * line and try again.
+		 */
+		gpio_direction_input(drvdata->gpio_data);
+		dev_err(drvdata->dev, "TX: got out of sync with the device\n");
+		goto err;
+	}
+
+	gpio_set_value(drvdata->gpio_data, data);
+	cnt++;
+	goto end; /* success */
+
+err:
+	cnt = 1;
+	old_jiffies = 0;
+	gpio_direction_input(drvdata->gpio_data);
+	ps2_gpio_write(drvdata->serio, PS2_CMD_RESEND);
+end:
+	drvdata->tx_cnt = cnt;
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ps2_gpio_irq(int irq, void *dev_id)
+{
+	struct ps2_gpio_data *drvdata = dev_id;
+
+	return drvdata->mode ? ps2_gpio_irq_tx(drvdata) :
+		ps2_gpio_irq_rx(drvdata);
+}
+
+static void ps2_gpio_tx_work_fn(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct ps2_gpio_data *drvdata = container_of(dwork,
+						    struct ps2_gpio_data,
+						    tx_work);
+	enable_irq(drvdata->irq);
+	gpio_direction_output(drvdata->gpio_data, 0);
+	gpio_direction_input(drvdata->gpio_clk);
+}
+
+static int of_ps2_gpio_get_props(struct device *dev,
+				 struct ps2_gpio_data *drvdata)
+{
+	if (of_gpio_count(dev->of_node) < 2)
+		return -ENODEV;
+
+	drvdata->gpio_data = of_get_gpio(dev->of_node, 0);
+	drvdata->gpio_clk = of_get_gpio(dev->of_node, 1);
+
+	if (drvdata->gpio_data == -EPROBE_DEFER ||
+	    drvdata->gpio_clk == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (!gpio_is_valid(drvdata->gpio_data) ||
+	    !gpio_is_valid(drvdata->gpio_clk)) {
+		dev_err(dev, "invalid GPIOs, data=%d, clk=%d\n",
+			drvdata->gpio_data, drvdata->gpio_clk);
+		return -ENODEV;
+	}
+
+	of_property_read_u32(dev->of_node, "ps2-gpio,write-enable",
+			     &drvdata->write_enable);
+
+	return 0;
+}
+
+static int ps2_gpio_probe(struct platform_device *pdev)
+{
+	struct ps2_gpio_data *drvdata;
+	struct ps2_gpio_platform_data *pdata;
+	struct serio *serio;
+	struct device *dev = &pdev->dev;
+	unsigned int irq;
+	int error;
+
+	drvdata = devm_kzalloc(dev, sizeof(struct ps2_gpio_data), GFP_KERNEL);
+	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!drvdata || !serio) {
+		error = -ENOMEM;
+		goto err_free_serio;
+	}
+
+	if (dev->of_node) {
+		error = of_ps2_gpio_get_props(dev, drvdata);
+		if (error)
+			goto err_free_serio;
+	} else {
+		if (!dev_get_platdata(dev)) {
+			error = -ENXIO;
+			goto err_free_serio;
+		}
+		pdata = dev_get_platdata(dev);
+		drvdata->gpio_data = pdata->gpio_data;
+		drvdata->gpio_clk = pdata->gpio_clk;
+		drvdata->write_enable = pdata->write_enable;
+	}
+
+	error = devm_gpio_request(dev, drvdata->gpio_clk, "ps2 clk");
+	if (error) {
+		dev_err(dev, "failed to request gpio %u: %d",
+				drvdata->gpio_clk, error);
+		goto err_free_serio;
+	}
+
+	error = devm_gpio_request(dev, drvdata->gpio_data, "ps2 data");
+	if (error) {
+		dev_err(dev, "failed to request gpio %u: %d",
+				drvdata->gpio_data, error);
+		goto err_free_serio;
+	}
+
+	gpio_direction_input(drvdata->gpio_clk);
+	gpio_direction_input(drvdata->gpio_data);
+
+	irq = gpio_to_irq(drvdata->gpio_clk);
+	if (!irq) {
+		dev_err(dev, "cannot get irq from gpio %u\n",
+			drvdata->gpio_clk);
+		error = -ENXIO;
+		goto err_free_serio;
+	}
+
+	error = devm_request_irq(dev, irq, ps2_gpio_irq, IRQF_NO_THREAD |
+			IRQF_TRIGGER_FALLING, DRIVER_NAME, drvdata);
+	if (error) {
+		dev_err(dev, "failed to request irq %u: %d\n",
+			drvdata->irq, error);
+		goto err_free_serio;
+	}
+
+	serio->id.type = SERIO_8042;
+	serio->open = ps2_gpio_open;
+	serio->close = ps2_gpio_close;
+	/* Write can be enabled in platform/dt data, but most probably it will
+	 * not work because of the tough timings.
+	 */
+	serio->write = drvdata->write_enable ? ps2_gpio_write : NULL;
+	serio->port_data = drvdata;
+	serio->dev.parent = dev;
+	strlcpy(serio->name, dev_name(dev), sizeof(serio->name));
+	strlcpy(serio->phys, dev_name(dev), sizeof(serio->phys));
+
+	drvdata->irq = irq;
+	drvdata->serio = serio;
+	drvdata->dev = dev;
+	drvdata->mode = PS2_MODE_RX;
+
+	/* Tx count always starts at 1, as the start bit is sent implicitly by
+	 * host-to-device communication initialization.
+	 */
+	drvdata->tx_cnt = 1;
+
+	INIT_DELAYED_WORK(&drvdata->tx_work, ps2_gpio_tx_work_fn);
+
+	serio_register_port(serio);
+	platform_set_drvdata(pdev, drvdata);
+
+	return 0;	/* success */
+
+err_free_serio:
+	kfree(serio);
+	return error;
+}
+
+static int ps2_gpio_remove(struct platform_device *pdev)
+{
+	struct ps2_gpio_data *drvdata = platform_get_drvdata(pdev);
+
+	serio_unregister_port(drvdata->serio);
+	return 0;
+}
+
+#if defined(CONFIG_OF)
+static const struct of_device_id ps2_gpio_match[] = {
+	{ .compatible = "ps2-gpio", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ps2_gpio_match);
+#endif
+
+static struct platform_driver ps2_gpio_driver = {
+	.probe		= ps2_gpio_probe,
+	.remove		= ps2_gpio_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = ps2_gpio_match,
+	},
+};
+module_platform_driver(ps2_gpio_driver);
+
+MODULE_AUTHOR("Danilo Krummrich <danilokrummrich@dk-develop.de>");
+MODULE_DESCRIPTION("GPIO PS2 driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/ps2-gpio.h b/include/linux/ps2-gpio.h
new file mode 100644
index 0000000..b65480d
--- /dev/null
+++ b/include/linux/ps2-gpio.h
@@ -0,0 +1,27 @@
+/*
+ * ps2-gpio interface to platform code
+ *
+ * Author: Danilo Krummrich <danilokrummrich@dk-develop.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _LINUX_PS2_GPIO_H
+#define _LINUX_PS2_GPIO_H
+
+/**
+ * struct ps2_gpio_platform_data - Platform-dependent data for ps2-gpio
+ * @gpio_data: GPIO pin ID to use for DATA
+ * @gpio_clk: GPIO pin ID to use for CLOCK
+ * @write_enable: Indicates whether write function is provided to serio
+ *	device. Most probably providing the write fn will not work,
+ *	because of the tough timing libps2 requires.
+ */
+struct ps2_gpio_platform_data {
+	unsigned int	gpio_data;
+	unsigned int	gpio_clk;
+	unsigned int	write_enable;
+};
+
+#endif /* _LINUX_PS2_GPIO_H */
-- 
2.9.3

