From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/4] Input: ad7879 - add open and close methods
Date: Fri, 25 Jun 2010 01:22:29 -0700
Message-ID: <20100625082229.8617.40982.stgit@localhost.localdomain>
References: <20100625081847.8617.31150.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34648 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0FYIWd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jun 2010 04:22:33 -0400
Received: by pvg2 with SMTP id 2so745277pvg.19
        for <linux-input@vger.kernel.org>; Fri, 25 Jun 2010 01:22:32 -0700 (PDT)
In-Reply-To: <20100625081847.8617.31150.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ad7879-i2c.c |    4 +
 drivers/input/touchscreen/ad7879-spi.c |    4 +
 drivers/input/touchscreen/ad7879.c     |  105 +++++++++++++++++++++++---------
 drivers/input/touchscreen/ad7879.h     |    4 +
 4 files changed, 81 insertions(+), 36 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index 41b32cb..f75f753 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -20,7 +20,7 @@ static int ad7879_i2c_suspend(struct i2c_client *client, pm_message_t message)
 {
 	struct ad7879 *ts = i2c_get_clientdata(client);
 
-	ad7879_disable(ts);
+	ad7879_suspend(ts);
 
 	return 0;
 }
@@ -29,7 +29,7 @@ static int ad7879_i2c_resume(struct i2c_client *client)
 {
 	struct ad7879 *ts = i2c_get_clientdata(client);
 
-	ad7879_enable(ts);
+	ad7879_resume(ts);
 
 	return 0;
 }
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index cd12dac..6e32f3a 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -25,7 +25,7 @@ static int ad7879_spi_suspend(struct spi_device *spi, pm_message_t message)
 {
 	struct ad7879 *ts = spi_get_drvdata(spi);
 
-	ad7879_disable(ts);
+	ad7879_suspend(ts);
 
 	return 0;
 }
