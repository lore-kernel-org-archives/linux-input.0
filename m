From: Jernej Turnsek <jernej.turnsek@gmail.com>
Subject: Re: [PATCH] Touchscreen driver for the DTS413
Date: Tue, 29 Sep 2009 14:00:23 +0200
Message-ID: <a57e67db0909290500k52bcd1faj28903a22cd2c91a5@mail.gmail.com>
References: <a57e67db0909280023q7d352f22ge5b5343dc0c79c65@mail.gmail.com>
	<4AC1DAA4.4090508@simtec.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4AC1DAA4.4090508@simtec.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi,

corrected version of the DT413 driver doesn't include bit fields
anymore, instead it is using shifting method. Also some comments are
added in kernel doc format.
I would like to thank to Ben Dooks for making some suggestions.

DTS413 is capable of so much more than this driver is supporting, thus
one can feel free to make upgrades.


Simple DTS413 Touchscreen driver.

Signed-off-by: Jernej Turnsek <jernej.turnsek@gmail.com>

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index ab02d72..b2403f5 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -510,6 +510,17 @@ config TOUCHSCREEN_W90X900
 	  To compile this driver as a module, choose M here: the
 	  module will be called w90p910_ts.

+config TOUCHSCREEN_DTS413
+	tristate "DTS413 based touchscreens"
+	depends on I2C
+	help
+	  Say Y here if you have a DTS413 based touchscreen.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called dts413.
+
 config TOUCHSCREEN_PCAP
 	tristate "Motorola PCAP touchscreen"
 	depends on EZX_PCAP
diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
index 4599bf7..be7315b 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -40,4 +40,6 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ATMEL)	+= atmel-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
+obj-$(CONFIG_TOUCHSCREEN_DTS413)	+= dts413.o
 obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
