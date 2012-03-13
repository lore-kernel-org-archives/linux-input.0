From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 04/20] Input: atmel_mxt_ts - refactor mxt_read/write_reg to take a length
Date: Tue, 13 Mar 2012 20:04:07 +0800
Message-ID: <1331640263-18935-5-git-send-email-djkurtz@chromium.org>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f202.google.com ([209.85.217.202]:52650 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab2CMMJd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 08:09:33 -0400
Received: by lbbgj3 with SMTP id gj3so12519lbb.1
        for <linux-input@vger.kernel.org>; Tue, 13 Mar 2012 05:09:32 -0700 (PDT)
In-Reply-To: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>

The i2c bus requires 5 bytes to do a 1 byte read (1-byte i2c address + 2
byte offset + 1-byte i2c address + 1 byte data), or 4 bytes to do a
1-byte write (1 byte i2c address + 2 byte offset + 1 byte data).

By taking a length with reads and writes, the driver can amortize
transaction overhead by performing larger transactions where appropriate.

This patch just sets up the new API.  Later patches refactor reads/writes
to take advantage of the larger transactions.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   47 +++++++++++++----------------
 1 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index e18c698..defd4e1 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -397,8 +397,7 @@ static int mxt_fw_write(struct i2c_client *client,
 	return 0;
 }
 
-static int __mxt_read_reg(struct i2c_client *client,
-			       u16 reg, u16 len, void *val)
+static int mxt_read_reg(struct i2c_client *client, u16 reg, u16 len, void *val)
 {
 	struct i2c_msg xfer[2];
 	u8 buf[2];
@@ -419,28 +418,25 @@ static int __mxt_read_reg(struct i2c_client *client,
 	xfer[1].buf = val;
 
 	if (i2c_transfer(client->adapter, xfer, 2) != 2) {
-		dev_err(&client->dev, "%s: i2c transfer failed\n", __func__);
+		dev_err(&client->dev, "%s: i2c read failed\n", __func__);
 		return -EIO;
 	}
 
 	return 0;
 }
 
-static int mxt_read_reg(struct i2c_client *client, u16 reg, u8 *val)
+static int mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
+			 const void *val)
 {
-	return __mxt_read_reg(client, reg, 1, val);
-}
-
-static int mxt_write_reg(struct i2c_client *client, u16 reg, u8 val)
-{
-	u8 buf[3];
+	size_t count = 2 + len;		/* + 2-byte offset */
+	u8 buf[count];
 
 	buf[0] = reg & 0xff;
 	buf[1] = (reg >> 8) & 0xff;
-	buf[2] = val;
+	memcpy(&buf[2], val, len);
 
-	if (i2c_master_send(client, buf, 3) != 3) {
-		dev_err(&client->dev, "%s: i2c send failed\n", __func__);
+	if (i2c_master_send(client, buf, count) != count) {
+		dev_err(&client->dev, "%s: i2c write failed\n", __func__);
 		return -EIO;
 	}
 
@@ -450,8 +446,7 @@ static int mxt_write_reg(struct i2c_client *client, u16 reg, u8 val)
 static int mxt_read_object_table(struct i2c_client *client,
 				      u16 reg, u8 *object_buf)
 {
-	return __mxt_read_reg(client, reg, MXT_OBJECT_SIZE,
-				   object_buf);
+	return mxt_read_reg(client, reg, MXT_OBJECT_SIZE, object_buf);
 }
 
 static struct mxt_object *
@@ -481,8 +476,8 @@ static int mxt_read_message(struct mxt_data *data,
 		return -EINVAL;
 
 	reg = object->start_address;
-	return __mxt_read_reg(data->client, reg,
-			sizeof(struct mxt_message), message);
+	return mxt_read_reg(data->client, reg, sizeof(struct mxt_message),
+			    message);
 }
 
 static int mxt_read_object(struct mxt_data *data,
@@ -496,7 +491,7 @@ static int mxt_read_object(struct mxt_data *data,
 		return -EINVAL;
 
 	reg = object->start_address;
-	return __mxt_read_reg(data->client, reg + offset, 1, val);
+	return mxt_read_reg(data->client, reg + offset, 1, val);
 }
 
 static int mxt_write_object(struct mxt_data *data,
@@ -510,7 +505,7 @@ static int mxt_write_object(struct mxt_data *data,
 		return -EINVAL;
 
 	reg = object->start_address;
-	return mxt_write_reg(data->client, reg + offset, val);
+	return mxt_write_reg(data->client, reg + offset, 1, &val);
 }
 
 static void mxt_input_report(struct mxt_data *data, int single_id)
@@ -757,27 +752,27 @@ static int mxt_get_info(struct mxt_data *data)
 	int error;
 	u8 val;
 
-	error = mxt_read_reg(client, MXT_FAMILY_ID, &val);
+	error = mxt_read_reg(client, MXT_FAMILY_ID, 1, &val);
 	if (error)
 		return error;
 	info->family_id = val;
 
-	error = mxt_read_reg(client, MXT_VARIANT_ID, &val);
+	error = mxt_read_reg(client, MXT_VARIANT_ID, 1, &val);
 	if (error)
 		return error;
 	info->variant_id = val;
 
-	error = mxt_read_reg(client, MXT_VERSION, &val);
+	error = mxt_read_reg(client, MXT_VERSION, 1, &val);
 	if (error)
 		return error;
 	info->version = val;
 
-	error = mxt_read_reg(client, MXT_BUILD, &val);
+	error = mxt_read_reg(client, MXT_BUILD, 1, &val);
 	if (error)
 		return error;
 	info->build = val;
 
-	error = mxt_read_reg(client, MXT_OBJECT_NUM, &val);
+	error = mxt_read_reg(client, MXT_OBJECT_NUM, 1, &val);
 	if (error)
 		return error;
 	info->object_num = val;
@@ -860,12 +855,12 @@ static int mxt_initialize(struct mxt_data *data)
 	msleep(MXT_RESET_TIME);
 
 	/* Update matrix size at info struct */
-	error = mxt_read_reg(client, MXT_MATRIX_X_SIZE, &val);
+	error = mxt_read_reg(client, MXT_MATRIX_X_SIZE, 1, &val);
 	if (error)
 		return error;
 	info->matrix_xsize = val;
 
-	error = mxt_read_reg(client, MXT_MATRIX_Y_SIZE, &val);
+	error = mxt_read_reg(client, MXT_MATRIX_Y_SIZE, 1, &val);
 	if (error)
 		return error;
 	info->matrix_ysize = val;
-- 
1.7.7.3

