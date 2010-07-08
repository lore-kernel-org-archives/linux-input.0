From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] cy8ctmg110: capacitive touchscreen support
Date: Thu, 08 Jul 2010 17:11:38 +0100
Message-ID: <20100708161040.23957.36738.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58799 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368Ab0GHQkQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Jul 2010 12:40:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

From: Samuli Konttila <samuli.konttila@aavamobile.com>

Add support for the cy8ctmg110 capacitive touchscreen used on some embedded
devices.

(Some clean up by Alan Cox)

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/input/touchscreen/Kconfig         |   14 +
 drivers/input/touchscreen/Makefile        |    1 
 drivers/input/touchscreen/cy8ctmg110_ts.c |  470 +++++++++++++++++++++++++++++
 3 files changed, 485 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/cy8ctmg110_ts.c


diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 625e625..8393f47 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -612,4 +612,18 @@ config TOUCHSCREEN_STMPE
 	  To compile this driver as a module, choose M here: the
 	  module will be called stmpe-ts.
 
+config TOUCHSCREEN_CY8CTMG110
+	tristate "cy8ctmg110 touchscreen"
+	depends on I2C
+	depends on GPIOLIB
+
+	help
+	  Say Y here if you have a cy8ctmg110 capacitive touchscreen on
+	  an AAVA device.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cy8ctmg110_ts.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 963fec2..662d066 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
+obj-$(CONFIG_TOUCHSCREEN_CY8CTMG110)    += cy8ctmg110_ts.o
 obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
 obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+= hampshire.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