+
diff --git a/drivers/input/touchscreen/dts413.c
b/drivers/input/touchscreen/dts413.c
new file mode 100644
index 0000000..ff3be9b
--- /dev/null
+++ b/drivers/input/touchscreen/dts413.c
@@ -0,0 +1,286 @@
+/*
+ * drivers/input/touchscreen/dts413.c
+ *
+ * Copyright (c) 2009 Iskraemeco d.d.
+ *	Jernej Turnsek <jernej.turnsek@iskraemeco.si>
+ *
+ * Using code from:
+ *  - migor_ts.c
+ * Copyright (c) 2008 Magnus Damm
+ * Copyright (c) 2007 Ujjwal Pande <ujjwal@kenati.com>,
+ *  Kenati Technologies Pvt Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+
+
+#define	MAX_11BIT		((1 << 11) - 1)
+
+#define EVENT_PENDOWN	1
+#define EVENT_PENUP		0
+
+/**
+ * struct dts413 - device structure
+ * @client: the i2c client,
+ * @input: the input device,
+ * @work: workqueue,
+ * @irq: irq number.
+ *
+ * Structure for holding the internal context of a driver.
+ */
+struct dts413 {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct work_struct work;
+	int irq;
+};
+
+/**
+ * dts413_poscheck() - function for position checking
+ * @work: workqueue.
+ *
+ * DTS413 report packet:
+ *        MSB                         LSB
+ * BYTE1:| 1 | R | R | R | R | R | R | S |
+ * BYTE2:| 0 | 0 | 0 | 0 |A10| A9| A8| A7|
+ * BYTE3:| 0 | A6| A5| A4| A3| A2| A1| A0|
+ * BYTE4:| 0 | 0 | 0 | 0 |B10| B9| B8| B7|
+ * BYTE5:| 0 | B6| B5| B4| B3| B2| B1| B0|
+ * BYTE6:| 0 | P6| P5| P4| P3| P2| P1| P0|
+ *
+ * S - status
+ * A10-A0 - 11 bits of 1st direction raw data
+ * B10-B0 - 11 bits of 2st direction raw data
+ * P6-P0 - 7 bits of finger pressure
+ * Please be aware that A nad B just represent 2 resolution directions
+ * of the touch panel. The reported coordinates are (0~2047,0-2047),
+ * the bottom left is (0,0).
+ */
+static void dts413_poscheck(struct work_struct *work)
+{
+	struct dts413 *priv = container_of(work,
+						  struct dts413,
+						  work);
+	unsigned short xpos, ypos;
+	u_int8_t event, speed;
+	u_int8_t buf[6];
+
+	memset(buf, 0, sizeof(buf));
+
+	/* now do page read */
+	if (i2c_master_recv(priv->client, buf, sizeof(buf)) != sizeof(buf)) {
+		dev_err(&priv->client->dev, "Unable to read i2c page\n");
+		goto out;
+	}
+
+	event = (buf[0] & 0x01) ? 1 : 0;
+	xpos = (unsigned short)(buf[2] & 0x7f) |
+			((unsigned short)(buf[1] & 0x0f) << 7);
+	ypos = (unsigned short)(buf[4] & 0x7f) |
+			((unsigned short)(buf[3] & 0x0f) << 7);
+	speed = (buf[5] & 0x7f);
+	
+	if (event == EVENT_PENDOWN) {
+		input_report_key(priv->input, BTN_TOUCH, 1);
+		input_report_abs(priv->input, ABS_X, xpos);
+		input_report_abs(priv->input, ABS_Y, 2048 - ypos);
+		input_report_abs(priv->input, ABS_PRESSURE, 1);
+		input_sync(priv->input);
+	} else if (event == EVENT_PENUP) {
+		input_report_key(priv->input, BTN_TOUCH, 0);
+		input_report_abs(priv->input, ABS_PRESSURE, 0);
+		input_sync(priv->input);
+	}
+ out:
+	enable_irq(priv->irq);
+}
+
+/**
+ * dts413_isr() - interrupt service routine
+ * @irg: irq number.
+ * @dev_id: dts413 device.
+ *
+ * The touch screen controller chip is hooked up to the cpu
+ * using i2c and a single interrupt line. The interrupt line
+ * is pulled low whenever someone taps the screen. To deassert
+ * the interrupt line we need to acknowledge the interrupt by
+ * communicating with the controller over the slow i2c bus.
+ *
+ * We can't acknowledge from interrupt context since the i2c
+ * bus controller may sleep, so we just disable the interrupt
+ * here and handle the acknowledge using delayed work.
+ */
+static irqreturn_t dts413_isr(int irq, void *dev_id)
+{
+	struct dts413 *priv = dev_id;
+
+	disable_irq_nosync(irq);
+	schedule_work(&priv->work);
+
+	return IRQ_HANDLED;
+}
+
+static int dts413_open(struct input_dev *dev)
+{
+ 	return 0;
+}
+
+static void dts413_close(struct input_dev *dev)
+{
+	struct dts413 *priv = input_get_drvdata(dev);
+
+	disable_irq(priv->irq);
+
+	cancel_work_sync(&priv->work);
+
+	enable_irq(priv->irq);
+}
+
+static int dts413_probe(struct i2c_client *client,
+			const struct i2c_device_id *idp)
+{
+	struct dts413 *priv;
+	struct input_dev *input;
+	int error;
+	
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&client->dev, "failed to allocate driver data\n");
+		error = -ENOMEM;
+		goto err0;
+	}
+
+	dev_set_drvdata(&client->dev, priv);
+
+	input = input_allocate_device();
+	if (!input) {
+		dev_err(&client->dev, "Failed to allocate input device.\n");
+		error = -ENOMEM;
+		goto err1;
+	}
+
+	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	input_set_abs_params(input, ABS_X, 0, MAX_11BIT, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, MAX_11BIT, 0, 0);
+	input_set_abs_params(input, ABS_PRESSURE, 0, 0, 0, 0);
+
+	input->name = client->name;
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = &client->dev;
+
+	input->open = dts413_open;
+	input->close = dts413_close;
+
+	input_set_drvdata(input, priv);
+
+	priv->client = client;
+	priv->input = input;
+	INIT_WORK(&priv->work, dts413_poscheck);
+	priv->irq = client->irq;
+
+	error = input_register_device(input);
+	if (error)
+		goto err1;
+
+	error = request_irq(priv->irq, dts413_isr,
IRQF_TRIGGER_FALLING/*IRQF_TRIGGER_LOW*/,
+			    client->name, priv);
+	if (error) {
+		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
+		goto err2;
+	}
+
+	device_init_wakeup(&client->dev, 1);
+	return 0;
+
+ err2:
+	input_unregister_device(input);
+	input = NULL; /* so we dont try to free it below */
+ err1:
+	input_free_device(input);
+	kfree(priv);
+ err0:
+	dev_set_drvdata(&client->dev, NULL);
+	return error;
+}
+
+static int dts413_remove(struct i2c_client *client)
+{
+	struct dts413 *priv = dev_get_drvdata(&client->dev);
+
+	free_irq(priv->irq, priv);
+	input_unregister_device(priv->input);
+	kfree(priv);
+
+	dev_set_drvdata(&client->dev, NULL);
+
+	return 0;
+}
+
+static int dts413_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct dts413 *priv = dev_get_drvdata(&client->dev);
+
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(priv->irq);
+
+	return 0;
+}
+
+static int dts413_resume(struct i2c_client *client)
+{
+	struct dts413 *priv = dev_get_drvdata(&client->dev);
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(priv->irq);
+
+	return 0;
+}
+
+static struct i2c_device_id dts413_idtable[] = {
+	{ "dts413", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, dts413_idtable);
+
+static struct i2c_driver dts413_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "dts413"
+	},
+	.id_table	= dts413_idtable,
+	.probe		= dts413_probe,
+	.remove		= __devexit_p(dts413_remove),
+	.suspend = dts413_suspend,
+	.resume = dts413_resume,
+};
+
+static int __init dts413_init(void)
+{
+	return i2c_add_driver(&dts413_driver);
+}
+
+static void __exit dts413_exit(void)
+{
+	i2c_del_driver(&dts413_driver);
+}
+
+module_init(dts413_init);
+module_exit(dts413_exit);
+
+MODULE_AUTHOR("Jernej Turnsek <jernej.turnsek@iskraemeco.si>");
+MODULE_DESCRIPTION("DTS413 Touch Screen Controller driver");
+MODULE_LICENSE("GPL");
