From: HungNien Chen <hn.chen@weidahitech.com>
Subject: [PATCH] Input: wdt87xx_i2c - Add retries for the I2C transfer functions
Date: Thu, 30 Jul 2015 23:04:31 +0800
Message-ID: <1438268671-5245-1-git-send-email-hn.chen@weidahitech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2023 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbbG3PEn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 11:04:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, HungNien Chen <hn.chen@weidahitech.com>

There are 2 reasons for the modification:
1. The touch algorithm will change the controller freq to do the de-noise
when there are noises coming and it has the risk to make i2c data error.
For the driver, it has no idea if the fw is just doing the de-noise.
2. In old firmware, it has the possibility to get the transfer packet error
caused by the controller's fifo underflow when the controller change
the freq to the lowest one.
Add the retry loop in transfer functions to overcome this kind of temporary 
transfer packet errors.

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/input/touchscreen/wdt87xx_i2c.c | 95 +++++++++++++++++----------------
 1 file changed, 48 insertions(+), 47 deletions(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index 515c20a..20d845d 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -23,7 +23,7 @@
 #include <asm/unaligned.h>
 
 #define WDT87XX_NAME		"wdt87xx_i2c"
-#define WDT87XX_DRV_VER		"0.9.7"
+#define WDT87XX_DRV_VER		"0.9.8"
 #define WDT87XX_FW_NAME		"wdt87xx_fw.bin"
 #define WDT87XX_CFG_NAME	"wdt87xx_cfg.bin"
 
@@ -220,26 +220,25 @@ static int wdt87xx_get_desc(struct i2c_client *client, u8 desc_idx,
 			    u8 *buf, size_t len)
 {
 	u8 tx_buf[] = { 0x22, 0x00, 0x10, 0x0E, 0x23, 0x00 };
-	int error;
+	int error, retry_cnt;
 
 	tx_buf[2] |= desc_idx & 0xF;
 
-	error = wdt87xx_i2c_xfer(client, tx_buf, sizeof(tx_buf),
-				 buf, len);
+	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
+		error = wdt87xx_i2c_xfer(client, tx_buf, sizeof(tx_buf),
+					 buf, len);
+		mdelay(WDT_COMMAND_DELAY_MS);
+		if (!error && buf[0] == len)
+			return 0;
+	}
+
 	if (error) {
 		dev_err(&client->dev, "get desc failed: %d\n", error);
 		return error;
 	}
 
-	if (buf[0] != len) {
-		dev_err(&client->dev, "unexpected response to get desc: %d\n",
-			buf[0]);
-		return -EINVAL;
-	}
-
-	mdelay(WDT_COMMAND_DELAY_MS);
-
-	return 0;
+	dev_err(&client->dev, "unexpected response to get desc: %d\n", buf[0]);
+	return -EINVAL;
 }
 
 static int wdt87xx_get_string(struct i2c_client *client, u8 str_idx,
@@ -248,30 +247,30 @@ static int wdt87xx_get_string(struct i2c_client *client, u8 str_idx,
 	u8 tx_buf[] = { 0x22, 0x00, 0x13, 0x0E, str_idx, 0x23, 0x00 };
 	u8 rx_buf[PKT_WRITE_SIZE];
 	size_t rx_len = len + 2;
-	int error;
+	int error, retry_cnt;
 
 	if (rx_len > sizeof(rx_buf))
 		return -EINVAL;
 
-	error = wdt87xx_i2c_xfer(client, tx_buf, sizeof(tx_buf),
-				 rx_buf, rx_len);
+	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
+		error = wdt87xx_i2c_xfer(client, tx_buf, sizeof(tx_buf),
+					 rx_buf, rx_len);
+		mdelay(WDT_COMMAND_DELAY_MS);
+		if (!error && rx_buf[1] == 0x03) {
+			rx_len = min_t(size_t, len, rx_buf[0]);
+			memcpy(buf, &rx_buf[2], rx_len);
+			return 0;
+		}
+	}
+
 	if (error) {
 		dev_err(&client->dev, "get string failed: %d\n", error);
 		return error;
 	}
 
-	if (rx_buf[1] != 0x03) {
-		dev_err(&client->dev, "unexpected response to get string: %d\n",
-			rx_buf[1]);
-		return -EINVAL;
-	}
-
-	rx_len = min_t(size_t, len, rx_buf[0]);
-	memcpy(buf, &rx_buf[2], rx_len);
-
-	mdelay(WDT_COMMAND_DELAY_MS);
-
-	return 0;
+	dev_err(&client->dev, "unexpected response to get string: %d\n",
+		rx_buf[1]);
+	return -EINVAL;
 }
 
 static int wdt87xx_get_feature(struct i2c_client *client,
@@ -281,7 +280,7 @@ static int wdt87xx_get_feature(struct i2c_client *client,
 	u8 rx_buf[PKT_WRITE_SIZE];
 	size_t tx_len = 0;
 	size_t rx_len = buf_size + 2;
-	int error;
+	int error, retry_cnt;
 
 	if (rx_len > sizeof(rx_buf))
 		return -EINVAL;
@@ -300,18 +299,20 @@ static int wdt87xx_get_feature(struct i2c_client *client,
 	tx_buf[tx_len++] = 0x23;
 	tx_buf[tx_len++] = 0x00;
 
-	error = wdt87xx_i2c_xfer(client, tx_buf, tx_len, rx_buf, rx_len);
-	if (error) {
-		dev_err(&client->dev, "get feature failed: %d\n", error);
-		return error;
+	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
+		error = wdt87xx_i2c_xfer(client, tx_buf, tx_len,
+					 rx_buf, rx_len);
+		mdelay(WDT_COMMAND_DELAY_MS);
+		if (!error) {
+			rx_len = min_t(size_t, buf_size,
+				       get_unaligned_le16(rx_buf));
+			memcpy(buf, &rx_buf[2], rx_len);
+			return 0;
+		}
 	}
 
-	rx_len = min_t(size_t, buf_size, get_unaligned_le16(rx_buf));
-	memcpy(buf, &rx_buf[2], rx_len);
-
-	mdelay(WDT_COMMAND_DELAY_MS);
-
-	return 0;
+	dev_err(&client->dev, "get feature failed: %d\n", error);
+	return error;
 }
 
 static int wdt87xx_set_feature(struct i2c_client *client,
@@ -319,7 +320,7 @@ static int wdt87xx_set_feature(struct i2c_client *client,
 {
 	u8 tx_buf[PKT_WRITE_SIZE];
 	int tx_len = 0;
-	int error;
+	int error, retry_cnt;
 
 	/* Set feature command packet */
 	tx_buf[tx_len++] = 0x22;
@@ -343,15 +344,15 @@ static int wdt87xx_set_feature(struct i2c_client *client,
 	memcpy(&tx_buf[tx_len], buf, buf_size);
 	tx_len += buf_size;
 
-	error = i2c_master_send(client, tx_buf, tx_len);
-	if (error < 0) {
-		dev_err(&client->dev, "set feature failed: %d\n", error);
-		return error;
+	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
+		error = i2c_master_send(client, tx_buf, tx_len);
+		mdelay(WDT_COMMAND_DELAY_MS);
+		if (error >= 0)
+			return 0;
 	}
 
-	mdelay(WDT_COMMAND_DELAY_MS);
-
-	return 0;
+	dev_err(&client->dev, "set feature failed: %d\n", error);
+	return error;
 }
 
 static int wdt87xx_send_command(struct i2c_client *client, int cmd, int value)
-- 
1.9.1

