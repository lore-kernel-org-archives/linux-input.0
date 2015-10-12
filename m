From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v9 3/9] Input: goodix - write configuration data to device
Date: Mon, 12 Oct 2015 18:24:31 +0300
Message-ID: <1444663477-30062-4-git-send-email-irina.tirdea@intel.com>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Goodix devices can be configured by writing custom data to the device at
init. The configuration data is read with request_firmware from
"goodix_<id>_cfg.bin", where <id> is the product id read from the device
(e.g.: goodix_911_cfg.bin for Goodix GT911, goodix_9271_cfg.bin for
GT9271).

The configuration information has a specific format described in the Goodix
datasheet. It includes X/Y resolution, maximum supported touch points,
interrupt flags, various sensitivity factors and settings for advanced
features (like gesture recognition).

Before writing the firmware, it is necessary to reset the device. If
the device ACPI/DT information does not declare gpio pins (needed for
reset), writing the firmware will not be available for these devices.

This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
driver gt9xx.c for Android (publicly available in Android kernel
trees for various devices).

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Tested-by: Bastien Nocera <hadess@hadess.net>
Tested-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 drivers/input/touchscreen/goodix.c | 229 +++++++++++++++++++++++++++++++------
 1 file changed, 196 insertions(+), 33 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 87304ac..b4dfe4b 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/dmi.h>
+#include <linux/firmware.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
@@ -40,6 +41,9 @@ struct goodix_ts_data {
 	int cfg_len;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
+	u16 id;
+	u16 version;
+	char *cfg_name;
 };
 
 #define GOODIX_GPIO_INT_NAME		"irq"
@@ -124,6 +128,39 @@ static int goodix_i2c_read(struct i2c_client *client,
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
 static int goodix_get_cfg_len(u16 id)
 {
 	switch (id) {
@@ -243,6 +280,73 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
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
+	int error;
+
+	error = goodix_check_cfg(ts, cfg);
+	if (error)
+		return error;
+
+	error = goodix_i2c_write(ts->client, GOODIX_REG_CONFIG_DATA, cfg->data,
+				 cfg->size);
+	if (error) {
+		dev_err(&ts->client->dev, "Failed to write config data: %d",
+			error);
+		return error;
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
 	int error;
@@ -371,30 +475,29 @@ static void goodix_read_config(struct goodix_ts_data *ts)
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
@@ -428,13 +531,10 @@ static int goodix_i2c_test(struct i2c_client *client)
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
 
@@ -458,8 +558,8 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts, u16 version,
 	ts->input_dev->phys = "input/ts";
 	ts->input_dev->id.bustype = BUS_I2C;
 	ts->input_dev->id.vendor = 0x0416;
-	ts->input_dev->id.product = id;
-	ts->input_dev->id.version = version;
+	ts->input_dev->id.product = ts->id;
+	ts->input_dev->id.version = ts->version;
 
 	error = input_register_device(ts->input_dev);
 	if (error) {
@@ -471,13 +571,70 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts, u16 version,
 	return 0;
 }
 
+/**
+ * goodix_configure_dev - Finish device initialization
+ *
+ * @ts: our goodix_ts_data pointer
+ *
+ * Must be called from probe to finish initialization of the device.
+ * Contains the common initialization code for both devices that
+ * declare gpio pins and devices that do not. It is either called
+ * directly from probe or from request_firmware_wait callback.
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
 
@@ -512,30 +669,36 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = goodix_read_version(client, &version_info, &id_info);
+	error = goodix_read_version(ts);
 	if (error) {
 		dev_err(&client->dev, "Read version failed.\n");
 		return error;
 	}
 
-	ts->cfg_len = goodix_get_cfg_len(id_info);
+	ts->cfg_len = goodix_get_cfg_len(ts->id);
 
-	goodix_read_config(ts);
-
-	error = goodix_request_input_dev(ts, version_info, id_info);
-	if (error)
-		return error;
+	if (ts->gpiod_int && ts->gpiod_rst) {
+		/* update device config */
+		ts->cfg_name = kasprintf(GFP_KERNEL, "goodix_%d_cfg.bin",
+					 ts->id);
+		if (!ts->cfg_name)
+			return -ENOMEM;
+
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
