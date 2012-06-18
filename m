From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 14/22 v4] Input: atmel_mxt_ts - don't re-read matrix after applying pdata
Date: Mon, 18 Jun 2012 12:08:34 +0800
Message-ID: <1339992522-22073-15-git-send-email-djkurtz@chromium.org>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org
Cc: Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

The matrix x/y size in the Info ID Block represents the number of x/y
trace lines on the device.  There is no need to re-read them after
applying pdata config, since pdata only configures the object table
etnries.  The matrix size read from the ID can only be updated by a
firmware update.

As a side affect, to squash a compiler warning, remove the 1-byte limited
mxt_read_reg() since it no longer has any callers.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 87004ec..214bf8d 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -426,11 +426,6 @@ static int __mxt_read_reg(struct i2c_client *client,
 	return ret;
 }
 
-static int mxt_read_reg(struct i2c_client *client, u16 reg, u8 *val)
-{
-	return __mxt_read_reg(client, reg, 1, val);
-}
-
 static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
 			   const void *val)
 {
@@ -805,7 +800,6 @@ static int mxt_initialize(struct mxt_data *data)
 	struct i2c_client *client = data->client;
 	struct mxt_info *info = &data->info;
 	int error;
-	u8 val;
 
 	error = mxt_get_info(data);
 	if (error)
@@ -842,17 +836,6 @@ static int mxt_initialize(struct mxt_data *data)
 			MXT_COMMAND_RESET, 1);
 	msleep(MXT_RESET_TIME);
 
-	/* Update matrix size at info struct */
-	error = mxt_read_reg(client, MXT_MATRIX_X_SIZE, &val);
-	if (error)
-		return error;
-	info->matrix_xsize = val;
-
-	error = mxt_read_reg(client, MXT_MATRIX_Y_SIZE, &val);
-	if (error)
-		return error;
-	info->matrix_ysize = val;
-
 	dev_info(&client->dev,
 			"Family ID: %d Variant ID: %d Version: %d Build: %d\n",
 			info->family_id, info->variant_id, info->version,
-- 
1.7.7.3
