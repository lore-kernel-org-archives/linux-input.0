From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH v4] ili210x: Add support for Ilitek ILI210x based touchscreens
Date: Thu,  8 Mar 2012 10:29:19 +0100
Message-ID: <1331198959-19660-1-git-send-email-olivier@sobrie.be>
References: <20120307101129.GA23355@hposo>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57017 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab2CHJa2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Mar 2012 04:30:28 -0500
Received: by eekc41 with SMTP id c41so77677eek.19
        for <linux-input@vger.kernel.org>; Thu, 08 Mar 2012 01:30:27 -0800 (PST)
In-Reply-To: <20120307101129.GA23355@hposo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Olivier Sobrie <olivier@sobrie.be>

The driver supports chipsets ILI2102, ILI2102s, ILI2103, ILI2103s and
ILI2105.
Such kind of controllers can be found in Amazon Kindle Fire devices.

Reviewed-by: Jan Paesmans <jan.paesmans@gmail.com>
Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
 drivers/input/touchscreen/Kconfig   |   15 ++
 drivers/input/touchscreen/Makefile  |    1 +
 drivers/input/touchscreen/ili210x.c |  367 +++++++++++++++++++++++++++++++++++
 include/linux/input/ili210x.h       |   10 +
 4 files changed, 393 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/ili210x.c
 create mode 100644 include/linux/input/ili210x.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index fc087b3..97b31a0 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -243,6 +243,21 @@ config TOUCHSCREEN_FUJITSU
 	  To compile this driver as a module, choose M here: the
 	  module will be called fujitsu-ts.
 
