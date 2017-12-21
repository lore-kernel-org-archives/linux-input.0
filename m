From: "jeffrey.lin" <yajohn@gmail.com>
Subject: [PATCH] driver: input :touchscreen :Modify Raydium Firmware update input file
Date: Thu, 21 Dec 2017 21:51:22 +0800
Message-ID: <20171221135122.345-1-jeffrey.lin@raydium.corp-partner.google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40177 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdLUNvn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 21 Dec 2017 08:51:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, groeck@chromium.org, keith.tzeng@quantatw.com, Katherine.Hsieh@quantatw.com, bleung@google.com
Cc: jeffrey.lin@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, calvin.tseng@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Modify update firmware to accept alternative file name

Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index a99fb5cac5a0..439d43c3519c 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -130,6 +130,7 @@ struct raydium_data {
 	struct gpio_desc *reset_gpio;
 
 	struct raydium_info info;
+	char fw_file[64];
 
 	struct mutex sysfs_mutex;
 
@@ -752,12 +753,16 @@ static int raydium_i2c_fw_update(struct raydium_data *ts)
 {
 	struct i2c_client *client = ts->client;
 	const struct firmware *fw = NULL;
-	const char *fw_file = "raydium.fw";
 	int error;
 
-	error = request_firmware(&fw, fw_file, &client->dev);
+	/* Firmware name */
+	snprintf(ts->fw_file, sizeof(ts->fw_file),
+		"raydium_%x.fw", ts->info.hw_ver);
+	dev_dbg(&client->dev, "firmware name: %s\n", ts->fw_file);
+
+	error = request_firmware(&fw, ts->fw_file, &client->dev);
 	if (error) {
-		dev_err(&client->dev, "Unable to open firmware %s\n", fw_file);
+		dev_err(&client->dev, "Unable to open firmware %s\n", ts->fw_file);
 		return error;
 	}
 
-- 
2.12.2

