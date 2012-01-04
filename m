From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH] auo-pixcir-ts: expose some properties via sysfs
Date: Wed, 4 Jan 2012 13:02:58 +0100
Message-ID: <201201041302.58890.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1778886.stratoserver.net ([85.214.133.74]:35299 "EHLO
	h1778886.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab2ADMDE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jan 2012 07:03:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The controller contains some properties that could be interesting to users:

autosleep: after a configurable idle time, enter the sleep mode
           automatically; wakeup is done on the first touch.
sensitivity: touch-sensitivity for the x and y axes
powermode: the current power mode the device is in (read only), this
           also shows the current state in autosleep mode
firmware_version: read only

This patch exposes these via sysfs and lets the user configure
sensitivity and autosleep delay.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/input/touchscreen/auo-pixcir-ts.c |  189 +++++++++++++++++++++++++++++
 1 files changed, 189 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 94fb9fb..3b3ec68 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -91,6 +91,7 @@
 #define AUO_PIXCIR_POWER_MASK		0x03
 
 #define AUO_PIXCIR_POWER_ALLOW_SLEEP	(1 << 2)
+#define AUO_PIXCIR_POWER_IDLE_SHIFT	4
 #define AUO_PIXCIR_POWER_IDLE_TIME(ms)	((ms & 0xf) << 4)
 
 #define AUO_PIXCIR_CALIBRATE		0x03
@@ -286,6 +287,37 @@ static int auo_pixcir_power_mode(struct auo_pixcir_ts *ts, int mode)
 	return 0;
 }
 
+static int auo_pixcir_autosleep(struct auo_pixcir_ts *ts, unsigned int ms)
+{
+	struct i2c_client *client = ts->client;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_POWER_MODE);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to read reg %Xh, %d\n",
+			AUO_PIXCIR_REG_POWER_MODE, ret);
+		return ret;
+	}
+
+	if (ms > 0) {
+		dev_dbg(&client->dev, "activating autosleep\n");
+		ret |= AUO_PIXCIR_POWER_ALLOW_SLEEP;
+		ret |= AUO_PIXCIR_POWER_IDLE_TIME(ms);
+	} else {
+		dev_dbg(&client->dev, "deactivating autosleep\n");
+		ret &= ~AUO_PIXCIR_POWER_ALLOW_SLEEP;
+	}
+
+	ret = i2c_smbus_write_byte_data(client, AUO_PIXCIR_REG_POWER_MODE, ret);
+	if (ret) {
+		dev_err(&client->dev, "unable to write reg %Xh, %d\n",
+			AUO_PIXCIR_REG_POWER_MODE, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static __devinit int auo_pixcir_int_config(struct auo_pixcir_ts *ts,
 					   int int_setting)
 {
@@ -415,6 +447,155 @@ static void auo_pixcir_input_close(struct input_dev *dev)
 	return;
 }
 
+/*
+ * sysfs-attributes
+ */
+
+static ssize_t auo_pixcir_autosleep_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_POWER_MODE);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to read reg %Xh, %d\n",
+			AUO_PIXCIR_REG_POWER_MODE, ret);
+		return ret;
+	}
+
+	ret = (ret & AUO_PIXCIR_POWER_ALLOW_SLEEP)
+			? ret >> AUO_PIXCIR_POWER_IDLE_SHIFT
+			: 0;
+
+	return sprintf(buf, "%d\n", ret);
+}
+
+static ssize_t auo_pixcir_autosleep_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct auo_pixcir_ts *ts = i2c_get_clientdata(client);
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = auo_pixcir_autosleep(ts, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t auo_pixcir_powermode_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_POWER_MODE);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to read reg %Xh, %d\n",
+			AUO_PIXCIR_REG_POWER_MODE, ret);
+		return ret;
+	}
+
+	ret &= AUO_PIXCIR_POWER_MASK;
+
+	return sprintf(buf, "%d\n", ret);
+}
+
+static ssize_t auo_pixcir_firmware_version_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_VERSION);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to read reg %Xh, %d\n",
+			AUO_PIXCIR_REG_VERSION, ret);
+		return ret;
+	}
+
+	return sprintf(buf, "%d\n", ret);
+}
+
+static ssize_t auo_pixcir_sensitivity_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int reg, ret;
+
+	reg = strncmp(attr->attr.name, "sensitivity_x", 13)
+				? AUO_PIXCIR_REG_Y_SENSITIVITY
+				: AUO_PIXCIR_REG_X_SENSITIVITY;
+
+	ret = i2c_smbus_read_byte_data(client, reg);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to read reg %Xh, %d\n", reg, ret);
+		return ret;
+	}
+
+	return sprintf(buf, "%d\n", ret);
+}
+
+static ssize_t auo_pixcir_sensitivity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int reg, ret, val;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	reg = strncmp(attr->attr.name, "sensitivity_x", 13)
+				? AUO_PIXCIR_REG_Y_SENSITIVITY
+				: AUO_PIXCIR_REG_X_SENSITIVITY;
+
+	ret = i2c_smbus_write_byte_data(client, reg, val);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to write reg %Xh, %d\n",
+			reg, ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(autosleep, 0644, auo_pixcir_autosleep_show,
+		   auo_pixcir_autosleep_store);
+static DEVICE_ATTR(powermode, 0444, auo_pixcir_powermode_show, NULL);
+static DEVICE_ATTR(firmware_version, 0444, auo_pixcir_firmware_version_show,
+		   NULL);
+static DEVICE_ATTR(sensitivity_x, 0644, auo_pixcir_sensitivity_show,
+		   auo_pixcir_sensitivity_store);
+static DEVICE_ATTR(sensitivity_y, 0644, auo_pixcir_sensitivity_show,
+		   auo_pixcir_sensitivity_store);
+
+static struct attribute *auo_pixcir_attributes[] = {
+	&dev_attr_autosleep.attr,
+	&dev_attr_powermode.attr,
+	&dev_attr_firmware_version.attr,
+	&dev_attr_sensitivity_x.attr,
+	&dev_attr_sensitivity_y.attr,
+	NULL
+};
+
+static const struct attribute_group auo_pixcir_attr_group = {
+	.attrs		= auo_pixcir_attributes,
+};
+
 #ifdef CONFIG_PM_SLEEP
 static int auo_pixcir_suspend(struct device *dev)
 {
@@ -583,8 +764,14 @@ static int __devinit auo_pixcir_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ts);
 
+	ret = sysfs_create_group(&client->dev.kobj, &auo_pixcir_attr_group);
+	if (ret)
+		goto err_sysfs_register;
+
 	return 0;
 
+err_sysfs_register:
+	input_unregister_device(ts->input);
 err_input_register:
 	free_irq(client->irq, ts);
 err_fw_vers:
@@ -604,6 +791,8 @@ static int __devexit auo_pixcir_remove(struct i2c_client *client)
 	struct auo_pixcir_ts *ts = i2c_get_clientdata(client);
 	const struct auo_pixcir_ts_platdata *pdata = client->dev.platform_data;
 
+	sysfs_remove_group(&client->dev.kobj, &auo_pixcir_attr_group);
+
 	free_irq(client->irq, ts);
 
 	input_unregister_device(ts->input);
-- 
1.7.5.4

