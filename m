From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 26/33] Input: atmel_mxt_ts - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:47 -0800
Message-ID: <1484761614-12225-27-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Nick Dyer <nick@shmanahar.org>
List-Id: linux-input@vger.kernel.org

Error messages after memory allocation failures are unnecessary and
can be dropped.
Other relevant changes:
  Simplify error return

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop unused variables
- Drop unnecessary braces around conditional return statements
- Use local structure pointers consistently
- Drop error message after devm_kzalloc() failure
- Replace 'if (e) return e; return 0;' with 'return e;'

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 47 +++++++-------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index e5d185fe69b9..ca027503627e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -585,7 +585,6 @@ static int mxt_check_bootloader(struct mxt_data *data, unsigned int state,
 
 static int mxt_send_bootloader_cmd(struct mxt_data *data, bool unlock)
 {
-	int ret;
 	u8 buf[2];
 
 	if (unlock) {
@@ -596,11 +595,7 @@ static int mxt_send_bootloader_cmd(struct mxt_data *data, bool unlock)
 		buf[1] = 0x01;
 	}
 
-	ret = mxt_bootloader_write(data, buf, 2);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mxt_bootloader_write(data, buf, 2);
 }
 
 static int __mxt_read_reg(struct i2c_client *client,
@@ -1167,15 +1162,9 @@ static int mxt_t6_command(struct mxt_data *data, u16 cmd_offset,
 
 static int mxt_acquire_irq(struct mxt_data *data)
 {
-	int error;
-
 	enable_irq(data->irq);
 
-	error = mxt_process_messages_until_invalid(data);
-	if (error)
-		return error;
-
-	return 0;
+	return mxt_process_messages_until_invalid(data);
 }
 
 static int mxt_soft_reset(struct mxt_data *data)
@@ -1198,12 +1187,8 @@ static int mxt_soft_reset(struct mxt_data *data)
 
 	mxt_acquire_irq(data);
 
-	ret = mxt_wait_for_completion(data, &data->reset_completion,
-				      MXT_RESET_TIMEOUT);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mxt_wait_for_completion(data, &data->reset_completion,
+				       MXT_RESET_TIMEOUT);
 }
 
 static void mxt_update_crc(struct mxt_data *data, u8 cmd, u8 value)
@@ -1504,10 +1489,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 			MXT_INFO_CHECKSUM_SIZE;
 	config_mem_size = data->mem_size - cfg_start_ofs;
 	config_mem = kzalloc(config_mem_size, GFP_KERNEL);
-	if (!config_mem) {
-		dev_err(dev, "Failed to allocate memory\n");
+	if (!config_mem)
 		return -ENOMEM;
-	}
 
 	ret = mxt_prepare_cfg_mem(data, cfg, data_pos, cfg_start_ofs,
 				  config_mem, config_mem_size);
@@ -1555,14 +1538,9 @@ static int mxt_get_info(struct mxt_data *data)
 {
 	struct i2c_client *client = data->client;
 	struct mxt_info *info = &data->info;
-	int error;
 
 	/* Read 7-byte info block starting at address 0 */
-	error = __mxt_read_reg(client, 0, sizeof(*info), info);
-	if (error)
-		return error;
-
-	return 0;
+	return __mxt_read_reg(client, 0, sizeof(*info), info);
 }
 
 static void mxt_free_input_device(struct mxt_data *data)
@@ -1609,10 +1587,8 @@ static int mxt_get_object_table(struct mxt_data *data)
 
 	table_size = data->info.object_num * sizeof(struct mxt_object);
 	object_table = kzalloc(table_size, GFP_KERNEL);
-	if (!object_table) {
-		dev_err(&data->client->dev, "Failed to allocate memory\n");
+	if (!object_table)
 		return -ENOMEM;
-	}
 
 	error = __mxt_read_reg(client, MXT_OBJECT_START, table_size,
 			object_table);
@@ -2045,10 +2021,9 @@ static int mxt_initialize(struct mxt_data *data)
 		if (error) {
 			dev_info(&client->dev, "Trying alternate bootloader address\n");
 			error = mxt_probe_bootloader(data, true);
-			if (error) {
+			if (error)
 				/* Chip is not in appmode or bootloader mode */
 				return error;
-			}
 		}
 
 		/* OK, we are in bootloader, see if we can recover */
@@ -2509,7 +2484,7 @@ static void mxt_debug_init(struct mxt_data *data)
 		dbg->t37_pages = MXT1386_COLUMNS * MXT1386_PAGES_PER_COLUMN;
 	else
 		dbg->t37_pages = DIV_ROUND_UP(data->xsize *
-					      data->info.matrix_ysize *
+					      info->matrix_ysize *
 					      sizeof(u16),
 					      sizeof(dbg->t37_buf->data));
 
@@ -3117,10 +3092,8 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return PTR_ERR(pdata);
 
 	data = kzalloc(sizeof(struct mxt_data), GFP_KERNEL);
-	if (!data) {
-		dev_err(&client->dev, "Failed to allocate memory\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	snprintf(data->phys, sizeof(data->phys), "i2c-%u-%04x/input0",
 		 client->adapter->nr, client->addr);
-- 
2.7.4
