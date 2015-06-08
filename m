From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 5/8] input: goodix: write configuration data to device
Date: Mon,  8 Jun 2015 17:37:50 +0300
Message-ID: <1433774273-23103-6-git-send-email-irina.tirdea@intel.com>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-input@vger.kernel.org

Goodix devices can be configured by writing custom data to the device at
init. The configuration data is read with request_firmware from
"goodix_<id>_cfg.bin", where <id> is the product id read from the device
(e.g.: goodix_911_cfg.bin for Goodix GT911, goodix_9271_cfg.bin for
GT9271).

The configuration information has a specific format described in the Goodix
datasheet. It includes X/Y resolution, maximum supported touch points,
interrupt flags, various sesitivity factors and settings for advanced
features (like gesture recognition).

This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
driver gt9xx.c for Android (publicly available in Android kernel
trees for various devices).

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 128 +++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index c345eb7..1ce9278 100644
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
@@ -95,6 +96,39 @@ static int goodix_i2c_read(struct i2c_client *client,
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
@@ -192,6 +226,95 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * goodix_check_cfg - Checks if config buffer is valid
+ *
+ * @ts: goodix_ts_data pointer
+ * @fw: firmware config data
+ */
+static int goodix_check_cfg(struct goodix_ts_data *ts,
+			    const struct firmware *fw)
+{
+	int i, raw_cfg_len;
+	u8 check_sum = 0;
+
+	if (fw->size > GOODIX_CONFIG_MAX_LENGTH) {
+		dev_err(&ts->client->dev,
+			"The length of the config buffer array is not correct");
+		return -EINVAL;
+	}
+
+	raw_cfg_len = fw->size - 2;
+	for (i = 0; i < raw_cfg_len; i++)
+		check_sum += fw->data[i];
+	check_sum = (~check_sum) + 1;
+	if (check_sum != fw->data[raw_cfg_len]) {
+		dev_err(&ts->client->dev,
+			"The checksum of the config buffer array is not correct");
+		return -EINVAL;
+	}
+
+	if (fw->data[raw_cfg_len + 1] != 1) {
+		dev_err(&ts->client->dev,
+			"The Config_Fresh register needs to be set");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * goodix_send_cfg - Write device config
+ *
+ * @ts: goodix_ts_data pointer
+ * @id: product id read from device
+ */
+static int goodix_send_cfg(struct goodix_ts_data *ts, u16 id)
+{
+	const struct firmware *fw = NULL;
+	char *fw_name;
+	int ret;
+
+	fw_name = kasprintf(GFP_KERNEL, "goodix_%d_cfg.bin", id);
+	if (!fw_name)
+		return -ENOMEM;
+
+	ret = request_firmware(&fw, fw_name, &ts->client->dev);
+	if (ret) {
+		dev_err(&ts->client->dev, "Unable to open firmware %s\n",
+			fw_name);
+		goto err_free_fw_name;
+	}
+	kfree(fw_name);
+
+	ret = goodix_check_cfg(ts, fw);
+	if (ret)
+		goto err_release_fw;
+
+	ret = goodix_i2c_write(ts->client, GOODIX_REG_CONFIG_DATA, fw->data,
+			       fw->size);
+	if (ret) {
+		dev_err(&ts->client->dev, "Failed to write config data: %d",
+			ret);
+		goto err_release_fw;
+	}
+	dev_dbg(&ts->client->dev, "Config sent successfully.");
+
+	/* Let the firmware reconfigure itself, so sleep for 10ms */
+	usleep_range(10000, 11000);
+
+	release_firmware(fw);
+
+	return 0;
+
+err_release_fw:
+	release_firmware(fw);
+	return ret;
+err_free_fw_name:
+	kfree(fw_name);
+	return ret;
+}
+
 static int goodix_int_sync(struct goodix_ts_data *ts)
 {
 	int ret;
@@ -465,6 +588,11 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	/* send device configuration to the firmware */
+	error = goodix_send_cfg(ts, id_info);
+	if (error)
+		return error;
+
 	goodix_read_config(ts);
 
 	error = goodix_request_input_dev(ts, version_info, id_info);
-- 
1.9.1
