From: Jeffrey Lin <yajohn@gmail.com>
Subject: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Wed, 13 Jan 2016 14:23:24 +0800
Message-ID: <1452666204-372-1-git-send-email-jeffrey.lin@rad-ic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34353 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbcAMGXl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 01:23:41 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

This patch is porting Raydium I2C touch driver. Developer can enable raydium touch driver by modifying define
"CONFIG_TOUCHSCREEN_RM_TS".

Signed-off-by: jeffrey lin <jeffrey.lin@rad-ic.com>
---
 drivers/input/touchscreen/rm31100_ts.c | 571 +++++++++++++++------------------
 1 file changed, 250 insertions(+), 321 deletions(-)

diff --git a/drivers/input/touchscreen/rm31100_ts.c b/drivers/input/touchscreen/rm31100_ts.c
index 941fa31..e024bbd 100644
--- a/drivers/input/touchscreen/rm31100_ts.c
+++ b/drivers/input/touchscreen/rm31100_ts.c
@@ -28,14 +28,11 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
-#ifdef CONFIG_MISC_DEV
-#include <linux/miscdevice.h>
-#endif
 #include <linux/uaccess.h>
 #include <asm/unaligned.h>
 #include <linux/input/mt.h>
@@ -65,27 +62,15 @@ struct rm31100_ts_data {
 };
 
 struct rm3110x_ts_platform_data {
-	int (*power_on)(int on);
-	int (*dev_setup)(bool on);
-	const char *ts_name;
 	u32 dis_min_x; /* display resoltion ABS min*/
 	u32 dis_max_x;/* display resoltion ABS max*/
 	u32 dis_min_y;
 	u32 dis_max_y;
-	u32 min_touch; /* no.of touches supported */
-	u32 max_touch;
-	u32 min_tid; /* track id */
-	u32 max_tid;
-	u32 min_width;/* size of the finger */
-	u32 max_width;
 	u32 res_x; /* TS resolution unit*/
 	u32 res_y;
 	u32 swap_xy;
 	u8 nfingers;
-	u32 irq_gpio;
-	int resout_gpio;
 	bool wakeup;
-	u32 irq_cfg;
 };
 
 static struct rm31100_ts_data devices[] = {
@@ -101,11 +86,26 @@ static struct rm31100_ts_data devices[] = {
 		.touch_meta_data = 1,
 		.finger_size = 70,
 	},
+	[1] = {
+		.x_index = 2,
+		.y_index = 4,
+		.z_index = 6,
+		.id_index = 1,
+		.data_reg = 0x0,
+		.status_reg = 0,
+		.update_data = 0x0,
+		.touch_bytes = 6,
+		.touch_meta_data = 1,
+		.finger_size = 70,
+	},
 };
 
 struct rm31100_ts {
 	struct i2c_client *client;
 	struct input_dev *input;
+	struct regulator *dvdd;
+	struct regulator *avdd;
+	struct gpio_desc *resout_gpio;
 	struct rm3110x_ts_platform_data *pdata;
 	struct rm31100_ts_data *dd;
 	u8 *touch_data;
@@ -115,9 +115,10 @@ struct rm31100_ts {
 	bool int_pending;
 	struct mutex access_lock;
 	u32 pen_irq;
+	u8 fw_version;
+	u8 u8_sub_version;
 };
 
-struct rm31100_ts *pts;
 /*
 static inline u16 join_bytes(u8 a, u8 b)
 {
@@ -168,19 +169,6 @@ static int rm31100_ts_read(struct i2c_client *client, u8 reg, u8 *buf, int num)
 	return i2c_transfer(client->adapter, xfer_msg, 2);
 }
 
-static int
-rm31100_ts_write_client_dma(struct i2c_client *client, u8 *buf, int num)
-{
-	struct i2c_msg xfer_msg[1];
-
-	xfer_msg[0].addr = I2C_DMA_CLIENT_ADDR;
-	xfer_msg[0].len = num;
-	xfer_msg[0].flags = 0;
-	xfer_msg[0].buf = buf;
-
-	return i2c_transfer(client->adapter, xfer_msg, 1);
-}
-
 static int rm31100_ts_write(struct i2c_client *client, u8 *buf, int num)
 {
 	struct i2c_msg xfer_msg[1];
@@ -192,119 +180,27 @@ static int rm31100_ts_write(struct i2c_client *client, u8 *buf, int num)
 
 	return i2c_transfer(client->adapter, xfer_msg, 1);
 }
-#ifdef CONFIG_MISC_DEV
-static int dev_open(struct inode *inode, struct file *filp)
-{
-	mutex_lock(&pts->access_lock);
-	return 0;
-}
 
-static int dev_release(struct inode *inode, struct file *filp)
+static ssize_t rm_fw_version_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
 {
-	mutex_unlock(&pts->access_lock);
-	return 0;
-}
-static ssize_t
-dev_read(struct file *filp, char __user *buf, size_t count, loff_t *pos)
-{
-	u8 *kbuf;
-	struct i2c_msg xfer_msg;
-	/*static char out[] = "1234567890";*/
-	/*static int idx;*//*= 0; remove by checkpatch*/
-	int i;
-
-	kbuf = kmalloc(count, GFP_KERNEL);
-	if (kbuf == NULL)
-		return -ENOMEM;
-
-	/*xfer_msg.addr = pts->client->addr;*/
-	xfer_msg.addr = I2C_CLIENT_ADDR;
-	xfer_msg.len = count;
-	xfer_msg.flags = I2C_M_RD;
-	xfer_msg.buf = kbuf;
-
-	i2c_transfer(pts->client->adapter, &xfer_msg, 1);
-
-	if (copy_to_user(buf, kbuf, count) == 0)
-		return count;
-	else
-		return -EFAULT;
+	struct rm31100_ts *info = dev_get_drvdata(dev);
+	return sprintf(buf, "Release V 0x%02X, Test V 0x%02X\n",
+		info.u8_version,
+		info.u8_sub_version);
 }
 
