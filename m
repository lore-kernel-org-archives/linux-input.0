From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] input: add driver for EETI touchpanels [v3]
Date: Fri, 15 May 2009 11:36:33 +0200
Message-ID: <1242380193-15924-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:37628 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762159AbZEOJgp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2009 05:36:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>

This patch adds a driver for EETI's I2C connected touchscreens.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 drivers/input/touchscreen/eeti_ts.c |  290 +++++++++++++++++++++++++++++++++++
 1 files changed, 290 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/eeti_ts.c

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
new file mode 100644
index 0000000..72800e1
--- /dev/null
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -0,0 +1,290 @@
+/*
+ * Touch Screen driver for EETI's I2C connected touch screen panels
+ *   Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
+ *
+ * See EETI's software guide for the protocol specification:
+ *   http://home.eeti.com.tw/web20/eg/guide.htm
+ *
+ * Based on migor_ts.c
+ *   Copyright (c) 2008 Magnus Damm
+ *   Copyright (c) 2007 Ujjwal Pande <ujjwal@kenati.com>
+ *
+ * This file is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU  General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/timer.h>
+#include <linux/gpio.h>
+
+static int flip_x;
+module_param(flip_x, bool, 0644);
+MODULE_PARM_DESC(flip_x, "flip x coordinate");
+
+static int flip_y;
+module_param(flip_y, bool, 0644);
+MODULE_PARM_DESC(flip_y, "flip y coordinate");
+
+struct eeti_ts_priv {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct delayed_work work;
+	struct mutex mutex;
+	int irq;
+};
+
+#define EETI_TS_BITDEPTH	(11)
+#define EETI_MAXVAL		((1 << (EETI_TS_BITDEPTH + 1)) - 1)
+
+#define REPORT_BIT_PRESSED	(1 << 0)
+#define REPORT_BIT_AD0		(1 << 1)
+#define REPORT_BIT_AD1		(1 << 2)
+#define REPORT_BIT_HAS_PRESSURE	(1 << 6)
+#define REPORT_RES_BITS(v)	(((v) >> 1) + EETI_TS_BITDEPTH)
+
+static void eeti_ts_read(struct work_struct *work)
+{
+	char buf[6];
+	unsigned int x, y, res, pressed, to = 100;
+	struct eeti_ts_priv *priv =
+		container_of(work, struct eeti_ts_priv, work.work);
+
+	mutex_lock(&priv->mutex);
+
+	while (!gpio_get_value(irq_to_gpio(priv->irq)) && --to)
+		i2c_master_recv(priv->client, buf, sizeof(buf));
+
+	if (!to) {
+		dev_err(&priv->client->dev,
+			"unable to clear IRQ - line stuck?\n");
+		mutex_lock(&priv->mutex);
+		return;
+	}
+
+	/* drop non-report packets */
+	if (!(buf[0] & 0x80)) {
+		mutex_unlock(&priv->mutex);
+		return;
+	}
+
+	pressed = buf[0] & REPORT_BIT_PRESSED;
+	res = REPORT_RES_BITS(buf[0] & (REPORT_BIT_AD0 | REPORT_BIT_AD1));
+	x = buf[2] | (buf[1] << 8);
+	y = buf[4] | (buf[3] << 8);
+
+	/* fix the range to 11 bits */
+	x >>= res - EETI_TS_BITDEPTH;
+	y >>= res - EETI_TS_BITDEPTH;
+
+	if (flip_x)
+		x = EETI_MAXVAL - x;
+
+	if (flip_y)
+		y = EETI_MAXVAL - y;
+
+	if ((buf[0] & REPORT_BIT_HAS_PRESSURE) && !pressed)
+		input_report_abs(priv->input, ABS_PRESSURE, buf[5]);
+
+	input_report_abs(priv->input, ABS_X, x);
+	input_report_abs(priv->input, ABS_Y, y);
+	input_report_key(priv->input, BTN_TOUCH, !!pressed);
+	input_sync(priv->input);
+	mutex_unlock(&priv->mutex);
+}
+
+static irqreturn_t eeti_ts_isr(int irq, void *dev_id)
+{
+	struct eeti_ts_priv *priv = dev_id;
+
+	 /* postpone I2C transactions as we are atomic */
+	schedule_delayed_work(&priv->work, HZ / 100);
+
+	return IRQ_HANDLED;
+}
+
+static int eeti_ts_open(struct input_dev *dev)
+{
+	struct eeti_ts_priv *priv = input_get_drvdata(dev);
+
+	enable_irq(priv->irq);
+
+	/* Read the events once to arm the IRQ */
+	eeti_ts_read(&priv->work.work);
+
+	return 0;
+}
+
+static void eeti_ts_close(struct input_dev *dev)
+{
+	struct eeti_ts_priv *priv = input_get_drvdata(dev);
+
+	disable_irq(priv->irq);
+	cancel_delayed_work_sync(&priv->work);
+}
+
+static int eeti_ts_probe(struct i2c_client *client,
+			  const struct i2c_device_id *idp)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct eeti_ts_priv *priv;
+	struct input_dev *input;
+	int err = -ENOMEM;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+		return -EIO;
+
+	/* In contrast to what's described in the datasheet, there seems
+	 * to be no way of probing the presence of that device using I2C
+	 * commands. So we need to blindly believe it is there, and wait
+	 * for interrupts to occur. */
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&client->dev, "failed to allocate driver data\n");
+		goto err0;
+	}
+
+	mutex_init(&priv->mutex);
+	input = input_allocate_device();
+
+	if (!input) {
+		dev_err(&client->dev, "Failed to allocate input device.\n");
+		goto err1;
+	}
+
+	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	input_set_abs_params(input, ABS_X, 0, EETI_MAXVAL, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, EETI_MAXVAL, 0, 0);
+	input_set_abs_params(input, ABS_PRESSURE, 0, 0xff, 0, 0);
+
+	input->name = client->name;
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = &client->dev;
+	input->open = eeti_ts_open;
+	input->close = eeti_ts_close;
+
+	input_set_drvdata(input, priv);
+
+	priv->client = client;
+	priv->input = input;
+	priv->irq = client->irq;
+	dev_set_drvdata(&client->dev, priv);
+	INIT_DELAYED_WORK(&priv->work, eeti_ts_read);
+
+	err = input_register_device(input);
+	if (err)
+		goto err1;
+
+	err = request_irq(priv->irq, eeti_ts_isr, IRQF_TRIGGER_FALLING,
+			  client->name, priv);
+	if (err) {
+		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
+		goto err2;
+	}
+
+	/* Disable the irq for now. It will be enabled once the input device
+	 * is opened. */
+	disable_irq(priv->irq);
+
+	device_init_wakeup(&client->dev, 0);
+	return 0;
+
+err2:
+	input_unregister_device(input);
+	input = NULL; /* so we dont try to free it below */
+err1:
+	input_free_device(input);
+	kfree(priv);
+err0:
+	dev_set_drvdata(&client->dev, NULL);
+	return err;
+}
+
+static int eeti_ts_remove(struct i2c_client *client)
+{
+	struct eeti_ts_priv *priv = dev_get_drvdata(&client->dev);
+
+	free_irq(priv->irq, priv);
+	input_unregister_device(priv->input);
+	dev_set_drvdata(&client->dev, NULL);
+	kfree(priv);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int eeti_ts_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct eeti_ts_priv *priv = dev_get_drvdata(&client->dev);
+
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(priv->irq);
+
+	return 0;
+}
+
+static int eeti_ts_resume(struct i2c_client *client)
+{
+	struct eeti_ts_priv *priv = dev_get_drvdata(&client->dev);
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(priv->irq);
+
+	return 0;
+}
+#else
+#define eeti_ts_suspend NULL
+#define eeti_ts_resume NULL
+#endif
+
+static const struct i2c_device_id eeti_ts_id[] = {
+	{ "eeti_ts", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, eeti_ts_id);
+
+static struct i2c_driver eeti_ts_driver = {
+	.driver = {
+		.name = "eeti_ts",
+	},
+	.probe = eeti_ts_probe,
+	.remove = eeti_ts_remove,
+	.suspend = eeti_ts_suspend,
+	.resume = eeti_ts_resume,
+	.id_table = eeti_ts_id,
+};
+
+static int __init eeti_ts_init(void)
+{
+	return i2c_add_driver(&eeti_ts_driver);
+}
+
+static void __exit eeti_ts_exit(void)
+{
+	i2c_del_driver(&eeti_ts_driver);
+}
+
+MODULE_DESCRIPTION("EETI Touchscreen driver");
+MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
+MODULE_LICENSE("GPL");
+
+module_init(eeti_ts_init);
+module_exit(eeti_ts_exit);
-- 
1.6.2.1