@@ -34,7 +34,7 @@ static int ad7879_spi_resume(struct spi_device *spi)
 {
 	struct ad7879 *ts = spi_get_drvdata(spi);
 
-	ad7879_enable(ts);
+	ad7879_resume(ts);
 
 	return 0;
 }
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 59a794c..4e2c1b7 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -112,10 +112,11 @@ struct ad7879 {
 	struct timer_list	timer;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gc;
+	struct mutex		mutex;
 #endif
 	unsigned int		irq;
-	struct mutex		mutex;
-	bool			disabled;	/* P: mutex */
+	bool			disabled;	/* P: input->mutex */
+	bool			suspended;	/* P: input->mutex */
 	u16			conversion_data[AD7879_NR_SENSE];
 	char			phys[32];
 	u8			first_conversion_delay;
@@ -208,46 +209,91 @@ static irqreturn_t ad7879_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
-static void ad7879_setup(struct ad7879 *ts)
+static void __ad7879_enable(struct ad7879 *ts)
 {
 	ad7879_write(ts, AD7879_REG_CTRL2, ts->cmd_crtl2);
 	ad7879_write(ts, AD7879_REG_CTRL3, ts->cmd_crtl3);
 	ad7879_write(ts, AD7879_REG_CTRL1, ts->cmd_crtl1);
+
+	enable_irq(ts->irq);
 }
 
-void ad7879_disable(struct ad7879 *ts)
+static void __ad7879_disable(struct ad7879 *ts)
 {
-	mutex_lock(&ts->mutex);
+	disable_irq(ts->irq);
 
-	if (!ts->disabled) {
+	if (del_timer_sync(&ts->timer))
+		ad7879_ts_event_release(ts);
 
-		ts->disabled = true;
-		disable_irq(ts->irq);
+	ad7879_write(ts, AD7879_REG_CTRL2, AD7879_PM(AD7879_PM_SHUTDOWN));
+}
 
-		if (del_timer_sync(&ts->timer))
-			ad7879_ts_event_release(ts);
 
-		ad7879_write(ts, AD7879_REG_CTRL2,
-			     AD7879_PM(AD7879_PM_SHUTDOWN));
-	}
+static int ad7879_open(struct input_dev *input)
+{
+	struct ad7879 *ts = input_get_drvdata(input);
 
-	mutex_unlock(&ts->mutex);
+	/* protected by input->mutex */
+	if (!ts->disabled && !ts->suspended)
+		__ad7879_enable(ts);
+
+	return 0;
 }
-EXPORT_SYMBOL(ad7879_disable);
 
-void ad7879_enable(struct ad7879 *ts)
+static void ad7879_close(struct input_dev* input)
 {
-	mutex_lock(&ts->mutex);
+	struct ad7879 *ts = input_get_drvdata(input);
 
-	if (ts->disabled) {
-		ad7879_setup(ts);
-		ts->disabled = false;
-		enable_irq(ts->irq);
+	/* protected by input->mutex */
+	if (!ts->disabled && !ts->suspended)
+		__ad7879_disable(ts);
+}
+
+void ad7879_suspend(struct ad7879 *ts)
+{
+	mutex_lock(&ts->input->mutex);
+
+	if (!ts->suspended && !ts->disabled && ts->input->users)
+		__ad7879_disable(ts);
+
+	ts->suspended = true;
+
+	mutex_unlock(&ts->input->mutex);
+}
+EXPORT_SYMBOL(ad7879_suspend);
+
+void ad7879_resume(struct ad7879 *ts)
+{
+	mutex_lock(&ts->input->mutex);
+
+	if (ts->suspended && !ts->disabled && ts->input->users)
+		__ad7879_enable(ts);
+
+	ts->suspended = false;
+
+	mutex_unlock(&ts->input->mutex);
+}
+EXPORT_SYMBOL(ad7879_resume);
+
+static void ad7879_toggle(struct ad7879 *ts, bool enable)
+{
+	mutex_lock(&ts->input->mutex);
+
+	if (!ts->suspended && ts->input->users != 0) {
+
+		if (enable) {
+			if (ts->disabled)
+				__ad7879_enable(ts);
+		} else {
+			if (!ts->disabled)
+				__ad7879_disable(ts);
+		}
 	}
 
-	mutex_unlock(&ts->mutex);
+	ts->disabled = !enable;
+
+	mutex_unlock(&ts->input->mutex);
 }
-EXPORT_SYMBOL(ad7879_enable);
 
 static ssize_t ad7879_disable_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -269,10 +315,7 @@ static ssize_t ad7879_disable_store(struct device *dev,
 	if (error)
 		return error;
 
-	if (val)
-		ad7879_disable(ts);
-	else
-		ad7879_enable(ts);
+	ad7879_toggle(ts, val);
 
 	return count;
 }
@@ -355,6 +398,8 @@ static int ad7879_gpio_add(struct ad7879 *ts,
 {
 	int ret = 0;
 
+	mutex_init(&ts->mutex);
+
 	if (pdata->gpio_export) {
 		ts->gc.direction_input = ad7879_gpio_direction_input;
 		ts->gc.direction_output = ad7879_gpio_direction_output;
@@ -452,6 +497,9 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	input_dev->dev.parent = dev;
 	input_dev->id.bustype = bops->bustype;
 
+	input_dev->open = ad7879_open;
+	input_dev->close = ad7879_close;
+
 	__set_bit(EV_ABS, input_dev->evbit);
 	__set_bit(ABS_X, input_dev->absbit);
 	__set_bit(ABS_Y, input_dev->absbit);
@@ -501,8 +549,6 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 			AD7879_ACQ(ts->acquisition_time) |
 			AD7879_TMR(ts->pen_down_acc_interval);
 
-	ad7879_setup(ts);
-
 	err = request_threaded_irq(ts->irq, NULL, ad7879_irq,
 				   IRQF_TRIGGER_FALLING,
 				   dev_name(dev), ts);
@@ -542,7 +588,6 @@ EXPORT_SYMBOL(ad7879_probe);
 void ad7879_remove(struct ad7879 *ts)
 {
 	ad7879_gpio_remove(ts);
-	ad7879_disable(ts);
 	sysfs_remove_group(&ts->dev->kobj, &ad7879_attr_group);
 	free_irq(ts->irq, ts);
 	input_unregister_device(ts->input);
diff --git a/drivers/input/touchscreen/ad7879.h b/drivers/input/touchscreen/ad7879.h
index 169f155..6b45a27 100644
--- a/drivers/input/touchscreen/ad7879.h
+++ b/drivers/input/touchscreen/ad7879.h
@@ -21,8 +21,8 @@ struct ad7879_bus_ops {
 	int (*write)(struct device *dev, u8 reg, u16 val);
 };
 
-void ad7879_disable(struct ad7879 *);
-void ad7879_enable(struct ad7879 *);
+void ad7879_suspend(struct ad7879 *);
+void ad7879_resume(struct ad7879 *);
 struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned irq,
 			    const struct ad7879_bus_ops *bops);
 void ad7879_remove(struct ad7879 *);