new file mode 100644
index 0000000..e7017c7
--- /dev/null
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -0,0 +1,470 @@
+/*
+ * cy8ctmg110_ts.c Driver for cypress touch screen controller
+ * Copyright (c) 2009 Aava Mobile
+ *
+ * Some cleanups by Alan Cox <alan@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/timer.h>
+#include <linux/gpio.h>
+#include <linux/hrtimer.h>
+
+#define CY8CTMG110_DRIVER_NAME      "cy8ctmg110"
+
+/* HW definitions */
+#define CY8CTMG110_RESET_PIN_GPIO	43
+#define CY8CTMG110_IRQ_PIN_GPIO		59
+#define CY8CTMG110_I2C_ADDR		0x38
+#define CY8CTMG110_TOUCH_IRQ		21
+
+/* Touch coordinates */
+#define CY8CTMG110_X_MIN		0
+#define CY8CTMG110_Y_MIN		0
+#define CY8CTMG110_X_MAX		864
+#define CY8CTMG110_Y_MAX		480
+
+
+/* cy8ctmg110 register definitions */
+#define CY8CTMG110_TOUCH_WAKEUP_TIME	0
+#define CY8CTMG110_TOUCH_SLEEP_TIME	2
+#define CY8CTMG110_TOUCH_X1		3
+#define CY8CTMG110_TOUCH_Y1		5
+#define CY8CTMG110_TOUCH_X2		7
+#define CY8CTMG110_TOUCH_Y2		9
+#define CY8CTMG110_FINGERS		11
+#define CY8CTMG110_GESTURE		12
+#define CY8CTMG110_REG_MAX		13
+
+#define CY8CTMG110_POLL_TIMER_DELAY	(1000*1000*100)
+#define TOUCH_MAX_I2C_FAILS		50
+
+/* Scale factors for coordinates */
+#define X_SCALE_FACTOR			9387/8424
+#define Y_SCALE_FACTOR			97/100
+
+/* Polling mode */
+static int polling;
+module_param(polling, int, 0);
+MODULE_PARM_DESC(polling, "Set to enable polling of the touchscreen");
+
+
+/*
+ * The touch position structure.
+ */
+struct ts_event {
+	int x1;
+	int y1;
+	int x2;
+	int y2;
+};
+
+/*
+ * The touch driver structure.
+ */
+struct cy8ctmg110 {
+	struct input_dev *input;
+	char phys[32];
+	struct ts_event tc;
+	struct i2c_client *client;
+	spinlock_t lock;
+	bool sleepmode;
+	int polling;
+	struct hrtimer timer;
+};
+
+/*
+ * cy8ctmg110_power is the routine that is called when touch hardware
+ * will powered off or on.
+ */
+static void cy8ctmg110_power(int poweron)
+{
+	gpio_direction_output(CY8CTMG110_RESET_PIN_GPIO, 1 - poweron);
+}
+
+/*
+ * cy8ctmg110_write_req write regs to the i2c devices
+ */
+static int cy8ctmg110_write_req(struct cy8ctmg110 *tsc, unsigned char reg,
+		unsigned char len, unsigned char *value)
+{
+	struct i2c_client *client = tsc->client;
+	unsigned int ret;
+	unsigned char i2c_data[6];
+
+	BUG_ON(len > 5);
+
+	i2c_data[0] = reg;
+	memcpy(i2c_data + 1, value, len);
+
+	ret = i2c_master_send(client, i2c_data, len + 1);
+	if (ret != 1) {
+		dev_err(&client->dev,
+			"cy8ctmg110 touch : i2c write data cmd failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+/*
+ * cy8ctmg110_read_req read regs from i2c devise
+ */
+
+static int cy8ctmg110_read_req(struct cy8ctmg110 *tsc,
+		unsigned char *i2c_data, unsigned char len, unsigned char cmd)
+{
+	struct i2c_client *client = tsc->client;
+	unsigned int ret;
+
+	/* first write slave position to i2c devices */
+	ret = i2c_master_send(client, &cmd, 1);
+	if (ret != 1)
+		return ret;
+
+	/* Second read data from position */
+	ret = i2c_master_recv(client, i2c_data, 1);
+	if (ret != 1)
+		return ret;
+	return 0;
+}
+
+/*
+ * cy8ctmg110_send_event delevery touch event to the userpace
+ * function use normal input interface
+ */
+static void cy8ctmg110_send_event(void *tsc)
+{
+	struct cy8ctmg110 *ts = tsc;
+	struct input_dev *input = ts->input;
+	u16 x, y;
+	u16 x2, y2;
+
+	x = ts->tc.x1;
+	y = ts->tc.y1;
+
+	input_report_key(input, BTN_TOUCH, 1);
+	x2 = (u16) (y * X_SCALE_FACTOR);
+	y2 = (u16) (x * Y_SCALE_FACTOR);
+	input_report_abs(input, ABS_X, x2);
+	input_report_abs(input, ABS_Y, y2);
+	input_sync(input);
+}
+
+/*
+ * cy8ctmg110_touch_pos check touch position from i2c devices
+ */
+static int cy8ctmg110_touch_pos(struct cy8ctmg110 *tsc)
+{
+	unsigned char reg_p[CY8CTMG110_REG_MAX];
+	int x, y;
+
+	memset(reg_p, 0, CY8CTMG110_REG_MAX);
+
+	/* Reading coordinates */
+	if (cy8ctmg110_read_req(tsc, reg_p, 9, CY8CTMG110_TOUCH_X1) != 0)
+		return -EIO;
+
+	y = reg_p[2] << 8 | reg_p[3];
+	x = reg_p[0] << 8 | reg_p[1];
+
+	/* Number of touch */
+	if (reg_p[8] == 0) {
+		struct input_dev *input = tsc->input;
+		input_report_key(input, BTN_TOUCH, 0);
+		input_sync(input);
+	} else if (tsc->tc.x1 != x || tsc->tc.y1 != y) {
+		tsc->tc.y1 = y;
+		tsc->tc.x1 = x;
+		cy8ctmg110_send_event(tsc);
+	}
+	return 0;
+}
+
+/*
+ * If the interrupt isn't in use the touch positions can be read by polling
+ */
+static enum hrtimer_restart cy8ctmg110_timer(struct hrtimer *handle)
+{
+	struct cy8ctmg110 *ts = container_of(handle, struct cy8ctmg110, timer);
+
+	cy8ctmg110_touch_pos(ts);
+	hrtimer_start(&ts->timer,
+		ktime_set(0, CY8CTMG110_POLL_TIMER_DELAY), HRTIMER_MODE_REL);
+
+	return HRTIMER_NORESTART;
+}
+
+/*
+ * cy8ctmg110_init_controller set init value to touchcontroller
+ */
+static bool cy8ctmg110_set_sleepmode(struct cy8ctmg110 *ts)
+{
+	unsigned char reg_p[3];
+
+	if (ts->sleepmode == true) {
+		reg_p[0] = 0x00;
+		reg_p[1] = 0xff;
+		reg_p[2] = 5;
+	} else {
+		reg_p[0] = 0x10;
+		reg_p[1] = 0xff;
+		reg_p[2] = 0;
+	}
+
+	if (cy8ctmg110_write_req(ts, CY8CTMG110_TOUCH_WAKEUP_TIME, 3, reg_p))
+		return false;
+	return true;
+}
+
+/*
+ * cy8ctmg110_irq_handler irq handling function
+ */
+
+static irqreturn_t cy8ctmg110_irq_handler(int irq, void *dev_id)
+{
+	struct cy8ctmg110 *tsc = (struct cy8ctmg110 *) dev_id;
+	cy8ctmg110_touch_pos(tsc);
+	return IRQ_HANDLED;
+}
+
+static int cy8ctmg110_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	struct cy8ctmg110 *ts;
+	struct input_dev *input_dev;
+	int err;
+
+	client->irq = CY8CTMG110_TOUCH_IRQ;
+
+	if (!i2c_check_functionality(client->adapter,
+					I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -EIO;
+
+	ts = kzalloc(sizeof(struct cy8ctmg110), GFP_KERNEL);
+	input_dev = input_allocate_device();
+
+	if (!ts || !input_dev) {
+		err = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	ts->client = client;
+	i2c_set_clientdata(client, ts);
+
+	ts->input = input_dev;
+	ts->polling = polling;
+
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0",
+						dev_name(&client->dev));
+
+	input_dev->name = CY8CTMG110_DRIVER_NAME " Touchscreen";
+	input_dev->phys = ts->phys;
+	input_dev->id.bustype = BUS_I2C;
+
+	spin_lock_init(&ts->lock);
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
+
+	input_set_abs_params(input_dev, ABS_X,
+			CY8CTMG110_X_MIN, CY8CTMG110_X_MAX, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y,
+			CY8CTMG110_Y_MIN, CY8CTMG110_Y_MAX, 0, 0);
+
+	err = gpio_request(CY8CTMG110_RESET_PIN_GPIO, NULL);
+
+	if (err) {
+		dev_err(&client->dev,
+			"cy8ctmg110_ts: Unable to request GPIO pin %d.\n",
+						CY8CTMG110_RESET_PIN_GPIO);
+		goto err_free_mem;
+	}
+	cy8ctmg110_power(1);
+	cy8ctmg110_set_sleepmode(ts);
+
+	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ts->timer.function = cy8ctmg110_timer;
+
+	if (ts->polling == 0) {
+		/* Can we fall back to polling if these bits fail - something
+		   to look at for robustness */
+		err = gpio_request(CY8CTMG110_IRQ_PIN_GPIO, "touch_irq_key");
+		if (err < 0) {
+			dev_err(&client->dev,
+			"cy8ctmg110_ts: failed to request GPIO %d, error %d\n",
+						CY8CTMG110_IRQ_PIN_GPIO, err);
+			ts->polling = 1;
+			goto failed_irq;
+		}
+		err = gpio_direction_input(CY8CTMG110_IRQ_PIN_GPIO);
+
+		if (err < 0) {
+			dev_err(&client->dev,
+  "cy8ctmg110_ts: failed to configure input direction for GPIO %d, error %d\n",
+						CY8CTMG110_IRQ_PIN_GPIO, err);
+			gpio_free(CY8CTMG110_IRQ_PIN_GPIO);
+			ts->polling = 1;
+			goto failed_irq;
+		}
+		client->irq = gpio_to_irq(CY8CTMG110_IRQ_PIN_GPIO);
+		if (client->irq < 0) {
+			err = client->irq;
+			dev_err(&client->dev,
+	"cy8ctmg110_ts: Unable to get irq number for GPIO %d, error %d\n",
+						CY8CTMG110_IRQ_PIN_GPIO, err);
+			gpio_free(CY8CTMG110_IRQ_PIN_GPIO);
+			ts->polling = 1;
+			goto failed_irq;
+		}
+		err = request_irq(client->irq, cy8ctmg110_irq_handler,
+					IRQF_TRIGGER_RISING | IRQF_SHARED,
+						"touch_reset_key", ts);
+		if (err < 0) {
+			dev_err(&client->dev,
+				"cy8ctmg110 irq %d busy? error %d\n",
+					client->irq, err);
+			gpio_free(CY8CTMG110_IRQ_PIN_GPIO);
+			ts->polling = 1;
+		}
+	}
+failed_irq:
+	if (ts->polling)
+		hrtimer_start(&ts->timer, ktime_set(10, 0), HRTIMER_MODE_REL);
+
+	err = input_register_device(input_dev);
+	if (!err)
+		return 0;
+
+	if (ts->polling)
+		hrtimer_cancel(&ts->timer);
+	else
+		free_irq(client->irq, ts);
+	gpio_free(CY8CTMG110_IRQ_PIN_GPIO);
+	gpio_free(CY8CTMG110_RESET_PIN_GPIO);
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(ts);
+	return err;
+}
+
+#ifdef CONFIG_PM
+/*
+ * cy8ctmg110_suspend
+ */
+
+static int cy8ctmg110_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct cy8ctmg110 *ts = i2c_get_clientdata(client);
+
+	if (ts->polling)
+		hrtimer_cancel(&ts->timer);
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(client->irq);
+	else {
+		ts->sleepmode = true;
+		cy8ctmg110_set_sleepmode(ts);
+		cy8ctmg110_power(0);
+	}
+	return 0;
+}
+
+/*
+ * cy8ctmg110_resume
+ */
+
+static int cy8ctmg110_resume(struct i2c_client *client)
+{
+	struct cy8ctmg110 *ts = i2c_get_clientdata(client);
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(client->irq);
+	else {
+		cy8ctmg110_power(1);
+		ts->sleepmode = false;
+		cy8ctmg110_set_sleepmode(ts);
+	}
+	if (ts->polling)
+		hrtimer_start(&ts->timer, ktime_set(10, 0), HRTIMER_MODE_REL);
+	return 0;
+}
+#endif
+
+/*
+ * cy8ctmg110_remove
+ */
+
+static int cy8ctmg110_remove(struct i2c_client *client)
+{
+	struct cy8ctmg110 *ts = i2c_get_clientdata(client);
+
+	cy8ctmg110_power(0);
+
+	if (ts->polling)
+		hrtimer_cancel(&ts->timer);
+	free_irq(client->irq, ts);
+	input_unregister_device(ts->input);
+	gpio_free(CY8CTMG110_IRQ_PIN_GPIO);
+	gpio_free(CY8CTMG110_RESET_PIN_GPIO);
+	kfree(ts);
+	return 0;
+}
+
+static struct i2c_device_id cy8ctmg110_idtable[] = {
+	{CY8CTMG110_DRIVER_NAME, 1},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, cy8ctmg110_idtable);
+
+static struct i2c_driver cy8ctmg110_driver = {
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = CY8CTMG110_DRIVER_NAME,
+		   .bus = &i2c_bus_type,
+		   },
+	.id_table = cy8ctmg110_idtable,
+	.probe = cy8ctmg110_probe,
+	.remove = cy8ctmg110_remove,
+#ifdef CONFIG_PM
+	.suspend = cy8ctmg110_suspend,
+	.resume = cy8ctmg110_resume,
+#endif
+};
+
+static int __init cy8ctmg110_init(void)
+{
+	return i2c_add_driver(&cy8ctmg110_driver);
+}
+
+static void __exit cy8ctmg110_exit(void)
+{
+	i2c_del_driver(&cy8ctmg110_driver);
+}
+
+module_init(cy8ctmg110_init);
+module_exit(cy8ctmg110_exit);
+
+MODULE_AUTHOR("Samuli Konttila <samuli.konttila@aavamobile.com>");
+MODULE_DESCRIPTION("cy8ctmg110 TouchScreen Driver");
+MODULE_LICENSE("GPL v2");