-static ssize_t
-dev_write(struct file *filp, const char __user *buf, size_t count, loff_t *pos)
-{
-	u8 *kbuf;
-	ssize_t status = 0;
-	int i;
-
-	kbuf = kmalloc(count, GFP_KERNEL);
-	if (kbuf == NULL) {
-		dev_err("kmalloc() fail\n");
-		return -ENOMEM;
-	}
-
-	if (copy_from_user(kbuf, buf, count) == 0) {
-		pts->client->addr = I2C_CLIENT_ADDR;
-		if (rm31100_ts_write(pts->client, kbuf, count) < 0)
-			status = -EFAULT;
-		else
-			status = count;
-	} else {
-		dev_err("copy_from_user() fail\n");
-		status = -EFAULT;
-	}
-
-	kfree(kbuf);
-	return status;
-}
+static DEVICE_ATTR(fw_version, S_IRUGO, rm_fw_version_show, NULL);
 
-static const struct file_operations dev_fops = {
-	.owner = THIS_MODULE,
-	.open = dev_open,
-	.release = dev_release,
-	.read = dev_read,
-	.write = dev_write,
-	/*.unlocked_ioctl = dev_ioctl,*/
+static struct attribute *rm_ts_attributes[] = {
+	&dev_attr_fw_version.attr,
+	NULL
 };
 
-static struct miscdevice raydium_ts_miscdev = {
-	.minor = MISC_DYNAMIC_MINOR,
-	.name = "raydium_ts",
-	.fops = &dev_fops,
+static const struct attribute_group rm_ts_attr_group = {
+	.attrs = rm_ts_attributes,
 };
-#endif
-
-
-ssize_t show(struct device_driver *drv, char *buff)
-{
-	struct i2c_msg xfer_msg;
-	int num = 10;
-	char buf[100];
-	/*int i;*/
-
-	xfer_msg.addr = pts->client->addr;
-	xfer_msg.len = num;
-	xfer_msg.flags = I2C_M_RD;
-	xfer_msg.buf = buf;
-	pts->client->addr = I2C_CLIENT_ADDR;
-	i2c_transfer(pts->client->adapter, &xfer_msg, 1);
-
-	return 0;
-}
-
-ssize_t store(struct device_driver *drv, const char *buf, size_t count)
-{
-	/*unsigned char pkt[] = { 0xF2, 5, 1, 1 };*/
-	unsigned char pkt[] = { 0xF1, 5, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0};
-
-	pts->client->addr = I2C_CLIENT_ADDR;
-	rm31100_ts_write(pts->client, pkt, sizeof(pkt));
-
-	return sizeof(pkt);
-}
-
-DRIVER_ATTR(myAttr, 0x777, show, store);
 
 static void report_data(struct rm31100_ts *dev, u16 x, u16 y,
 	u8 pressure, u8 id)
@@ -319,10 +215,6 @@ static void report_data(struct rm31100_ts *dev, u16 x, u16 y,
 	input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
 	input_report_abs(input_dev, ABS_MT_PRESSURE, pressure);
 	input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, dev->dd->finger_size);
-/*
-	dev_dbg("%s(): id =%2hhd, x =%4hd, y =%4hd, pressure = %hhd\n",
-		__func__, id, x, y, pressure);
-*/
 }
 
 static void process_rm31100_data(struct rm31100_ts *ts)
@@ -348,32 +240,18 @@ static void process_rm31100_data(struct rm31100_ts *ts)
 		input_mt_sync(ts->input);
 
 	ts->prev_touches = touches;
-	/*input_report_key(ts->input, BTN_TOUCH, 1);*/
+
 	input_mt_report_pointer_emulation(ts->input, true);
 	input_sync(ts->input);
 }
 
