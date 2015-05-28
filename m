From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 6/9] input: goodix: write configuration data to device
Date: Thu, 28 May 2015 15:47:42 +0300
Message-ID: <1432817265-23891-7-git-send-email-irina.tirdea@intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-input@vger.kernel.org

Goodix devices can be configured by writing this information
to the device at init. The configuration data can
be provided through the ACPI/device tree property
"device-config". If "device-config" is not set, the default
device configuration will be used.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 .../bindings/input/touchscreen/goodix.txt          |   5 +
 drivers/input/touchscreen/goodix.c                 | 143 +++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 7137881..9e4ff69 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -15,6 +15,11 @@ Required properties:
  - irq-gpio		: GPIO pin used for IRQ
  - reset-gpio		: GPIO pin used for reset
 
+Optional properties:
+
+ - device-config	: device configuration information (specified as byte
+			  array). Maximum size is 240 bytes.
+
 Example:
 
 	i2c@00000000 {
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 4405c55..22052c9 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -41,6 +41,8 @@ struct goodix_ts_data {
 
 #define GOODIX_GPIO_INT_NAME		"irq"
 #define GOODIX_GPIO_RST_NAME		"reset"
+#define GOODIX_DEVICE_CONFIG_PROPERTY	"device-config"
+
 #define GOODIX_MAX_HEIGHT		4096
 #define GOODIX_MAX_WIDTH		4096
 #define GOODIX_INT_TRIGGER		1
@@ -94,6 +96,39 @@ static int goodix_i2c_read(struct i2c_client *client,
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
+static int goodix_i2c_write(struct i2c_client *client, u16 reg, u8 *buf,
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
@@ -192,6 +227,109 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * goodix_get_cfg - Get device config from ACPI/DT.
+ *
+ * @ts: goodix_ts_data pointer
+ * @config: pointer to the config buffer
+ * @cfg_len: pointer to size of the config buffer
+ */
+static int goodix_get_cfg(struct goodix_ts_data *ts, u8 **config, int *cfg_len)
+{
+	int ret, i, raw_cfg_len;
+	u8 check_sum = 0;
+
+	ret = device_property_read_u8_array(&ts->client->dev,
+					    GOODIX_DEVICE_CONFIG_PROPERTY,
+					    NULL, 0);
+	if (ret <= 0) {
+		dev_err(&ts->client->dev, "No %s property.\n",
+			GOODIX_DEVICE_CONFIG_PROPERTY);
+		return 0;
+	}
+
+	*cfg_len = ret;
+	if (*cfg_len > GOODIX_CONFIG_MAX_LENGTH) {
+		dev_err(&ts->client->dev,
+			"The length of the config buffer array is not correct");
+		return -EINVAL;
+	}
+
+	*config = kmalloc(*cfg_len, GFP_KERNEL);
+	if (!*config)
+		return -ENOMEM;
+
+	ret = device_property_read_u8_array(&ts->client->dev,
+					    GOODIX_DEVICE_CONFIG_PROPERTY,
+					    *config, *cfg_len);
+	if (ret < 0) {
+		dev_err(&ts->client->dev, "Invalid %s property: %d\n",
+			GOODIX_DEVICE_CONFIG_PROPERTY, ret);
+		goto err_free;
+	}
+
+	raw_cfg_len = *cfg_len - 2;
+	for (i = 0; i < raw_cfg_len; i++)
+		check_sum += (*config)[i];
+	check_sum = (~check_sum) + 1;
+	if (check_sum != (*config)[raw_cfg_len]) {
+		dev_err(&ts->client->dev,
+			"The checksum of the config buffer array is not correct");
+		ret = -EINVAL;
+		goto err_free;
+	}
+	if ((*config)[raw_cfg_len + 1] != 1) {
+		dev_err(&ts->client->dev,
+			"The Config_Fresh register needs to be set");
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	kfree(*config);
+	return ret;
+}
+
+/**
+ * goodix_send_cfg - Write device config
+ *
+ * @ts: goodix_ts_data pointer
+ */
+static int goodix_send_cfg(struct goodix_ts_data *ts)
+{
+	int ret, cfg_len = 0;
+	u8 *config = NULL;
+
+	ret = goodix_get_cfg(ts, &config, &cfg_len);
+	if (ret)
+		return ret;
+
+	/* No config property in device tree */
+	if (!cfg_len)
+		return 0;
+
+	ret = goodix_i2c_write(ts->client, GOODIX_REG_CONFIG_DATA, config,
+			       cfg_len);
+	if (ret) {
+		dev_err(&ts->client->dev, "Failed to send the config : %d",
+			ret);
+		goto err_free;
+	}
+	dev_dbg(&ts->client->dev, "Config sent successfully.");
+
+	/* Let the firmware reconfigure itself, so sleep for 10ms */
+	usleep_range(10000, 11000);
+
+	kfree(config);
+	return 0;
+
+err_free:
+	kfree(config);
+	return ret;
+}
+
 static int goodix_int_sync(struct goodix_ts_data *ts)
 {
 	int ret;
@@ -465,6 +603,11 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	/* send device configuration to the firmware */
+	error = goodix_send_cfg(ts);
+	if (error)
+		return error;
+
 	goodix_read_config(ts);
 
 	error = goodix_request_input_dev(ts, version_info, id_info);
-- 
1.9.1
