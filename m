From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 2/4] Input: atmel_mxt_ts - Read resolution from device memory
Date: Tue,  6 May 2014 16:13:10 -0600
Message-ID: <1399414392-32572-3-git-send-email-swarren@wwwdotorg.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:52496 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbaEFWNZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 May 2014 18:13:25 -0400
In-Reply-To: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, linux-input@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

From: Yufeng Shen <miletus@chromium.org>

Currently mxt_calc_resolution() computes device resolution from
provided platform data. In order to support device tree, we would need
a way to represent these values there too. To avoid that, we rework
mxt_calc_resolution() so it reads the actual resolution from the
configured device memory.

And also move mxt_calc_resolution() into mxt_initialize() after
the device is configured.

Signed-off-by: Yufeng Shen <miletus@chromium.org>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
[swarren, augmented patch description to mention device tree]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 71 ++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 9ba7e30c7894..c7ab14cf84b7 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -812,6 +812,44 @@ static void mxt_free_object_table(struct mxt_data *data)
 	data->T19_reportid = 0;
 }
 
+static int mxt_calc_resolution(struct mxt_data *data)
+{
+	struct i2c_client *client = data->client;
+	struct mxt_object *T9;
+	u8 orient;
+	__le16 xyrange[2];
+	unsigned int max_x, max_y;
+	int ret;
+
+	T9 = mxt_get_object(data, MXT_TOUCH_MULTI_T9);
+	if (T9 == NULL)
+		return -EINVAL;
+
+	/* Get touchscreen resolution */
+	ret = __mxt_read_reg(client, T9->start_address + MXT_TOUCH_XRANGE_LSB,
+			4, xyrange);
+	if (ret)
+		return ret;
+
+	ret = __mxt_read_reg(client, T9->start_address + MXT_TOUCH_ORIENT,
+			1, &orient);
+	if (ret)
+		return ret;
+
+	max_x = le16_to_cpu(xyrange[0]);
+	max_y = le16_to_cpu(xyrange[1]);
+
+	if (orient & MXT_XY_SWITCH) {
+		data->max_x = max_y;
+		data->max_y = max_x;
+	} else {
+		data->max_x = max_x;
+		data->max_y = max_y;
+	}
+
+	return 0;
+}
+
 static int mxt_initialize(struct mxt_data *data)
 {
 	struct i2c_client *client = data->client;
@@ -844,14 +882,17 @@ static int mxt_initialize(struct mxt_data *data)
 	mxt_handle_pdata(data);
 
 	/* Backup to memory */
-	mxt_write_object(data, MXT_GEN_COMMAND_T6,
-			MXT_COMMAND_BACKUPNV,
-			MXT_BACKUP_VALUE);
+	error = mxt_write_object(data, MXT_GEN_COMMAND_T6,
+				 MXT_COMMAND_BACKUPNV, MXT_BACKUP_VALUE);
+	if (error)
+		return error;
 	msleep(MXT_BACKUP_TIME);
 
 	/* Soft reset */
-	mxt_write_object(data, MXT_GEN_COMMAND_T6,
-			MXT_COMMAND_RESET, 1);
+	error = mxt_write_object(data, MXT_GEN_COMMAND_T6,
+				 MXT_COMMAND_RESET, 1);
+	if (error)
+		return error;
 	msleep(MXT_RESET_TIME);
 
 	/* Update matrix size at info struct */
@@ -875,6 +916,10 @@ static int mxt_initialize(struct mxt_data *data)
 			info->matrix_xsize, info->matrix_ysize,
 			info->object_num);
 
+	error = mxt_calc_resolution(data);
+	if (error)
+		return error;
+
 	return 0;
 
 err_free_object_table:
@@ -882,20 +927,6 @@ err_free_object_table:
 	return error;
 }
 
-static void mxt_calc_resolution(struct mxt_data *data)
-{
-	unsigned int max_x = data->pdata->x_size - 1;
-	unsigned int max_y = data->pdata->y_size - 1;
-
-	if (data->pdata->orient & MXT_XY_SWITCH) {
-		data->max_x = max_y;
-		data->max_y = max_x;
-	} else {
-		data->max_x = max_x;
-		data->max_y = max_y;
-	}
-}
-
 /* Firmware Version is returned as Major.Minor.Build */
 static ssize_t mxt_fw_version_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -1166,8 +1197,6 @@ static int mxt_probe(struct i2c_client *client,
 	data->pdata = pdata;
 	data->irq = client->irq;
 
-	mxt_calc_resolution(data);
-
 	error = mxt_initialize(data);
 	if (error)
 		goto err_free_mem;
-- 
1.8.1.5

