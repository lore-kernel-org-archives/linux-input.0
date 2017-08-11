From: Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH] serio: PS/2 gpio bit banging driver for serio bus
Date: Fri, 11 Aug 2017 15:02:30 +0200
Message-ID: <20170811130230.870-1-danilokrummrich@dk-develop.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs01.dk-develop.de ([213.136.71.231]:58939 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbdHKNCp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Aug 2017 09:02:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, rdunlap@infradead.org, devicetree@vger.kernel.org
Cc: Danilo Krummrich <danilokrummrich@dk-develop.de>

This driver provides PS/2 serio bus support by implementing bit banging
with the GPIO API. The GPIO pins, data and clock, can be configured with
a node in the device tree or by generic device properties (GDP).

Writing to a device is supported as well, though it is possible timings
can not be halt as they are tough and difficult to reach with bit banging.
Therefore it can be configured (also in DT and GDP) whether the serio
write function should be available for clients.

This driver is for development purposes and not recommended for productive
use. However, this driver can be useful e.g. when no USB port is available
or using old peripherals is desired as PS/2 controller chips getting rare.

This driver was tested on RPI1 and on Hikey960 and it worked well together
with the atkbd and psmouse driver.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
v2: Removed one verbose print statement, changed another one to dev_dbg.
v3: - fixed compiler warning on blackfin
    - depends on GPIOLIB
    - clarify documentation
v4: - fixed concurrent calls to ps2_gpio_write (serio->write)
    - use gpiod API
    - use generic device properties
    - request irq separately, do not use gpiod_to_irq
    - abort when gpio is connected via slow bus
    - Fixed a bug where PS2_CMD_RESEND is always send after tx failed once.
      The makes the write functionallity work better, tough timing is still
      critical.
    - disable irq initially until ps2_gpip_open (serio->open) is called
v5: Checked again why timings are that hard to reach while in tx mode and
    discovered that there is an extra clock pulse between stop bit sent from
    host and acknowledgement from device. By just skipping this clock pulse
    tx works fine now, though it still happens sometimes that the timing can
    not be reached of course.
v6: - fixed typos
    - use of_match_ptr
v7: remove unnecessary barriers
---
 .../devicetree/bindings/serio/ps2-gpio.txt         |  22 +
 Documentation/gpio/drivers-on-gpio.txt             |   5 +
 drivers/input/serio/Kconfig                        |  11 +
 drivers/input/serio/Makefile                       |   1 +
 drivers/input/serio/ps2-gpio.c                     | 453 +++++++++++++++++++++
 5 files changed, 492 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
 create mode 100644 drivers/input/serio/ps2-gpio.c

diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.txt b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
new file mode 100644
index 000000000000..099dd6d46cb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
@@ -0,0 +1,22 @@
+Device-Tree bindings for ps/2 gpio driver
+
+Required properties:
+	- compatible = "ps2-gpio"
+	- gpios: data and clock gpio
+	- interrupts: Should trigger on the falling edge of the clock line.
+
+Optional properties:
+	- ps2-gpio,write-enable: Indicates whether write function is provided
+	to serio device. Possibly providing the write fn will not work, because
+	of the tough timing requirements.
+
+Example nodes:
+
+ps2@0 {
+	compatible = "ps2-gpio";
+	interrupt-parent = <&gpio>;
+	interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+	data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+	clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+	ps2-gpio,write-enable;
+};
diff --git a/Documentation/gpio/drivers-on-gpio.txt b/Documentation/gpio/drivers-on-gpio.txt
index 306513251713..9a78d385b92e 100644
--- a/Documentation/gpio/drivers-on-gpio.txt
+++ b/Documentation/gpio/drivers-on-gpio.txt
@@ -84,6 +84,11 @@ hardware descriptions such as device tree or ACPI:
   NAND flash MTD subsystem and provides chip access and partition parsing like
   any other NAND driving hardware.
 
+- ps2-gpio: drivers/input/serio/ps2-gpio.c is used to drive a PS/2 (IBM) serio
+  bus, data and clock line, by bit banging two GPIO lines. It will appear as
+  any other serio bus to the system and makes it possible to connect drivers
+  for e.g. keyboards and other PS/2 protocol based devices.
+
 Apart from this there are special GPIO drivers in subsystems like MMC/SD to
 read card detect and write protect GPIO lines, and in the TTY serial subsystem
 to emulate MCTRL (modem control) signals CTS/RTS by using two GPIO lines. The
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index c3d05b4d3118..21488c048fa3 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -292,6 +292,17 @@ config SERIO_SUN4I_PS2
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun4i-ps2.
 
+config SERIO_GPIO_PS2
+	tristate "GPIO PS/2 bit banging driver"
+	depends on GPIOLIB
+	help
+	  Say Y here if you want PS/2 bit banging support via GPIO.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ps2-gpio.
+
+	  If you are unsure, say N.
+
 config USERIO
 	tristate "User space serio port driver support"
 	help
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
index 2374ef9b33d7..767bd9b6e1ed 100644
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
index 000000000000..47ebb0e75b6c
--- /dev/null
+++ b/drivers/input/serio/ps2-gpio.c
@@ -0,0 +1,453 @@
+/*
+ * GPIO based serio bus driver for bit banging the PS/2 protocol
+ *
+ * Author: Danilo Krummrich <danilokrummrich@dk-develop.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+#include <linux/preempt.h>
+#include <linux/property.h>
+#include <linux/of.h>
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
+#define PS2_TX_TIMEOUT		11
+#define PS2_ACK_BIT		12
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
+	struct gpio_desc *gpio_clk;
+	struct gpio_desc *gpio_data;
+	bool write_enable;
+	int irq;
+	unsigned char rx_cnt;
+	unsigned char rx_byte;
+	unsigned char tx_cnt;
+	unsigned char tx_byte;
+	struct completion tx_done;
+	struct mutex tx_mutex;
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
+static int __ps2_gpio_write(struct serio *serio, unsigned char val)
+{
+	struct ps2_gpio_data *drvdata = serio->port_data;
+
+	disable_irq_nosync(drvdata->irq);
+	gpiod_direction_output(drvdata->gpio_clk, 0);
+
+	drvdata->mode = PS2_MODE_TX;
+	drvdata->tx_byte = val;
+
+	schedule_delayed_work(&drvdata->tx_work, usecs_to_jiffies(200));
+
+	return 0;
+}
+
+static int ps2_gpio_write(struct serio *serio, unsigned char val)
+{
+	struct ps2_gpio_data *drvdata = serio->port_data;
+	int ret = 0;
+
+	if (in_task()) {
+		mutex_lock(&drvdata->tx_mutex);
+		__ps2_gpio_write(serio, val);
+		if (!wait_for_completion_timeout(&drvdata->tx_done,
+						 msecs_to_jiffies(10000)))
+			ret = SERIO_TIMEOUT;
+		mutex_unlock(&drvdata->tx_mutex);
+	} else {
+		__ps2_gpio_write(serio, val);
+	}
+
+	return ret;
+}
+
+static void ps2_gpio_tx_work_fn(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct ps2_gpio_data *drvdata = container_of(dwork,
+						    struct ps2_gpio_data,
+						    tx_work);
+
+	enable_irq(drvdata->irq);
+	gpiod_direction_output(drvdata->gpio_data, 0);
+	gpiod_direction_input(drvdata->gpio_clk);
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
+	data = gpiod_get_value(drvdata->gpio_data);
+	if (unlikely(data < 0)) {
+		dev_err(drvdata->dev, "RX: failed to get data gpio val: %d\n",
+			data);
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
+
+		/* Do not send spurious ACK's and NACK's when write fn is
+		 * not provided.
+		 */
+		if (!drvdata->write_enable) {
+			if (byte == PS2_DEV_RET_NACK)
+				goto err;
+			else if (byte == PS2_DEV_RET_ACK)
+				break;
+		}
+
+		/* Let's send the data without waiting for the stop bit to be
+		 * sent. It may happen that we miss the stop bit. When this
+		 * happens we have no way to recover from this, certainly
+		 * missing the parity bit would be recognized when processing
+		 * the stop bit. When missing both, data is lost.
+		 */
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
+	__ps2_gpio_write(drvdata->serio, PS2_CMD_RESEND);
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
+		data = byte & BIT(cnt - 1);
+		gpiod_set_value(drvdata->gpio_data, data);
+		break;
+	case PS2_PARITY_BIT:
+		/* do odd parity */
+		data = !(hweight8(byte) & 1);
+		gpiod_set_value(drvdata->gpio_data, data);
+		break;
+	case PS2_STOP_BIT:
+		/* release data line to generate stop bit */
+		gpiod_direction_input(drvdata->gpio_data);
+		break;
+	case PS2_TX_TIMEOUT:
+		/* Devices generate one extra clock pulse before sending the
+		 * acknowledgment.
+		 */
+		break;
+	case PS2_ACK_BIT:
+		gpiod_direction_input(drvdata->gpio_data);
+		data = gpiod_get_value(drvdata->gpio_data);
+		if (data) {
+			dev_warn(drvdata->dev, "TX: received NACK, retry\n");
+			goto err;
+		}
+
+		drvdata->mode = PS2_MODE_RX;
+		complete(&drvdata->tx_done);
+
+		cnt = 1;
+		old_jiffies = 0;
+		goto end; /* success */
+	default:
+		/* Probably we missed the stop bit. Therefore we release data
+		 * line and try again.
+		 */
+		gpiod_direction_input(drvdata->gpio_data);
+		dev_err(drvdata->dev, "TX: got out of sync with the device\n");
+		goto err;
+	}
+
+	cnt++;
+	goto end; /* success */
+
+err:
+	cnt = 1;
+	old_jiffies = 0;
+	gpiod_direction_input(drvdata->gpio_data);
+	__ps2_gpio_write(drvdata->serio, drvdata->tx_byte);
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
+static int ps2_gpio_get_props(struct device *dev,
+				 struct ps2_gpio_data *drvdata)
+{
+	drvdata->gpio_data = devm_gpiod_get(dev, "data", GPIOD_IN);
+	if (IS_ERR(drvdata->gpio_data)) {
+		dev_err(dev, "failed to request data gpio: %ld",
+			PTR_ERR(drvdata->gpio_data));
+		return PTR_ERR(drvdata->gpio_data);
+	}
+
+	drvdata->gpio_clk = devm_gpiod_get(dev, "clk", GPIOD_IN);
+	if (IS_ERR(drvdata->gpio_clk)) {
+		dev_err(dev, "failed to request clock gpio: %ld",
+			PTR_ERR(drvdata->gpio_clk));
+		return PTR_ERR(drvdata->gpio_clk);
+	}
+
+	drvdata->write_enable = device_property_read_bool(dev,
+				"ps2-gpio,write-enable");
+
+	return 0;
+}
+
+static int ps2_gpio_probe(struct platform_device *pdev)
+{
+	struct ps2_gpio_data *drvdata;
+	struct serio *serio;
+	struct device *dev = &pdev->dev;
+	int error;
+
+	drvdata = devm_kzalloc(dev, sizeof(struct ps2_gpio_data), GFP_KERNEL);
+	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!drvdata || !serio) {
+		error = -ENOMEM;
+		goto err_free_serio;
+	}
+
+	error = ps2_gpio_get_props(dev, drvdata);
+	if (error)
+		goto err_free_serio;
+
+	if (gpiod_cansleep(drvdata->gpio_data) ||
+	    gpiod_cansleep(drvdata->gpio_clk)) {
+		dev_err(dev, "GPIO data or clk are connected via slow bus\n");
+		error = -EINVAL;
+	}
+
+	drvdata->irq = platform_get_irq(pdev, 0);
+	if (drvdata->irq < 0) {
+		dev_err(dev, "failed to get irq from platform resource: %d\n",
+			drvdata->irq);
+		error = drvdata->irq;
+		goto err_free_serio;
+	}
+
+	error = devm_request_irq(dev, drvdata->irq, ps2_gpio_irq,
+				 IRQF_NO_THREAD, DRIVER_NAME, drvdata);
+	if (error) {
+		dev_err(dev, "failed to request irq %d: %d\n",
+			drvdata->irq, error);
+		goto err_free_serio;
+	}
+
+	/* Keep irq disabled until serio->open is called. */
+	disable_irq(drvdata->irq);
+
+	serio->id.type = SERIO_8042;
+	serio->open = ps2_gpio_open;
+	serio->close = ps2_gpio_close;
+	/* Write can be enabled in platform/dt data, but possibly it will not
+	 * work because of the tough timings.
+	 */
+	serio->write = drvdata->write_enable ? ps2_gpio_write : NULL;
+	serio->port_data = drvdata;
+	serio->dev.parent = dev;
+	strlcpy(serio->name, dev_name(dev), sizeof(serio->name));
+	strlcpy(serio->phys, dev_name(dev), sizeof(serio->phys));
+
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
+	init_completion(&drvdata->tx_done);
+	mutex_init(&drvdata->tx_mutex);
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
+		.of_match_table = of_match_ptr(ps2_gpio_match),
+	},
+};
+module_platform_driver(ps2_gpio_driver);
+
+MODULE_AUTHOR("Danilo Krummrich <danilokrummrich@dk-develop.de>");
+MODULE_DESCRIPTION("GPIO PS2 driver");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1

