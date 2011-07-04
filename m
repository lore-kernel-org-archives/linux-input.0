From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: [PATCH 1/3] Input: atmel_mxt_ts - Make wait-after-reset period compatible
 with all chips
Date: Mon, 04 Jul 2011 12:05:31 +0300
Message-ID: <4E11825B.3000409@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:20906 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab1GDJGF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 05:06:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org

The delay before the chip can be accessed after reset varies between different
chips in maXTouch family. Waiting for 200ms and then monitoring the CHG (chip
is ready when the line is low) is guaranteed to work with all chips.

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    4 +++-
 include/linux/i2c/atmel_mxt_ts.h         |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 1e61387..8870e7b 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -170,7 +170,7 @@
 #define MXT_BOOT_VALUE		0xa5
 #define MXT_BACKUP_VALUE	0x55
 #define MXT_BACKUP_TIME		25	/* msec */
-#define MXT_RESET_TIME		65	/* msec */
+#define MXT_RESET_TIME		200	/* msec */
 
 #define MXT_FWRESET_TIME	175	/* msec */
 
@@ -828,6 +828,8 @@ static int mxt_initialize(struct mxt_data *data)
 	mxt_write_object(data, MXT_GEN_COMMAND,
 			MXT_COMMAND_RESET, 1);
 	msleep(MXT_RESET_TIME);
+	while (data->pdata->read_chg())
+		msleep(2);
 
 	/* Update matrix size at info struct */
 	error = mxt_read_reg(client, MXT_MATRIX_X_SIZE, &val);
diff --git a/include/linux/i2c/atmel_mxt_ts.h b/include/linux/i2c/atmel_mxt_ts.h
index f027f7a..ef59c22 100644
--- a/include/linux/i2c/atmel_mxt_ts.h
+++ b/include/linux/i2c/atmel_mxt_ts.h
@@ -39,6 +39,7 @@ struct mxt_platform_data {
 	unsigned int voltage;
 	unsigned char orient;
 	unsigned long irqflags;
+	u8(*read_chg) (void);
 };
 
 #endif /* __LINUX_ATMEL_MXT_TS_H */
-- 
1.7.0.4
