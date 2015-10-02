From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 13/18] Input: atmel_mxt_ts - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:24 +0200
Message-ID: <1443793229-22363-14-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The invoked functions already return zero on success or a negative
errno code so there is no need to open code the logic in the caller.

This also fixes the following make coccicheck warnings:

end returns can be simplified and declaration on line 1470 can be dropped
end returns can be simplified and declaration on line 1485 can be dropped
end returns can be simplified and declaration on line 515 can be dropped
end returns can be simplified

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/atmel_mxt_ts.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c5622058c22b..34ecbb64319f 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -512,7 +512,6 @@ recheck:
 
 static int mxt_send_bootloader_cmd(struct mxt_data *data, bool unlock)
 {
-	int ret;
 	u8 buf[2];
 
 	if (unlock) {
@@ -523,11 +522,7 @@ static int mxt_send_bootloader_cmd(struct mxt_data *data, bool unlock)
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
@@ -1112,12 +1107,8 @@ static int mxt_soft_reset(struct mxt_data *data)
 
 	enable_irq(data->irq);
 
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
@@ -1467,29 +1458,18 @@ release_mem:
 
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
 
 static int mxt_get_info(struct mxt_data *data)
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
-- 
2.4.3
