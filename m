From: HungNien Chen <hn.chen@weidahitech.com>
Subject: [PATCH] Input: wdt87xx_i2c - Add a prodcut_id attribute in sysfs  This prodcut_id can be used by the fw updater to distingush products. Also modify the RETRY number to make sure the correctness of the flash.
Date: Thu,  9 Jul 2015 23:00:43 +0800
Message-ID: <1436454043-15093-1-git-send-email-hn.chen@weidahitech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2915 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbbGIPBK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2015 11:01:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, HungNien Chen <hn.chen@weidahitech.com>

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/input/touchscreen/wdt87xx_i2c.c | 68 ++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index fb92ae1..b97cb4f 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -23,7 +23,7 @@
 #include <asm/unaligned.h>
 
 #define WDT87XX_NAME		"wdt87xx_i2c"
-#define WDT87XX_DRV_VER		"0.9.6"
+#define WDT87XX_DRV_VER		"0.9.7"
 #define WDT87XX_FW_NAME		"wdt87xx_fw.bin"
 #define WDT87XX_CFG_NAME	"wdt87xx_cfg.bin"
 
@@ -39,7 +39,7 @@
 #define WDT_FIRMWARE_ID			0xa9e368f5
 
 #define PG_SIZE				0x1000
-#define MAX_RETRIES			3
+#define MAX_RETRIES			10
 
 #define MAX_UNIT_AXIS			0x7FFF
 
@@ -85,6 +85,11 @@
 #define CTL_PARAM_OFFSET_PHY_H		24
 #define CTL_PARAM_OFFSET_FACTOR		32
 
+/* The definition of the device descriptor */
+#define	GD_DEVICE			1
+#define	DEV_DESC_OFFSET_VID		8
+#define	DEV_DESC_OFFSET_PID		10
+
 /* Communication commands */
 #define PACKET_SIZE			56
 #define VND_REQ_READ			0x06
@@ -165,6 +170,8 @@ struct wdt87xx_sys_param {
 	u16	scaling_factor;
 	u32	max_x;
 	u32	max_y;
+	u16	vendor_id;
+	u16	product_id;
 };
 
 struct wdt87xx_data {
@@ -208,6 +215,39 @@ static int wdt87xx_i2c_xfer(struct i2c_client *client,
 	return 0;
 }
 
+static int wdt87xx_get_desc(struct i2c_client *client, u8 desc_idx,
+			    u8 *buf, size_t len)
+{
+	u8 tx_buf[] = { 0x22, 0x00, 0x10, 0x0E, 0x23, 0x00 };
+	u8 rx_buf[PKT_WRITE_SIZE];
+	size_t rx_len = len;
+	int error;
+
+	if (rx_len > sizeof(rx_buf))
+		return -EINVAL;
+
+	tx_buf[2] = 0x10 | (desc_idx & 0xF);
+
+	error = wdt87xx_i2c_xfer(client, tx_buf, sizeof(tx_buf),
+				 rx_buf, rx_len);
+	if (error) {
+		dev_err(&client->dev, "get desc failed: %d\n", error);
+		return error;
+	}
+
+	if (rx_buf[0] != rx_len) {
+		dev_err(&client->dev, "unexpected response to get desc: %d\n",
+			rx_buf[0]);
+		return -EINVAL;
+	}
+
+	memcpy(buf, rx_buf, rx_len);
+
+	mdelay(WDT_COMMAND_DELAY_MS);
+
+	return 0;
+}
+
 static int wdt87xx_get_string(struct i2c_client *client, u8 str_idx,
 			      u8 *buf, size_t len)
 {
@@ -403,6 +443,15 @@ static int wdt87xx_get_sysparam(struct i2c_client *client,
 	u8 buf[PKT_READ_SIZE];
 	int error;
 
+	error = wdt87xx_get_desc(client, GD_DEVICE, buf, 18);
+	if (error) {
+		dev_err(&client->dev, "failed to get device desc\n");
+		return error;
+	}
+
+	param->vendor_id = get_unaligned_le16(buf + DEV_DESC_OFFSET_VID);
+	param->product_id = get_unaligned_le16(buf + DEV_DESC_OFFSET_PID);
+
 	error = wdt87xx_get_string(client, STRIDX_PARAMETERS, buf, 34);
 	if (error) {
 		dev_err(&client->dev, "failed to get parameters\n");
@@ -834,6 +883,19 @@ static int wdt87xx_update_firmware(struct device *dev,
 	return error ? error : 0;
 }
 
+static ssize_t product_id_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_data *wdt = i2c_get_clientdata(client);
+	u32 product_id;
+
+	product_id = wdt->param.vendor_id;
+	product_id = (product_id << 16) | wdt->param.product_id;
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", product_id);
+}
+
 static ssize_t config_csum_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -887,6 +949,7 @@ static ssize_t update_fw_store(struct device *dev,
 	return error ? error : count;
 }
 
+static DEVICE_ATTR_RO(product_id);
 static DEVICE_ATTR_RO(config_csum);
 static DEVICE_ATTR_RO(fw_version);
 static DEVICE_ATTR_RO(plat_id);
@@ -894,6 +957,7 @@ static DEVICE_ATTR_WO(update_config);
 static DEVICE_ATTR_WO(update_fw);
 
 static struct attribute *wdt87xx_attrs[] = {
+	&dev_attr_product_id.attr,
 	&dev_attr_config_csum.attr,
 	&dev_attr_fw_version.attr,
 	&dev_attr_plat_id.attr,
-- 
1.9.1