-/*static void rm31100_ts_xy_worker(struct work_struct *work) JL remove*/
 static void rm31100_ts_xy_worker(struct rm31100_ts *work)
 {
 	int rc;
-	u8 client_dma_package[4] = {0x0f, 0x00, 0x20, 0x81};
 	struct rm31100_ts *ts = work;
 
-	if (ts->is_suspended == true) {
-		dev_dbg(&ts->client->dev, "TS is supended\n");
-		ts->int_pending = true;
-		return;
-	}
-
 	mutex_lock(&ts->access_lock);
 	/* read data from DATA_REG */
-	/*RM31100 DMA Mode*/
-	rc = rm31100_ts_write_client_dma(ts->client, client_dma_package, 0x04);
-	if (rc < 0) {
-		dev_err(&ts->client->dev, "write client dma failed\n");
-		goto schedule;
-	}
 	rc = rm31100_ts_read(ts->client, ts->dd->data_reg, ts->touch_data,
 	ts->dd->data_size);
 
@@ -410,6 +288,61 @@ static irqreturn_t rm31100_ts_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int rm_ts_power_on(struct rm31100_ts *ts)
+{
+	int error;
+
+	/*
+	 * If we do not have reset gpio assume platform firmware
+	 * controls regulators and does power them on for us.
+	 */
+	if (IS_ERR_OR_NULL(ts->resout_gpio))
+		return 0;
+
+	gpiod_set_value_cansleep(ts->resout_gpio, 1);
+
+	error = regulator_enable(ts->avdd);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"failed to enable avdd regulator: %d\n",
+			error);
+		goto release_reset_gpio;
+	}
+
+	error = regulator_enable(ts->dvdd);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"failed to enable dvdd regulator: %d\n",
+			error);
+		regulator_disable(ts->dvdd);
+		goto release_reset_gpio;
+	}
+
+release_reset_gpio:
+	gpiod_set_value_cansleep(ts->resout_gpio, 0);
+	if (error)
+		return error;
+
+	msleep(20);
+
+	return 0;
+}
+
+static void rm_ts_power_off(void *_data)
+{
+	struct rm31100_ts *data = _data;
+
+	if (!IS_ERR_OR_NULL(data->resout_gpio)) {
+		/*
+		 * Activate reset gpio to prevent leakage through the
+		 * pin once we shut off power to the controller.
+		 */
+		gpiod_set_value_cansleep(data->resout_gpio, 1);
+		regulator_disable(data->avdd);
+		regulator_disable(data->dvdd);
+	}
+}
+
 static int rm31100_ts_init_ts(struct i2c_client *client, struct rm31100_ts *ts)
 {
 	/*struct input_dev *input_device;*/
@@ -453,8 +386,7 @@ static int rm31100_ts_init_ts(struct i2c_client *client, struct rm31100_ts *ts)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int rm31100_ts_suspend(struct device *dev)
+static int __maybe_unused rm31100_ts_suspend(struct device *dev)
 {
 	struct rm31100_ts *ts = dev_get_drvdata(dev);
 	int rc = 0;
@@ -467,19 +399,14 @@ static int rm31100_ts_suspend(struct device *dev)
 
 	disable_irq(ts->pen_irq);
 
-	gpio_free(ts->pdata->irq_gpio);
+	gpiod_set_value_cansleep(ts->resout_gpio, 0);
+
+	rm_ts_power_off(ts);
 
-	if (ts->pdata->power_on) {
-		rc = ts->pdata->power_on(0);
-		if (rc) {
-			dev_err(dev, "unable to goto suspend\n");
-			return rc;
-		}
-	}
 	return 0;
 }
 
-static int rm31100_ts_resume(struct device *dev)
+static int __maybe_unused rm31100_ts_resume(struct device *dev)
 {
 	struct rm31100_ts *ts = dev_get_drvdata(dev);
 
@@ -493,12 +420,10 @@ static int rm31100_ts_resume(struct device *dev)
 		if (ts->int_pending == true)
 			ts->int_pending = false;
 	} else {
-		if (ts->pdata->power_on) {
-			rc = ts->pdata->power_on(1);
-			if (rc) {
-				dev_err(dev, "unable to resume\n");
-				return rc;
-			}
+		rc = rm_ts_power_on(ts);
+		if (rc) {
+			dev_err(dev, "unable to resume\n");
+			return rc;
 		}
 
 		enable_irq(ts->pen_irq);
@@ -522,11 +447,15 @@ static int rm31100_ts_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops rm31100_ts_pm_ops = {
-	.suspend = rm31100_ts_suspend,
-	.resume = rm31100_ts_resume,
-};
-#endif
+static void rm_ts_remove_sysfs_group(void *_data)
+{
+	struct rm31100_ts *ts = _data;
+
+	sysfs_remove_group(&ts->client->dev.kobj, &rm_ts_attr_group);
+}
+
+static SIMPLE_DEV_PM_OPS(rm31100_ts_pm_ops,
+			 rm31100_ts_suspend, rm31100_ts_resume);
 
 static int rm_input_dev_create(struct rm31100_ts *ts)
 {
@@ -546,17 +475,26 @@ static int rm_input_dev_create(struct rm31100_ts *ts)
 	input_device->dev.parent = &ts->client->dev;
 	input_set_drvdata(input_device, ts);
 
-	__set_bit(EV_ABS, input_device->evbit);
-	__set_bit(INPUT_PROP_DIRECT, input_device->propbit);
 	__set_bit(BTN_TOUCH, input_device->keybit);
+	__set_bit(EV_ABS, input_device->evbit);
+	__set_bit(EV_KEY, input_device->evbit);
+
+	/* For single touch */
+	input_set_abs_params(input_device, ABS_X,
+			     ts->pdata->dis_min_x, ts->pdata->dis_max_x, 0, 0);
+	input_set_abs_params(input_device, ABS_Y,
+			     ts->pdata->dis_min_x, ts->pdata->dis_max_y, 0, 0);
+	input_set_abs_params(input_device, ABS_PRESSURE,
+			     0, 255, 0, 0);
+	input_abs_set_res(input_device, ABS_X, ts->pdata->res_x);
+	input_abs_set_res(input_device, ABS_Y, ts->pdata->res_y);
+
+	/* Multitouch input params setup */
+	rc = input_mt_init_slots(input_device,
+		MAX_REPORT_TOUCHED_POINTS, INPUT_MT_DIRECT);
+	if (rc)
+		goto error_unreg_device;
 
-
-	if (ts->device_id == rm31100) {
-		/* set up virtual key */
-		__set_bit(EV_KEY, input_device->evbit);
-	}
-	input_mt_init_slots(input_device,
-		MAX_REPORT_TOUCHED_POINTS, 0);
 	input_set_abs_params(input_device, ABS_MT_POSITION_X,
 		ts->pdata->dis_min_x, ts->pdata->dis_max_x, 0, 0);
 	input_set_abs_params(input_device, ABS_MT_POSITION_Y,
@@ -565,6 +503,9 @@ static int rm_input_dev_create(struct rm31100_ts *ts)
 		0, 0xFF, 0, 0);
 	input_set_abs_params(input_device, ABS_MT_TOUCH_MAJOR,
 		0, 0xFF, 0, 0);
+	input_abs_set_res(input_device, ABS_MT_POSITION_X, ts->pdata->res_x);
+	input_abs_set_res(input_device, ABS_MT_POSITION_Y, ts->pdata->res_y);
+
 	rc = input_register_device(input_device);
 	if (rc)
 		goto error_unreg_device;
@@ -581,15 +522,7 @@ error_alloc_dev:
 static int rm31100_initialize(struct i2c_client *client)
 {
 	struct rm31100_ts *ts = i2c_get_clientdata(client);
-	int rc = 0, /*retry_cnt = 0,*/ temp_reg;
-	/* power on the device */
-	if (ts->pdata->power_on) {
-		rc = ts->pdata->power_on(1);
-		if (rc) {
-			pr_err("%s: Unable to power on the device\n", __func__);
-			goto error_dev_setup;
-		}
-	}
+	int rc = 0, temp_reg;
 
 	/* read one byte to make sure i2c device exists */
 	if (ts->device_id == rm3110x)
@@ -602,190 +535,186 @@ static int rm31100_initialize(struct i2c_client *client)
 	rc = rm31100_ts_read_reg_u8(client, temp_reg);
 	if (rc < 0) {
 		dev_err(&client->dev, "i2c sanity check failed\n");
-		goto error_power_on;
+		return rc;
 	}
 
 	rc = rm31100_ts_init_ts(client, ts);
 	if (rc < 0) {
 		dev_err(&client->dev, "rm31100_ts init failed\n");
-		goto error_mutex_destroy;
-	}
-
-	/* configure touchscreen reset out gpio */
-	rc = gpio_request(ts->pdata->resout_gpio, "rm31100_resout_gpio");
-	if (rc) {
-		pr_err("%s: unable to request gpio %d\n",
-			__func__, ts->pdata->resout_gpio);
-		goto error_uninit_ts;
-	}
-
-	rc = gpio_direction_output(ts->pdata->resout_gpio, 0);
-	if (rc) {
-		pr_err("%s: unable to set direction for gpio %d\n",
-			__func__, ts->pdata->resout_gpio);
-		goto error_resout_gpio_dir;
+		return rc;
 	}
-	/* reset gpio stabilization time */
-	msleep(20);
 
 	return 0;
-error_resout_gpio_dir:
-	if (ts->pdata->resout_gpio >= 0)
-		gpio_free(ts->pdata->resout_gpio);
-error_uninit_ts:
-	input_unregister_device(ts->input);
-	kfree(ts->touch_data);
-error_mutex_destroy:
-	mutex_destroy(&ts->access_lock);
-error_power_on:
-	if (ts->pdata->power_on)
-		ts->pdata->power_on(0);
-error_dev_setup:
-	if (ts->pdata->dev_setup)
-		ts->pdata->dev_setup(0);
-	return rc;
 }
 
-static void rm_initialize_async(void *data, async_cookie_t cookie)
+static int rm31100_ts_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
-	struct rm31100_ts *ts = data;
-	struct i2c_client *client = ts->client;
-	unsigned long irqflags;
-	int err = 0;
-
-	mutex_lock(&ts->access_lock);
+	struct rm31100_ts *ts;
+	struct rm3110x_ts_platform_data *pdata = client->dev.platform_data;
+	int rc;
+	union i2c_smbus_data dummy;
 
-	err = rm31100_initialize(client);
-	if (err < 0) {
-		dev_err(&client->dev, "probe failed! unbind device.\n");
-		goto error_free_mem;
+	ts = devm_kzalloc(&client->dev, sizeof(struct rm31100_ts), GFP_KERNEL);
+	if (!ts) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		return -ENOMEM;
 	}
 
-	err = rm_input_dev_create(ts);
-	if (err) {
-		dev_err(&client->dev, "%s crated failed, %d\n", __func__, err);
-		goto error_goio_release;
+	if (!i2c_check_functionality(client->adapter,
+		I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+		dev_err(&client->dev, "I2C functionality not supported\n");
+		rc = -EIO;
+		goto error_touch_data_alloc;
 	}
 
-	irqflags = client->dev.of_node ? 0 : IRQF_TRIGGER_FALLING;
+	ts->client = client;
+	ts->pdata = pdata;
+	i2c_set_clientdata(client, ts);
+	ts->device_id = id->driver_data;
 
-	err = request_threaded_irq(ts->pen_irq, NULL,
-				   rm31100_ts_irq,
-				   irqflags | IRQF_ONESHOT,
-				   ts->client->dev.driver->name, ts);
-	if (err) {
-		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto error_dev_release;
-	}
+	ts->is_suspended = false;
+	ts->int_pending = false;
 
-	mutex_unlock(&ts->access_lock);
+	mutex_init(&ts->access_lock);
 
-	return;
+	ts->avdd = devm_regulator_get(&client->dev, "avdd");
+	if (IS_ERR(ts->avdd)) {
+		rc = PTR_ERR(ts->avdd);
+		if (rc != -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"Failed to get 'avdd' regulator: %d\n",
+				rc);
+		return rc;
+	}
 
-error_dev_release:
-	input_free_device(ts->input);
-error_goio_release:
-	if (ts->pdata->resout_gpio >= 0)
-		gpio_free(ts->pdata->resout_gpio);
-error_free_mem:
-	mutex_unlock(&ts->access_lock);
-	kfree(ts);
-	return;
-}
+	ts->dvdd = devm_regulator_get(&client->dev, "dvdd");
+	if (IS_ERR(ts->dvdd)) {
+		rc = PTR_ERR(ts->dvdd);
+		if (rc != -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"Failed to get 'dvdd' regulator: %d\n",
+				rc);
+		return rc;
+	}
+
+	ts->resout_gpio = devm_gpiod_get(&client->dev, "rm31100_resout_gpio");
+	if (IS_ERR(ts->resout_gpio)) {
+		rc = PTR_ERR(ts->resout_gpio);
+
+		/*
+		 * On Chromebooks vendors like to source touch panels from
+		 * different vendors, but they are connected to the same
+		 * regulators/GPIO pin. The drivers also use asynchronous
+		 * probing, which means that more than one driver will
+		 * attempt to claim the reset line. If we find it busy,
+		 * let's try again later.
+		 */
+		if (rc == -EBUSY) {
+			dev_info(&client->dev,
+				 "reset gpio is busy, deferring probe\n");
+			return -EPROBE_DEFER;
+		}
 
+		if (rc == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 
-/*static int __devinit rm31100_ts_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)*/
-static int rm31100_ts_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
-{
-	struct rm31100_ts *ts;
-	struct rm3110x_ts_platform_data *pdata = client->dev.platform_data;
-	int rc/*, temp_reg*/;
-	union i2c_smbus_data dummy;
+		if (rc != -ENOENT && rc != -ENOSYS) {
+			dev_err(&client->dev,
+				"failed to get reset gpio: %d\n",
+				rc);
+			return rc;
+		}
 
-	if (!pdata) {
-		dev_err(&client->dev, "platform data is required!\n");
-		return -EINVAL;
+	} else {
+		rc = gpiod_direction_output(ts->resout_gpio, 0);
+		if (rc) {
+			dev_err(&client->dev,
+				"failed to configure reset gpio as output: %d\n",
+				rc);
+			return rc;
+		}
 	}
 
-	if (!i2c_check_functionality(client->adapter,
-		I2C_FUNC_SMBUS_READ_WORD_DATA)) {
-		dev_err(&client->dev, "I2C functionality not supported\n");
-		return -EIO;
+	rc = rm_ts_power_on(ts);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action(&client->dev, rm_ts_power_off, ts);
+	if (rc) {
+		dev_err(&client->dev,
+			"failed to install power off action: %d\n", rc);
+		rm_ts_power_off(ts);
+		return rc;
 	}
+
 	/* Make sure there is something at this address */
 	if (i2c_smbus_xfer(client->adapter, client->addr, 0,
 		I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &dummy) < 0)
 		return -ENODEV;
 
-	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-	if (!ts)
-		return -ENOMEM;
-	pts = ts;
-
-	/* Enable runtime PM ops, start in ACTIVE mode */
-	rc = pm_runtime_set_active(&client->dev);
-	if (rc < 0)
-		dev_warn(&client->dev, "unable to set runtime pm state\n");
-	pm_runtime_enable(&client->dev);
-
-	ts->client = client;
-	ts->pdata = pdata;
-	i2c_set_clientdata(client, ts);
-	ts->device_id = id->driver_data;
+	rc = rm31100_initialize(client);
+	if (rc < 0) {
+		dev_err(&client->dev, "probe failed! unbind device.\n");
+		return rc;
+	}
 
-	if (ts->pdata->dev_setup) {
-		rc = ts->pdata->dev_setup(1);
-		if (rc < 0) {
-			dev_err(&client->dev, "dev setup failed\n");
-			goto error_touch_data_alloc;
-		}
+	rc = rm_input_dev_create(ts);
+	if (rc) {
+		dev_err(&client->dev, "%s crated failed, %d\n", __func__, err);
+		return rc;
 	}
 
+	rc = devm_request_threaded_irq(&client->dev, ts->pen_irq,
+					NULL, rm31100_ts_irq,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					client->name, ts);
+	if (rc) {
+		dev_err(&client->dev, "Failed to register interrupt\n");
+		return rc;
+	}
 
-	ts->is_suspended = false;
-	ts->int_pending = false;
-	/*mutex_init(&ts->sus_lock); JL remove*/
-	mutex_init(&ts->access_lock);
+	device_set_wakeup_enable(&client->dev, false);
 
-	async_schedule(rm_initialize_async, ts);
+	rc = sysfs_create_group(&client->dev.kobj, &rm_ts_attr_group);
+	if (rc) {
+		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
+			rc);
+		return rc;
+	}
 
-	device_init_wakeup(&client->dev, ts->pdata->wakeup);
+	rc = devm_add_action(&client->dev,
+				rm_ts_remove_sysfs_group, ts);
+	if (rc) {
+		rm_ts_remove_sysfs_group(ts);
+		dev_err(&client->dev,
+			"Failed to add sysfs cleanup action: %d\n",
+			rc);
+		return rc;
+	}
 	return 0;
 
 error_touch_data_alloc:
-	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_disable(&client->dev);
 	kfree(ts);
 	return rc;
 }
 
-/*static int __devexit RM31100_ts_remove(struct i2c_client *client)*/
 static int rm31100_ts_remove(struct i2c_client *client)
 {
 	struct rm31100_ts *ts = i2c_get_clientdata(client);
 
-	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_disable(&client->dev);
-
 	device_init_wakeup(&client->dev, 0);
 	free_irq(ts->pen_irq, ts);
 
-	gpio_free(ts->pdata->irq_gpio);
+	if (ts->resout_gpio >= 0)
+		gpiod_set_value_cansleep(ts->resout_gpio, 0);
 
-	if (ts->pdata->resout_gpio >= 0)
-		gpio_free(ts->pdata->resout_gpio);
 	input_unregister_device(ts->input);
 
 	/*mutex_destroy(&ts->sus_lock); JL remove*/
 	mutex_destroy(&ts->access_lock);
 
-	if (ts->pdata->power_on)
-		ts->pdata->power_on(0);
-
-	if (ts->pdata->dev_setup)
-		ts->pdata->dev_setup(0);
+	rm_ts_power_off(ts);
 
 	kfree(ts->touch_data);
 	kfree(ts);
-- 
2.1.2

