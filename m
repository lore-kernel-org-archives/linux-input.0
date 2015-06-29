From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v3 2/5] Input: goodix - write configuration data to device
Date: Mon, 29 Jun 2015 19:28:21 +0300
Message-ID: <1435595304-4840-3-git-send-email-irina.tirdea@intel.com>
References: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6193 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbbF2Q3g (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 12:29:36 -0400
In-Reply-To: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>

Goodix devices can be configured by writing custom data to the device at
init. The configuration data is read with request_firmware from
"goodix_<id>_cfg.bin", where <id> is the product id read from the device
(e.g.: goodix_911_cfg.bin for Goodix GT911, goodix_9271_cfg.bin for
GT9271).

The configuration information has a specific format described in the Goodix
datasheet. It includes X/Y resolution, maximum supported touch points,
interrupt flags, various sesitivity factors and settings for advanced
features (like gesture recognition).

Before writing the firmware, it is necessary to reset the device. If
the device ACPI/DT information does not declare gpio pins (needed for
reset), writing the firmware will not be available for these devices.

This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
driver gt9xx.c for Android (publicly available in Android kernel
trees for various devices).

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 223 +++++++++++++++++++++++++++++++------
 1 file changed, 191 insertions(+), 32 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 80100f9..d2d72c1 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/firmware.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
 #include <asm/unaligned.h>
@@ -37,6 +38,9 @@ struct goodix_ts_data {
 	unsigned int int_trigger_type;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
+	u16 id;
+	u16 version;
+	char *cfg_name;
 };
 
 struct goodix_gpio_data {
@@ -107,6 +111,39 @@ static int goodix_i2c_read(struct i2c_client *client,
 	return ret < 0 ? ret : (ret != ARRAY_SIZE(msgs) ? -EIO : 0);
 }
 
+/**
+ * goodix_i2c_write - write data to a register of the i2c slave device.
+ *
+ * @client: i2c device.
+ * @reg: the register to write to.
+ * @buf: raw data buffer to write.
+ * @len: length of the buffer to write
+ */
+static int goodix_i2c_write(struct i2c_client *client, u16 reg, const u8 *buf,
+			    unsigned len)
+{
+	u8 *addr_buf;
+	struct i2c_msg msg;
+	int ret;
+
+	addr_buf = kmalloc(len + 2, GFP_KERNEL);
+	if (!addr_buf)
+		return -ENOMEM;
+
+	addr_buf[0] = reg >> 8;
+	addr_buf[1] = reg & 0xFF;
+	memcpy(&addr_buf[2], buf, len);
+
+	msg.flags = 0;
+	msg.addr = client->addr;
+	msg.buf = addr_buf;
+	msg.len = len + 2;
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	kfree(addr_buf);
+	return ret < 0 ? ret : (ret != 1 ? -EIO : 0);
+}
+
 static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 {
 	int touch_num;
@@ -204,6 +241,73 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * goodix_check_cfg - Checks if config fw is valid
+ *
+ * @ts: goodix_ts_data pointer
+ * @cfg: firmware config data
+ */
+static int goodix_check_cfg(struct goodix_ts_data *ts,
+			    const struct firmware *cfg)
+{
+	int i, raw_cfg_len;
+	u8 check_sum = 0;
+
+	if (cfg->size > GOODIX_CONFIG_MAX_LENGTH) {
+		dev_err(&ts->client->dev,
+			"The length of the config fw is not correct");
+		return -EINVAL;
+	}
+
+	raw_cfg_len = cfg->size - 2;
+	for (i = 0; i < raw_cfg_len; i++)
+		check_sum += cfg->data[i];
+	check_sum = (~check_sum) + 1;
+	if (check_sum != cfg->data[raw_cfg_len]) {
+		dev_err(&ts->client->dev,
+			"The checksum of the config fw is not correct");
+		return -EINVAL;
+	}
+
+	if (cfg->data[raw_cfg_len + 1] != 1) {
+		dev_err(&ts->client->dev,
+			"Config fw must have Config_Fresh register set");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * goodix_send_cfg - Write fw config to device
+ *
+ * @ts: goodix_ts_data pointer
+ * @cfg: config firmware to write to device
+ */
+static int goodix_send_cfg(struct goodix_ts_data *ts,
+			   const struct firmware *cfg)
+{
+	int ret;
+
+	ret = goodix_check_cfg(ts, cfg);
+	if (ret)
+		return ret;
+
+	ret = goodix_i2c_write(ts->client, GOODIX_REG_CONFIG_DATA, cfg->data,
+			       cfg->size);
+	if (ret) {
+		dev_err(&ts->client->dev, "Failed to write config data: %d",
+			ret);
+		return ret;
+	}
+	dev_dbg(&ts->client->dev, "Config sent successfully.");
+
+	/* Let the firmware reconfigure itself, so sleep for 10ms */
+	usleep_range(10000, 11000);
+
+	return 0;
+}
+
 static int goodix_int_sync(struct goodix_ts_data *ts)
 {
 	int ret;
@@ -342,30 +446,29 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 /**
  * goodix_read_version - Read goodix touchscreen version
  *
- * @client: the i2c client
- * @version: output buffer containing the version on success
- * @id: output buffer containing the id on success
+ * @ts: our goodix_ts_data pointer
  */
-static int goodix_read_version(struct i2c_client *client, u16 *version, u16 *id)
+static int goodix_read_version(struct goodix_ts_data *ts)
 {
 	int error;
 	u8 buf[6];
 	char id_str[5];
 
-	error = goodix_i2c_read(client, GOODIX_REG_ID, buf, sizeof(buf));
+	error = goodix_i2c_read(ts->client, GOODIX_REG_ID, buf, sizeof(buf));
 	if (error) {
-		dev_err(&client->dev, "read version failed: %d\n", error);
+		dev_err(&ts->client->dev, "read version failed: %d\n", error);
 		return error;
 	}
 
 	memcpy(id_str, buf, 4);
 	id_str[4] = 0;
-	if (kstrtou16(id_str, 10, id))
-		*id = 0x1001;
+	if (kstrtou16(id_str, 10, &ts->id))
+		ts->id = 0x1001;
 
-	*version = get_unaligned_le16(&buf[4]);
+	ts->version = get_unaligned_le16(&buf[4]);
 
-	dev_info(&client->dev, "ID %d, version: %04x\n", *id, *version);
+	dev_info(&ts->client->dev, "ID %d, version: %04x\n", ts->id,
+		 ts->version);
 
 	return 0;
 }
@@ -399,13 +502,10 @@ static int goodix_i2c_test(struct i2c_client *client)
  * goodix_request_input_dev - Allocate, populate and register the input device
  *
  * @ts: our goodix_ts_data pointer
- * @version: device firmware version
- * @id: device ID
  *
  * Must be called during probe
  */
-static int goodix_request_input_dev(struct goodix_ts_data *ts, u16 version,
-				    u16 id)
+static int goodix_request_input_dev(struct goodix_ts_data *ts)
 {
 	int error;
 
@@ -429,8 +529,8 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts, u16 version,
 	ts->input_dev->phys = "input/ts";
 	ts->input_dev->id.bustype = BUS_I2C;
 	ts->input_dev->id.vendor = 0x0416;
-	ts->input_dev->id.product = id;
-	ts->input_dev->id.version = version;
+	ts->input_dev->id.product = ts->id;
+	ts->input_dev->id.version = ts->version;
 
 	error = input_register_device(ts->input_dev);
 	if (error) {
@@ -442,13 +542,68 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts, u16 version,
 	return 0;
 }
 
+/**
+ * goodix_configure_dev - Finish device initialization
+ *
+ * @ts: our goodix_ts_data pointer
+ *
+ * Must be called from request_firmware_wait callback to
+ * finish initialization of the device.
+ */
+static int goodix_configure_dev(struct goodix_ts_data *ts)
+{
+	int error;
+	unsigned long irq_flags;
+
+	goodix_read_config(ts);
+
+	error = goodix_request_input_dev(ts);
+	if (error)
+		return error;
+
+	irq_flags = goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
+	error = devm_request_threaded_irq(&ts->client->dev, ts->client->irq,
+					  NULL, goodix_ts_irq_handler,
+					  irq_flags, ts->client->name, ts);
+	if (error) {
+		dev_err(&ts->client->dev, "request IRQ failed: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+/**
+ * goodix_config_cb - Callback to finish device init
+ *
+ * @ts: our goodix_ts_data pointer
+ *
+ * request_firmware_wait callback that finishes
+ * initialization of the device.
+ */
+static void goodix_config_cb(const struct firmware *cfg, void *ctx)
+{
+	struct goodix_ts_data *ts = (struct goodix_ts_data *)ctx;
+	int error;
+
+	if (cfg) {
+		/* send device configuration to the firmware */
+		error = goodix_send_cfg(ts, cfg);
+		if (error)
+			goto err_release_cfg;
+	}
+	goodix_configure_dev(ts);
+
+err_release_cfg:
+	kfree(ts->cfg_name);
+	release_firmware(cfg);
+}
+
 static int goodix_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	struct goodix_ts_data *ts;
-	unsigned long irq_flags;
 	int error;
-	u16 version_info, id_info;
 
 	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
 
@@ -470,7 +625,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = goodix_read_version(client, &version_info, &id_info);
+	error = goodix_read_version(ts);
 	if (error) {
 		dev_err(&client->dev, "Read version failed.\n");
 		return error;
@@ -487,24 +642,28 @@ static int goodix_ts_probe(struct i2c_client *client,
 			dev_err(&client->dev, "Controller reset failed.\n");
 			return error;
 		}
-	}
 
-	goodix_read_config(ts);
+		/* update device config */
+		ts->cfg_name = kasprintf(GFP_KERNEL, "goodix_%d_cfg.bin",
+					 ts->id);
+		if (!ts->cfg_name)
+			return -ENOMEM;
 
-	error = goodix_request_input_dev(ts, version_info, id_info);
-	if (error)
-		return error;
+		error = request_firmware_nowait(THIS_MODULE, true, ts->cfg_name,
+						&client->dev, GFP_KERNEL, ts,
+						goodix_config_cb);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to invoke firmware loader: %d\n",
+				error);
+			kfree(ts->cfg_name);
+			return error;
+		}
 
-	irq_flags = goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
-	error = devm_request_threaded_irq(&ts->client->dev, client->irq,
-					  NULL, goodix_ts_irq_handler,
-					  irq_flags, client->name, ts);
-	if (error) {
-		dev_err(&client->dev, "request IRQ failed: %d\n", error);
-		return error;
+		return 0;
 	}
 
-	return 0;
+	return goodix_configure_dev(ts);
 }
 
 static const struct i2c_device_id goodix_ts_id[] = {
-- 
1.9.1

