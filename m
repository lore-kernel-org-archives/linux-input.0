From: Sangwon Jee <jeesw@melfas.com>
Subject: Input: melfas_mip4 - use product id for firmware name
Date: Wed, 26 Oct 2016 15:51:24 +0900
Message-ID: <1477464684-5848-1-git-send-email-jeesw@melfas.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sbs.melfas.com ([39.118.242.30]:45290 "EHLO sbs.melfas.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753777AbcJZGve (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Oct 2016 02:51:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeesw@melfas.com

Use product id for firmware name to request compatible firmware.

Signed-off-by: Sangwon Jee <jeesw@melfas.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 8739cb7..0f2230a 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -162,6 +162,7 @@ struct mip4_ts {
 	char product_name[16];
 	u16 product_id;
 	char ic_name[4];
+	char fw_name[32];
 
 	unsigned int max_x;
 	unsigned int max_y;
@@ -280,6 +281,11 @@ static int mip4_query_device(struct mip4_ts *ts)
 		dev_dbg(&ts->client->dev, "product id: %04X\n", ts->product_id);
 	}
 
+	/* Firmware name */
+	snprintf(ts->fw_name, sizeof(ts->fw_name),
+		"melfas_mip4_%04X.fw", ts->product_id);
+	dev_dbg(&ts->client->dev, "firmware name: %s\n", ts->fw_name);
+
 	/* IC name */
 	cmd[0] = MIP4_R0_INFO;
 	cmd[1] = MIP4_R1_INFO_IC_NAME;
@@ -1285,11 +1291,11 @@ static ssize_t mip4_sysfs_fw_update(struct device *dev,
 	const struct firmware *fw;
 	int error;
 
-	error = request_firmware(&fw, MIP4_FW_NAME, dev);
+	error = request_firmware(&fw, ts->fw_name, dev);
 	if (error) {
 		dev_err(&ts->client->dev,
 			"Failed to retrieve firmware %s: %d\n",
-			MIP4_FW_NAME, error);
+			ts->fw_name, error);
 		return error;
 	}
 
@@ -1608,6 +1614,6 @@ static struct i2c_driver mip4_driver = {
 module_i2c_driver(mip4_driver);
 
 MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
-MODULE_VERSION("2016.10.20");
+MODULE_VERSION("2016.10.24");
 MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
 MODULE_LICENSE("GPL");
-- 
1.9.1

