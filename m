From: "jeffrey.lin" <yajohn@gmail.com>
Subject: [PATCH] [v1.1 3/3] modify raydium firmware update rule
Date: Thu,  7 Jul 2016 09:39:38 -0700
Message-ID: <1467909578-43578-1-git-send-email-jeffrey.lin@rad-ic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33734 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbcGGQkt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2016 12:40:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, groeck@chromium.org, robh@kernel.org
Cc: jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

modify raydium touch firmware update rule.

Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 112 ++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index f3076d9..004c5a6 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -34,6 +34,9 @@
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 
+/* Firmware */
+#define RAYDIUM_FW_NAME		"raydium.fw"
+
 /* Slave I2C mode */
 #define RM_BOOT_BLDR		0x02
 #define RM_BOOT_MAIN		0x03
@@ -78,7 +81,7 @@
 #define RM_MAX_FW_RETRIES	30
 #define RM_MAX_FW_SIZE		0xD000
 
-#define RM_POWERON_DELAY_USEC	500
+#define RM_POWERON_DELAY_MSEC	20
 #define RM_RESET_DELAY_MSEC	50
 
 enum raydium_bl_cmd {
@@ -97,6 +100,7 @@ enum raydium_bl_ack {
 enum raydium_boot_mode {
 	RAYDIUM_TS_MAIN = 0,
 	RAYDIUM_TS_BLDR,
+	INVALID_REGION,
 };
 
 /* Response to RM_CMD_DATA_BANK request */
@@ -141,6 +145,8 @@ struct raydium_data {
 	enum raydium_boot_mode boot_mode;
 
 	bool wake_irq_enabled;
+
+	char *fw_file;
 };
 
 static int raydium_i2c_send(struct i2c_client *client,
@@ -318,16 +324,23 @@ static int raydium_i2c_check_fw_status(struct raydium_data *ts)
 	struct i2c_client *client = ts->client;
 	static const u8 bl_ack = 0x62;
 	static const u8 main_ack = 0x66;
-	u8 buf[4];
+	u8 buf[5];
 	int error;
 
 	error = raydium_i2c_read(client, RM_CMD_BOOT_READ, buf, sizeof(buf));
 	if (!error) {
-		if (buf[0] == bl_ack)
-			ts->boot_mode = RAYDIUM_TS_BLDR;
-		else if (buf[0] == main_ack)
+		if (buf[0] == main_ack)
 			ts->boot_mode = RAYDIUM_TS_MAIN;
-		return 0;
+		else if (buf[0] == bl_ack) {
+			ts->boot_mode = RAYDIUM_TS_BLDR;
+			ts->info.main_ver = buf[4] >> 4;
+			ts->info.sub_ver = buf[4] & 0x0F;
+		} else {
+			ts->boot_mode = INVALID_REGION;
+			error = -EINVAL;
+			dev_err(&client->dev,
+				"invalid fw status: %x\n", buf[0]);
+		}
 	}
 
 	return error;
@@ -358,13 +371,10 @@ static int raydium_i2c_initialize(struct raydium_data *ts)
 	if (error)
 		ts->boot_mode = RAYDIUM_TS_BLDR;
 
-	if (ts->boot_mode == RAYDIUM_TS_BLDR) {
+	if (ts->boot_mode == RAYDIUM_TS_BLDR)
 		ts->info.hw_ver = cpu_to_le32(0xffffffffUL);
-		ts->info.main_ver = 0xff;
-		ts->info.sub_ver = 0xff;
-	} else {
+	else
 		raydium_i2c_query_ts_info(ts);
-	}
 
 	return error;
 }
@@ -739,12 +749,12 @@ static int raydium_i2c_fw_update(struct raydium_data *ts)
 {
 	struct i2c_client *client = ts->client;
 	const struct firmware *fw = NULL;
-	const char *fw_file = "raydium.fw";
 	int error;
 
-	error = request_firmware(&fw, fw_file, &client->dev);
+	error = request_firmware(&fw, ts->fw_file, &client->dev);
 	if (error) {
-		dev_err(&client->dev, "Unable to open firmware %s\n", fw_file);
+		dev_err(&client->dev, "Unable to open firmware %s\n",
+			ts->fw_file);
 		return error;
 	}
 
@@ -900,18 +910,75 @@ static ssize_t raydium_i2c_calibrate_store(struct device *dev,
 	return error ?: count;
 }
 
+static int raydium_update_file_name(struct device *dev, char **file_name,
+				const char *buf, size_t count)
+{
+	char *new_file_name;
+
+	/* Simple sanity check */
+	if (count > 64) {
+		dev_warn(dev, "File name too long\n");
+		return -EINVAL;
+	}
+
+	new_file_name = devm_kmalloc(dev, count + 1, GFP_KERNEL);
+	if (!new_file_name)
+		return -ENOMEM;
+
+	memcpy(new_file_name, buf, count + 1);
+
+	/* Echo into the sysfs entry may append newline at the end of buf */
+	if (new_file_name[count - 1] == '\n')
+		count--;
+
+	new_file_name[count] = '\0';
+
+	if (*file_name)
+		devm_kfree(dev, *file_name);
+
+	*file_name = new_file_name;
+
+	return 0;
+}
+
+static ssize_t raydium_fw_file_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct raydium_data *ts = i2c_get_clientdata(client);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", ts->fw_file);
+}
+
+static ssize_t raydium_fw_file_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct raydium_data *ts = i2c_get_clientdata(client);
+	int ret;
+
+	ret = raydium_update_file_name(dev, &ts->fw_file, buf, count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static DEVICE_ATTR(fw_version, S_IRUGO, raydium_i2c_fw_ver_show, NULL);
 static DEVICE_ATTR(hw_version, S_IRUGO, raydium_i2c_hw_ver_show, NULL);
 static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_i2c_boot_mode_show, NULL);
 static DEVICE_ATTR(update_fw, S_IWUSR, NULL, raydium_i2c_update_fw_store);
 static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_i2c_calibrate_store);
-
+static DEVICE_ATTR(fw_file, S_IRUGO | S_IWUSR, raydium_fw_file_show,
+		   raydium_fw_file_store);
 static struct attribute *raydium_i2c_attributes[] = {
 	&dev_attr_update_fw.attr,
 	&dev_attr_boot_mode.attr,
 	&dev_attr_fw_version.attr,
 	&dev_attr_hw_version.attr,
 	&dev_attr_calibrate.attr,
+	&dev_attr_fw_file.attr,
 	NULL
 };
 
@@ -933,7 +1000,7 @@ static int raydium_i2c_power_on(struct raydium_data *ts)
 	if (!ts->reset_gpio)
 		return 0;
 
-	gpiod_set_value_cansleep(ts->reset_gpio, 1);
+	gpiod_set_value_cansleep(ts->reset_gpio, 0);
 
 	error = regulator_enable(ts->avdd);
 	if (error) {
@@ -950,10 +1017,10 @@ static int raydium_i2c_power_on(struct raydium_data *ts)
 		goto release_reset_gpio;
 	}
 
-	udelay(RM_POWERON_DELAY_USEC);
+	msleep(RM_POWERON_DELAY_MSEC);
 
 release_reset_gpio:
-	gpiod_set_value_cansleep(ts->reset_gpio, 0);
+	gpiod_set_value_cansleep(ts->reset_gpio, 1);
 
 	if (error)
 		return error;
@@ -968,7 +1035,6 @@ static void raydium_i2c_power_off(void *_data)
 	struct raydium_data *ts = _data;
 
 	if (ts->reset_gpio) {
-		gpiod_set_value_cansleep(ts->reset_gpio, 1);
 		regulator_disable(ts->vccio);
 		regulator_disable(ts->avdd);
 	}
@@ -1043,6 +1109,14 @@ static int raydium_i2c_probe(struct i2c_client *client,
 		return -ENXIO;
 	}
 
+	error = raydium_update_file_name(&client->dev, &ts->fw_file,
+			RAYDIUM_FW_NAME, strlen(RAYDIUM_FW_NAME));
+	if (error) {
+		dev_err(&client->dev, "failed to set firmware file name: %d\n",
+			error);
+		return error;
+	}
+
 	error = raydium_i2c_initialize(ts);
 	if (error) {
 		dev_err(&client->dev, "failed to initialize: %d\n", error);
-- 
2.1.2

