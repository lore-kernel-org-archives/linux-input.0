From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5] input: Initial support for Kionix KXTJ9 accelerometer
Date: Mon, 4 Jul 2011 09:26:28 -0700
Message-ID: <20110704162628.GC8144@core.coreip.homeip.net>
References: <1309288348-30735-1-git-send-email-chris.hudson.comp.eng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49040 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab1GEEge (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 00:36:34 -0400
Received: by mail-iw0-f174.google.com with SMTP id 6so4900484iwn.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 21:36:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309288348-30735-1-git-send-email-chris.hudson.comp.eng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris.hudson.comp.eng@gmail.com
Cc: linux-input@vger.kernel.org, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>

Hi Chris,

On Tue, Jun 28, 2011 at 03:12:28PM -0400, chris.hudson.comp.eng@gmail.com wrote:
> From: Chris Hudson <chudson@kionix.com>
> 
> - Added Dmitry's changes
> - Now using input_polled_dev interface when in polling mode
> - IRQ mode provides a separate sysfs node to change the hardware data rate
> 

I am not happy with the fact that this implementation forces users to
select polled or interrupt-driven mode at compile time. The patch I
proposed had polled mode support optional and would automatically select
IRQ mode for clients that have interrupt assigned and try to activate
polled mode if interrupt is not available.

> +
> +/* kxtj9_set_poll: allows the user to select a new poll interval (in ms) */
> +static ssize_t kxtj9_set_poll(struct device *dev, struct device_attribute *attr,
> +						const char *buf, size_t count)
> +{
> +	struct kxtj9_data *tj9 = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	unsigned long interval;
> +	int ret = kstrtoul(buf, 10, &interval);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&tj9->lock);
> +	/* set current interval to the greater of the minimum interval or
> +	the requested interval */
> +	tj9->last_poll_interval = max((int)interval, tj9->pdata.min_interval);
> +	mutex_unlock(&tj9->lock);

This lock does not make sense. You are protecting update of last_poll_interval
field and this update can not be partial (i.e. only LSB or MSB is
written) on all our arches, but you do not protect kxtj9_update_odr()
which alters chip state and does need protection.

I tried bringing forward my changes from the older patch into yours,
please let me know if the patch below works on top of yours.

Thanks.

-- 
Dmitry


Input: ktxj9 - misc fixes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/Kconfig  |   34 ++--
 drivers/input/misc/kxtj9.c  |  355 +++++++++++++++++++++++--------------------
 include/linux/input/kxtj9.h |   18 +-
 3 files changed, 220 insertions(+), 187 deletions(-)


diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 41628d2..0134428 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -230,6 +230,23 @@ config INPUT_KEYSPAN_REMOTE
 	  To compile this driver as a module, choose M here: the module will
 	  be called keyspan_remote.
 
+config INPUT_KXTJ9
+	tristate "Kionix KXTJ9 tri-axis digital accelerometer"
+	depends on I2C
+	help
+	  Say Y here to enable support for the Kionix KXTJ9 digital tri-axis
+	  accelerometer.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called kxtj9.
+
+config INPUT_KXTJ9_POLLED_MODE
+	bool "Enable polling mode support"
+	depends on INPUT_KXTJ9
+	select INPUT_POLLDEV
+	help
+	  Say Y here if you need accelerometer to work in polling mode.
+
 config INPUT_POWERMATE
 	tristate "Griffin PowerMate and Contour Jog support"
 	depends on USB_ARCH_HAS_HCD
@@ -499,21 +516,4 @@ config INPUT_XEN_KBDDEV_FRONTEND
 	  To compile this driver as a module, choose M here: the
 	  module will be called xen-kbdfront.
 
-config INPUT_KXTJ9
-       tristate "Kionix KXTJ9 tri-axis digital accelerometer"
-       depends on I2C
-       help
-         If you say yes here you get support for the Kionix KXTJ9 digital
-         tri-axis accelerometer.
-
-         This driver can also be built as a module.  If so, the module
-         will be called kxtj9.
-
-config KXTJ9_POLLED_MODE
-       bool "Enable polling mode support"
-       depends on INPUT_KXTJ9
-       select INPUT_POLLDEV
-       help
-         Say Y here if you need accelerometer to work in polling mode.
-
 endif
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 7faf155..31eae6a 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -75,10 +75,8 @@ struct kxtj9_data {
 	struct i2c_client *client;
 	struct kxtj9_platform_data pdata;
 	struct input_dev *input_dev;
-#ifdef CONFIG_KXTJ9_POLLED_MODE
+#ifdef CONFIG_INPUT_KXTJ9_POLLED_MODE
 	struct input_polled_dev *poll_dev;
-#else
-	struct mutex lock;
 #endif
 	unsigned int last_poll_interval;
 	u8 shift;
@@ -117,16 +115,32 @@ static void kxtj9_report_acceleration_data(struct kxtj9_data *tj9)
 	if (err < 0)
 		dev_err(&tj9->client->dev, "accelerometer data read failed\n");
 
-	x = le16_to_cpu(acc_data[0]) >> tj9->shift;
-	y = le16_to_cpu(acc_data[1]) >> tj9->shift;
-	z = le16_to_cpu(acc_data[2]) >> tj9->shift;
+	x = le16_to_cpu(acc_data[tj9->pdata.axis_map_x]) >> tj9->shift;
+	y = le16_to_cpu(acc_data[tj9->pdata.axis_map_y]) >> tj9->shift;
+	z = le16_to_cpu(acc_data[tj9->pdata.axis_map_z]) >> tj9->shift;
 
 	input_report_abs(tj9->input_dev, ABS_X, tj9->pdata.negate_x ? -x : x);
 	input_report_abs(tj9->input_dev, ABS_Y, tj9->pdata.negate_y ? -y : y);
-	input_report_abs(tj9->input_dev, ABS_Z, tj9->pdata.negate_x ? -y : y);
+	input_report_abs(tj9->input_dev, ABS_Z, tj9->pdata.negate_z ? -z : z);
 	input_sync(tj9->input_dev);
 }
 
+static irqreturn_t kxtj9_isr(int irq, void *dev)
+{
+	struct kxtj9_data *tj9 = dev;
+	int err;
+
+	/* data ready is the only possible interrupt type */
+	kxtj9_report_acceleration_data(tj9);
+
+	err = i2c_smbus_read_byte_data(tj9->client, INT_REL);
+	if (err < 0)
+		dev_err(&tj9->client->dev,
+			"error clearing interrupt status: %d\n", err);
+
+	return IRQ_HANDLED;
+}
+
 static int kxtj9_update_g_range(struct kxtj9_data *tj9, u8 new_g_range)
 {
 	switch (new_g_range) {
@@ -152,7 +166,7 @@ static int kxtj9_update_g_range(struct kxtj9_data *tj9, u8 new_g_range)
 	return 0;
 }
 
-static int kxtj9_update_odr(struct kxtj9_data *tj9, int poll_interval)
+static int kxtj9_update_odr(struct kxtj9_data *tj9, unsigned int poll_interval)
 {
 	int err;
 	int i;
@@ -245,7 +259,7 @@ static int kxtj9_enable(struct kxtj9_data *tj9)
 		err = i2c_smbus_read_byte_data(tj9->client, INT_REL);
 		if (err < 0) {
 			dev_err(&tj9->client->dev,
-					"error clearing interrupt: %d\n", err);
+				"error clearing interrupt: %d\n", err);
 			goto fail;
 		}
 	}
@@ -257,8 +271,27 @@ fail:
 	return err;
 }
 