+config TOUCHSCREEN_ILI210X
+	tristate "Ilitek ILI210X based touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have a ILI210X based touchscreen
+	  controller. This driver supports models ILI2102,
+	  ILI2102s, ILI2103, ILI2103s and ILI2105.
+	  Such kind of chipsets can be found in Amazon Kindle Fire
+	  touchscreens.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ili210x.
+
 config TOUCHSCREEN_S3C2410
 	tristate "Samsung S3C2410/generic touchscreen input driver"
 	depends on ARCH_S3C2410 || SAMSUNG_DEV_TS
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index e748fb8..3d5cf8c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
+obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
 obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
 obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+= intel-mid-touch.o
 obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+= lpc32xx_ts.o
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
new file mode 100644
index 0000000..07e5bd7
--- /dev/null
+++ b/drivers/input/touchscreen/ili210x.c
@@ -0,0 +1,367 @@
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+#include <linux/input/ili210x.h>
+
+#define MAX_TOUCHES		2
+#define DEFAULT_POLL_PERIOD	20
+
+/* Touchscreen commands */
+#define REG_TOUCHDATA		0x10
+#define REG_PANEL_INFO		0x20
+#define REG_FIRMWARE_VERSION	0x40
+#define REG_CALIBRATE		0xcc
+
+struct finger {
+	u8 x_low;
+	u8 x_high;
+	u8 y_low;
+	u8 y_high;
+} __packed;
+
+struct touchdata {
+	u8 status;
+	struct finger finger[MAX_TOUCHES];
+} __packed;
+
+struct panel_info {
+	struct finger finger_max;
+	u8 xchannel_num;
+	u8 ychannel_num;
+} __packed;
+
+struct firmware_version {
+	u8 id;
+	u8 major;
+	u8 minor;
+} __packed;
+
+struct ili210x {
+	struct i2c_client *client;
+	struct input_dev *input;
+	bool (*get_pendown_state)(void);
+	unsigned int poll_period;
+	struct delayed_work dwork;
+};
+
+static int ili210x_read_reg(struct i2c_client *client, u8 reg, void *buf,
+			    size_t len)
+{
+	struct i2c_msg msg[2];
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	msg[0].buf = &reg;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = len;
+	msg[1].buf = buf;
+
+	if (i2c_transfer(client->adapter, msg, 2) != 2) {
+		dev_err(&client->dev, "i2c transfer failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void ili210x_report_events(struct input_dev *input,
+				  const struct touchdata *touchdata)
+{
+	int i;
+	bool touch;
+	unsigned int x, y;
+	const struct finger *finger;
+
+	for (i = 0; i < MAX_TOUCHES; i++) {
+		input_mt_slot(input, i);
+
+		finger = &touchdata->finger[i];
+
+		touch = touchdata->status & (1 << i);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
+		if (touch) {
+			x = finger->x_low | (finger->x_high << 8);
+			y = finger->y_low | (finger->y_high << 8);
+
+			input_report_abs(input, ABS_MT_POSITION_X, x);
+			input_report_abs(input, ABS_MT_POSITION_Y, y);
+		}
+	}
+
+	input_mt_report_pointer_emulation(input, false);
+	input_sync(input);
+}
+
+static bool get_pendown_state(const struct ili210x *priv)
+{
+	bool state = false;
+
+	if (priv->get_pendown_state)
+		state = priv->get_pendown_state();
+
+	return state;
+}
+
+static void ili210x_work(struct work_struct *work)
+{
+	struct ili210x *priv = container_of(work, struct ili210x,
+					    dwork.work);
+	struct input_dev *input = priv->input;
+	struct i2c_client *client = priv->client;
+	struct device *dev = &client->dev;
+	struct touchdata touchdata;
+	int rc;
+
+	rc = ili210x_read_reg(client, REG_TOUCHDATA, &touchdata,
+			      sizeof(touchdata));
+	if (rc < 0) {
+		dev_err(dev, "Unable to get touchdata, err = %d\n",
+			rc);
+		return;
+	}
+
+	ili210x_report_events(input, &touchdata);
+
+	if ((touchdata.status & 0xf3) || get_pendown_state(priv))
+		schedule_delayed_work(&priv->dwork,
+				      msecs_to_jiffies(priv->poll_period));
+}
+
+static irqreturn_t ili210x_irq(int irq, void *irq_data)
+{
+	struct ili210x *priv = irq_data;
+
+	schedule_delayed_work(&priv->dwork, 0);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t ili210x_calibrate(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct ili210x *priv = dev_get_drvdata(dev);
+	unsigned long calibrate;
+	int rc;
+	u8 cmd = REG_CALIBRATE;
+
+	if (kstrtoul(buf, 10, &calibrate))
+		return -EINVAL;
+
+	if (calibrate > 1)
+		return -EINVAL;
+
+	if (calibrate) {
+		rc = i2c_master_send(priv->client, &cmd, sizeof(cmd));
+		if (rc != sizeof(cmd))
+			return -EIO;
+	}
+
+	return count;
+}
+static DEVICE_ATTR(calibrate, 0644, NULL, ili210x_calibrate);
+
+static struct attribute *ili210x_attributes[] = {
+	&dev_attr_calibrate.attr,
+	NULL,
+};
+
+static const struct attribute_group ili210x_attr_group = {
+	.attrs = ili210x_attributes,
+};
+
+static int __devinit ili210x_i2c_probe(struct i2c_client *client,
+				       const struct i2c_device_id *id)
+{
+	struct ili210x *priv;
+	struct device *dev = &client->dev;
+	struct ili210x_platform_data *pdata = dev->platform_data;
+	struct panel_info panel;
+	struct firmware_version firmware;
+	int xmax, ymax;
+	int rc;
+
+	dev_dbg(dev, "Probing for ILI210X I2C Touschreen driver");
+
+	if (!pdata) {
+		dev_err(dev, "No platform data!\n");
+		return -ENODEV;
+	}
+
+	if (client->irq <= 0) {
+		dev_err(dev, "No IRQ!\n");
+		return -ENODEV;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(dev, "Failed to allocate driver data!\n");
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	dev_set_drvdata(dev, priv);
+
+	priv->input = input_allocate_device();
+	if (!priv->input) {
+		dev_err(dev, "Failed to allocate input device\n");
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	/* Get firmware version */
+	rc = ili210x_read_reg(client, REG_FIRMWARE_VERSION, &firmware,
+			      sizeof(firmware));
+	if (rc < 0) {
+		dev_err(dev, "Failed to get firmware version, err: %d\n",
+			rc);
+		goto fail_probe;
+	}
+
+	/* get panel info */
+	rc = ili210x_read_reg(client, REG_PANEL_INFO, &panel,
+			      sizeof(panel));
+	if (rc < 0) {
+		dev_err(dev, "Failed to get panel informations, err: %d\n",
+			rc);
+		goto fail_probe;
+	}
+
+	xmax = panel.finger_max.x_low | (panel.finger_max.x_high << 8);
+	ymax = panel.finger_max.y_low | (panel.finger_max.y_high << 8);
+
+	/* Setup input device */
+	__set_bit(EV_SYN, priv->input->evbit);
+	__set_bit(EV_KEY, priv->input->evbit);
+	__set_bit(EV_ABS, priv->input->evbit);
+	__set_bit(BTN_TOUCH, priv->input->keybit);
+
+	/* Single touch */
+	input_set_abs_params(priv->input, ABS_X, 0, xmax, 0, 0);
+	input_set_abs_params(priv->input, ABS_Y, 0, ymax, 0, 0);
+
+	/* Multi touch */
+	input_mt_init_slots(priv->input, MAX_TOUCHES);
+	input_set_abs_params(priv->input, ABS_MT_POSITION_X, 0, xmax, 0, 0);
+	input_set_abs_params(priv->input, ABS_MT_POSITION_Y, 0, ymax, 0, 0);
+
+	priv->input->name = "ILI210x Touchscreen";
+	priv->input->id.bustype = BUS_I2C;
+	priv->input->dev.parent = dev;
+
+	input_set_drvdata(priv->input, priv);
+
+	priv->client = client;
+	priv->get_pendown_state = pdata->get_pendown_state;
+	priv->poll_period = pdata->poll_period ? : DEFAULT_POLL_PERIOD;
+	INIT_DELAYED_WORK(&priv->dwork, ili210x_work);
+
+	rc = request_irq(client->irq, ili210x_irq, pdata->irq_flags,
+			 client->name, priv);
+	if (rc) {
+		dev_err(dev, "Unable to request touchscreen IRQ, err: %d\n",
+			rc);
+		goto fail_probe;
+	}
+
+	rc = sysfs_create_group(&dev->kobj, &ili210x_attr_group);
+	if (rc) {
+		dev_err(dev, "Unable to create sysfs attributes, err: %d\n",
+			rc);
+		goto fail_sysfs;
+	}
+
+	rc = input_register_device(priv->input);
+	if (rc) {
+		dev_err(dev, "Cannot regiser input device, err: %d\n", rc);
+		goto fail_input;
+	}
+
+	device_init_wakeup(&client->dev, 1);
+
+	dev_dbg(dev,
+		"ILI210x initialized (IRQ: %d), firmware version %d.%d.%d",
+		client->irq, firmware.id, firmware.major, firmware.minor);
+
+	return 0;
+
+fail_input:
+	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
+fail_sysfs:
+	free_irq(client->irq, priv);
+fail_probe:
+	input_free_device(priv->input);
+fail:
+	kfree(priv);
+	return rc;
+}
+
+static int __devexit ili210x_i2c_remove(struct i2c_client *client)
+{
+	struct ili210x *priv = dev_get_drvdata(&client->dev);
+	struct device *dev = &priv->client->dev;
+
+	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
+	free_irq(priv->client->irq, priv);
+	cancel_delayed_work_sync(&priv->dwork);
+	input_unregister_device(priv->input);
+	kfree(priv);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ili210x_i2c_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int ili210x_i2c_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(client->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(ili210x_i2c_pm, ili210x_i2c_suspend,
+			 ili210x_i2c_resume);
+
+static const struct i2c_device_id ili210x_i2c_id[] = {
+	{ "ili210x", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ili210x_i2c_id);
+
+static struct i2c_driver ili210x_ts_driver = {
+	.driver = {
+		.name = "ili210x_i2c",
+		.owner = THIS_MODULE,
+		.pm = &ili210x_i2c_pm,
+	},
+	.id_table = ili210x_i2c_id,
+	.probe = ili210x_i2c_probe,
+	.remove = __devexit_p(ili210x_i2c_remove),
+};
+
+module_i2c_driver(ili210x_ts_driver);
+
+MODULE_AUTHOR("Olivier Sobrie <olivier@sobrie.be>");
+MODULE_DESCRIPTION("ILI210X I2C Touchscreen Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/input/ili210x.h b/include/linux/input/ili210x.h
new file mode 100644
index 0000000..a547124
--- /dev/null
+++ b/include/linux/input/ili210x.h
@@ -0,0 +1,10 @@
+#ifndef _ILI210X_H
+#define _ILI210X_H
+
+struct ili210x_platform_data {
+	unsigned long irq_flags;
+	unsigned int poll_period;
+	bool (*get_pendown_state)(void);
+};
+
+#endif
-- 
1.7.5.4