+static void kxtj9_disable(struct kxtj9_data *tj9)
+{
+	kxtj9_device_power_off(tj9);
+}
+
+static int kxtj9_input_open(struct input_dev *input)
+{
+	struct kxtj9_data *tj9 = input_get_drvdata(input);
+
+	return kxtj9_enable(tj9);
+}
+
+static void kxtj9_input_close(struct input_dev *dev)
+{
+	struct kxtj9_data *tj9 = input_get_drvdata(dev);
+
+	kxtj9_disable(tj9);
+}
+
 static void __devinit kxtj9_init_input_device(struct kxtj9_data *tj9,
-						struct input_dev *input_dev)
+					      struct input_dev *input_dev)
 {
 	__set_bit(EV_ABS, input_dev->evbit);
 	input_set_abs_params(input_dev, ABS_X, -G_MAX, G_MAX, FUZZ, FLAT);
@@ -270,7 +303,104 @@ static void __devinit kxtj9_init_input_device(struct kxtj9_data *tj9,
 	input_dev->dev.parent = &tj9->client->dev;
 }
 
-#ifdef CONFIG_KXTJ9_POLLED_MODE
+static int __devinit kxtj9_setup_input_device(struct kxtj9_data *tj9)
+{
+	struct input_dev *input_dev;
+	int err;
+
+	input_dev = input_allocate_device();
+	if (!tj9->input_dev) {
+		dev_err(&tj9->client->dev, "input device allocate failed\n");
+		return -ENOMEM;
+	}
+
+	tj9->input_dev = input_dev;
+
+	input_dev->open = kxtj9_input_open;
+	input_dev->close = kxtj9_input_close;
+	input_set_drvdata(input_dev, tj9);
+
+	kxtj9_init_input_device(tj9, input_dev);
+
+	err = input_register_device(tj9->input_dev);
+	if (err) {
+		dev_err(&tj9->client->dev,
+			"unable to register input polled device %s: %d\n",
+			tj9->input_dev->name, err);
+		input_free_device(tj9->input_dev);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * When IRQ mode is selected, we need to provide an interface to allow the user
+ * to change the output data rate of the part.  For consistency, we are using
+ * the set_poll method, which accepts a poll interval in milliseconds, and then
+ * calls update_odr() while passing this value as an argument.  In IRQ mode, the
+ * data outputs will not be read AT the requested poll interval, rather, the
+ * lowest ODR that can support the requested interval.  The client application
+ * will be responsible for retrieving data from the input node at the desired
+ * interval.
+ */
+
+/* Returns currently selected poll interval (in ms) */
+static ssize_t kxtj9_get_poll(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxtj9_data *tj9 = i2c_get_clientdata(client);
+
+	return sprintf(buf, "%d\n", tj9->last_poll_interval);
+}
+
+/* Allow users to select a new poll interval (in ms) */
+static ssize_t kxtj9_set_poll(struct device *dev, struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxtj9_data *tj9 = i2c_get_clientdata(client);
+	struct input_dev *input_dev = tj9->input_dev;
+	unsigned int interval;
+	int error;
+
+	error = kstrtouint(buf, 10, &interval);
+	if (error < 0)
+		return error;
+
+	/* Lock the device to prevent races with open/close (and itself) */
+	mutex_unlock(&input_dev->mutex);
+
+	disable_irq(client->irq);
+
+	/*
+	 * Set current interval to the greater of the minimum interval or
+	 * the requested interval
+	 */
+	tj9->last_poll_interval = max(interval, tj9->pdata.min_interval);
+
+	kxtj9_update_odr(tj9, tj9->last_poll_interval);
+
+	enable_irq(client->irq);
+	mutex_unlock(&input_dev->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(poll, S_IRUGO|S_IWUSR, kxtj9_get_poll, kxtj9_set_poll);
+
+static struct attribute *kxtj9_attributes[] = {
+	&dev_attr_poll.attr,
+	NULL
+};
+
+static struct attribute_group kxtj9_attribute_group = {
+	.attrs = kxtj9_attributes
+};
+
+
+#ifdef CONFIG_INPUT_KXTJ9_POLLED_MODE
 static void kxtj9_poll(struct input_polled_dev *dev)
 {
 	struct kxtj9_data *tj9 = dev->private;
@@ -295,7 +425,7 @@ static void kxtj9_polled_input_close(struct input_polled_dev *dev)
 {
 	struct kxtj9_data *tj9 = dev->private;
 
-	kxtj9_device_power_off(tj9);
+	kxtj9_disable(tj9);
 }
 
 static int __devinit kxtj9_setup_polled_device(struct kxtj9_data *tj9)
@@ -325,7 +455,7 @@ static int __devinit kxtj9_setup_polled_device(struct kxtj9_data *tj9)
 		dev_err(&tj9->client->dev,
 			"Unable to register polled device, err=%d\n", err);
 		input_free_polled_device(poll_dev);
-		return 0;
+		return err;
 	}
 
 	return 0;
@@ -337,66 +467,7 @@ static void kxtj9_teardown_polled_device(struct kxtj9_data *tj9)
 	input_free_polled_device(tj9->poll_dev);
 }
 
-#else	/* IRQ Mode is enabled */
-static int kxtj9_input_open(struct input_dev *input)
-{
-	struct kxtj9_data *tj9 = input_get_drvdata(input);
-
-	return kxtj9_enable(tj9);
-}
-
-static void kxtj9_input_close(struct input_dev *dev)
-{
-	struct kxtj9_data *tj9 = input_get_drvdata(dev);
-
-	kxtj9_device_power_off(tj9);
-}
-
-static int __devinit kxtj9_setup_input_device(struct kxtj9_data *tj9)
-{
-	struct input_dev *input_dev;
-	int err;
-
-	input_dev = input_allocate_device();
-	if (!tj9->input_dev) {
-		dev_err(&tj9->client->dev, "input device allocate failed\n");
-		return -ENOMEM;
-	}
-
-	tj9->input_dev = input_dev;
-
-	input_dev->open = kxtj9_input_open;
-	input_dev->close = kxtj9_input_close;
-	input_set_drvdata(input_dev, tj9);
-
-	kxtj9_init_input_device(tj9, input_dev);
-
-	err = input_register_device(tj9->input_dev);
-	if (err) {
-		dev_err(&tj9->client->dev,
-			"unable to register input polled device %s: %d\n",
-			tj9->input_dev->name, err);
-		input_free_device(tj9->input_dev);
-	}
-
-	return 0;
-}
-
-static irqreturn_t kxtj9_isr(int irq, void *dev)
-{
-	struct kxtj9_data *tj9 = dev;
-	int err;
-
-	/* data ready is the only possible interrupt type */
-	kxtj9_report_acceleration_data(tj9);
-
-	err = i2c_smbus_read_byte_data(tj9->client, INT_REL);
-	if (err < 0)
-		dev_err(&tj9->client->dev,
-				"error clearing interrupt status: %d\n", err);
-
-	return IRQ_HANDLED;
-}
+#else
 
 static inline int kxtj9_setup_polled_device(struct kxtj9_data *tj9)
 {
@@ -407,67 +478,22 @@ static inline void kxtj9_teardown_polled_device(struct kxtj9_data *tj9)
 {
 }
 
-/* kxtj9_get_poll: returns the currently selected poll interval (in ms) */
-static ssize_t kxtj9_get_poll(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct kxtj9_data *tj9 = i2c_get_clientdata(to_i2c_client(dev));
-	return sprintf(buf, "%d\n", tj9->last_poll_interval);
-}
-
-/* kxtj9_set_poll: allows the user to select a new poll interval (in ms) */
-static ssize_t kxtj9_set_poll(struct device *dev, struct device_attribute *attr,
-						const char *buf, size_t count)
-{
-	struct kxtj9_data *tj9 = i2c_get_clientdata(to_i2c_client(dev));
-
-	unsigned long interval;
-	int ret = kstrtoul(buf, 10, &interval);
-	if (ret < 0)
-		return ret;
-
-	mutex_lock(&tj9->lock);
-	/* set current interval to the greater of the minimum interval or
-	the requested interval */
-	tj9->last_poll_interval = max((int)interval, tj9->pdata.min_interval);
-	mutex_unlock(&tj9->lock);
-
-	kxtj9_update_odr(tj9, tj9->last_poll_interval);
-
-	return count;
-}
-/* When IRQ mode is selected, we need to provide an interface to allow the user
- * to change the output data rate of the part.  For consistency, we are using
- * the set_poll method, which accepts a poll interval in milliseconds, and then
- * calls update_odr() while passing this value as an argument.  In IRQ mode, the
- * data outputs will not be read AT the requested poll interval, rather, the
- * lowest ODR that can support the requested interval.  The client application
- * will be responsible for retrieving data from the input node at the desired
- * interval.
- */
-static DEVICE_ATTR(poll, S_IRUGO|S_IWUSR, kxtj9_get_poll, kxtj9_set_poll);
-
-static struct attribute *kxtj9_attributes[] = {
-	&dev_attr_poll.attr,
-	NULL
-};
-
-static struct attribute_group kxtj9_attribute_group = {
-	.attrs = kxtj9_attributes
-};
 #endif
 
 static int __devinit kxtj9_verify(struct kxtj9_data *tj9)
 {
 	int retval;
+
 	retval = kxtj9_device_power_on(tj9);
 	if (retval < 0)
 		return retval;
+
 	retval = i2c_smbus_read_byte_data(tj9->client, WHO_AM_I);
 	if (retval < 0) {
 		dev_err(&tj9->client->dev, "read err int source\n");
 		goto out;
 	}
+
 	retval = retval != 0x06 ? -EIO : 0;
 
 out:
@@ -476,7 +502,7 @@ out:
 }
 
 static int __devinit kxtj9_probe(struct i2c_client *client,
-				const struct i2c_device_id *id)
+				 const struct i2c_device_id *id)
 {
 	const struct kxtj9_platform_data *pdata = client->dev.platform_data;
 	struct kxtj9_data *tj9;
@@ -487,10 +513,12 @@ static int __devinit kxtj9_probe(struct i2c_client *client,
 		dev_err(&client->dev, "client is not i2c capable\n");
 		return -ENXIO;
 	}
+
 	if (!pdata) {
 		dev_err(&client->dev, "platform data is NULL; exiting\n");
 		return -EINVAL;
 	}
+
 	tj9 = kzalloc(sizeof(*tj9), GFP_KERNEL);
 	if (!tj9) {
 		dev_err(&client->dev,
@@ -513,42 +541,46 @@ static int __devinit kxtj9_probe(struct i2c_client *client,
 		goto err_pdata_exit;
 	}
 
+	i2c_set_clientdata(client, tj9);
+
 	tj9->ctrl_reg1 = tj9->pdata.res_12bit | tj9->pdata.g_range;
 	tj9->data_ctrl = tj9->pdata.data_odr_init;
 
-#ifdef CONFIG_KXTJ9_POLLED_MODE
-	err = kxtj9_setup_polled_device(tj9);
-	if (err)
-		goto err_pdata_exit;
-#else
-	/* If in irq mode, populate INT_CTRL_REG1 and enable DRDY. */
-	tj9->int_ctrl |= KXTJ9_IEN | KXTJ9_IEA | KXTJ9_IEL;
-	tj9->ctrl_reg1 |= DRDYE;
+	if (client->irq) {
+		/* If in irq mode, populate INT_CTRL_REG1 and enable DRDY. */
+		tj9->int_ctrl |= KXTJ9_IEN | KXTJ9_IEA | KXTJ9_IEL;
+		tj9->ctrl_reg1 |= DRDYE;
+
+		err = kxtj9_setup_input_device(tj9);
+		if (err)
+			goto err_pdata_exit;
+
+		err = request_threaded_irq(client->irq, NULL, kxtj9_isr,
+					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					   "kxtj9-irq", tj9);
+		if (err) {
+			dev_err(&client->dev, "request irq failed: %d\n", err);
+			goto err_destroy_input;
+		}
 
-	err = kxtj9_setup_input_device(tj9);
-	if (err)
-		goto err_pdata_exit;
+		err = sysfs_create_group(&client->dev.kobj, &kxtj9_attribute_group);
+		if (err) {
+			dev_err(&client->dev, "sysfs create failed: %d\n", err);
+			goto err_free_irq;
+		}
 
-	err = request_threaded_irq(client->irq, NULL, kxtj9_isr,
-				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-				"kxtj9-irq", tj9);
-	if (err) {
-		dev_err(&client->dev, "request irq failed: %d\n", err);
-		goto err_destroy_input;
-	}
-	err = sysfs_create_group(&client->dev.kobj, &kxtj9_attribute_group);
-	if (err) {
-		dev_err(&client->dev, "sysfs create failed: %d\n", err);
-		goto err_destroy_input;
+	} else {
+		err = kxtj9_setup_polled_device(tj9);
+		if (err)
+			goto err_pdata_exit;
 	}
-#endif
-	i2c_set_clientdata(client, tj9);
+
 	return 0;
 
-#ifndef CONFIG_KXTJ9_POLLED_MODE
+err_free_irq:
+	free_irq(client->irq, tj9);
 err_destroy_input:
 	input_unregister_device(tj9->input_dev);
-#endif
 err_pdata_exit:
 	if (tj9->pdata.exit)
 		tj9->pdata.exit();
@@ -561,13 +593,14 @@ static int __devexit kxtj9_remove(struct i2c_client *client)
 {
 	struct kxtj9_data *tj9 = i2c_get_clientdata(client);
 
-#ifdef CONFIG_KXTJ9_POLLED_MODE
-	kxtj9_teardown_polled_device(tj9);
-#else
-	sysfs_remove_group(&client->dev.kobj, &kxtj9_attribute_group);
-	free_irq(client->irq, tj9);
-	input_unregister_device(tj9->input_dev);
-#endif
+	if (client->irq) {
+		sysfs_remove_group(&client->dev.kobj, &kxtj9_attribute_group);
+		free_irq(client->irq, tj9);
+		input_unregister_device(tj9->input_dev);
+	} else {
+		kxtj9_teardown_polled_device(tj9);
+	}
+
 	if (tj9->pdata.exit)
 		tj9->pdata.exit();
 
@@ -620,13 +653,13 @@ MODULE_DEVICE_TABLE(i2c, kxtj9_id);
 
 static struct i2c_driver kxtj9_driver = {
 	.driver = {
-		  .name = NAME,
-		  .owner = THIS_MODULE,
-		  .pm = &kxtj9_pm_ops,
+		.name	= NAME,
+		.owner	= THIS_MODULE,
+		.pm	= &kxtj9_pm_ops,
 	},
-	.probe = kxtj9_probe,
-	.remove = __devexit_p(kxtj9_remove),
-	.id_table = kxtj9_id,
+	.probe		= kxtj9_probe,
+	.remove		= __devexit_p(kxtj9_remove),
+	.id_table	= kxtj9_id,
 };
 
 static int __init kxtj9_init(void)
diff --git a/include/linux/input/kxtj9.h b/include/linux/input/kxtj9.h
index cc5928b..0b546bd 100644
--- a/include/linux/input/kxtj9.h
+++ b/include/linux/input/kxtj9.h
@@ -27,19 +27,21 @@
 #define SHIFT_ADJ_4G		3
 #define SHIFT_ADJ_8G		2
 
-#ifdef __KERNEL__
 struct kxtj9_platform_data {
-	int poll_interval;	/* current poll interval (in milli-seconds) */
-	int min_interval;	/* minimum poll interval (in milli-seconds) */
+	unsigned int min_interval;	/* minimum poll interval (in milli-seconds) */
 
-	/* by default, x is axis 0, y is axis 1, z is axis 2; these can be
-	changed to account for sensor orientation within the host device */
+	/*
+	 * By default, x is axis 0, y is axis 1, z is axis 2; these can be
+	 * changed to account for sensor orientation within the host device.
+	 */
 	u8 axis_map_x;
 	u8 axis_map_y;
 	u8 axis_map_z;
 
-	/* each axis can be negated to account for sensor orientation within
-	the host device; 1 = negate this axis; 0 = do not negate this axis */
+	/*
+	 * Each axis can be negated to account for sensor orientation within
+	 * the host device.
+	 */
 	bool negate_x;
 	bool negate_y;
 	bool negate_z;
@@ -70,7 +72,5 @@ struct kxtj9_platform_data {
 	int (*power_on)(void);
 	int (*power_off)(void);
 };
-#endif /* __KERNEL__ */
-
 #endif  /* __KXTJ9_H__ */
 
