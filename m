From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: [PATCH 1/3 v4] Input: atmel_mxt_ts - Make wait-after-reset period
 compatible with all chips
Date: Tue, 26 Jul 2011 20:30:02 +0300
Message-ID: <4E2EF99A.2040702@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:24348 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1GZRaf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2011 13:30:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

The delay before the chip can be accessed after reset varies between different
chips in maXTouch family. Waiting for 200ms and then monitoring the CHG (chip
is ready when the line is low) is guaranteed to work with all chips.

v4: Adjust delay depending on the family ID of the chip. Also add a readback
    of command register after backup is issued, to make sure we are not proceeding
    too fast there.
v3: Add a check for NULL read_chg() function, and add the read_chg() to platform
    files using this driver (currently only mach-goni.c)
v2: At Dmitry's suggestion, add a timeout so we are not stuck looping
    endlessly in case the CHG is not going low. 

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 arch/arm/mach-s5pv210/mach-goni.c        |    6 ++++
 drivers/input/touchscreen/atmel_mxt_ts.c |   45 ++++++++++++++++++++++++++++-
 include/linux/i2c/atmel_mxt_ts.h         |    1 +
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 31d5aa7..196e92c 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -225,6 +225,11 @@ static void __init goni_radio_init(void)
 	gpio_direction_output(gpio, 1);
 }
 
+static u8 read_chg(void)
+{
+	return gpio_get_value(S5PV210_GPJ0(5));
+}
+
 /* TSP */
 static struct mxt_platform_data qt602240_platform_data = {
 	.x_line		= 17,
@@ -236,6 +241,7 @@ static struct mxt_platform_data qt602240_platform_data = {
 	.voltage	= 2800000,              /* 2.8V */
 	.orient		= MXT_DIAGONAL,
 	.irqflags	= IRQF_TRIGGER_FALLING,
+	.read_chg	= &read_chg,
 };
 
 static struct s3c2410_platform_i2c i2c2_data __initdata = {
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index ae00604..c5be826 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -21,6 +21,10 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 
+/* Family ID */
+#define MXT224_ID		0x80
+#define MXT1386_ID		0xA0
+
 /* Version */
 #define MXT_VER_20		20
 #define MXT_VER_21		21
@@ -176,7 +180,10 @@
 #define MXT_BOOT_VALUE		0xa5
 #define MXT_BACKUP_VALUE	0x55
 #define MXT_BACKUP_TIME		25	/* msec */
-#define MXT_RESET_TIME		65	/* msec */
+#define MXT224_RESET_TIME       65      /* msec */
+#define MXT1386_RESET_TIME      200     /* msec */
+#define MXT_RESET_TIME		200	/* msec */
+#define MXT_RESET_NOCHGREAD     400     /* msec */
 
 #define MXT_FWRESET_TIME	175	/* msec */
 
@@ -814,7 +821,9 @@ static int mxt_initialize(struct mxt_data *data)
 	struct i2c_client *client = data->client;
 	struct mxt_info *info = &data->info;
 	int error;
+	int timeout_counter = 0;
 	u8 val;
+	u8 command_register;
 
 	error = mxt_get_info(data);
 	if (error)
@@ -845,11 +854,43 @@ static int mxt_initialize(struct mxt_data *data)
 			MXT_COMMAND_BACKUPNV,
 			MXT_BACKUP_VALUE);
 	msleep(MXT_BACKUP_TIME);
+	do {
+                error =  mxt_read_object(data, MXT_GEN_COMMAND_T6,
+					MXT_COMMAND_BACKUPNV,
+					&command_register);
+                if (error)
+                        return error;
+		msleep(2);
+        } while ((command_register != 0) && (timeout_counter++ <= 100));
+	if (timeout_counter >= 100) {
+		dev_err(&client->dev, "No response after backup!\n");
+		return -EIO;
+	}
 
 	/* Soft reset */
 	mxt_write_object(data, MXT_GEN_COMMAND_T6,
 			MXT_COMMAND_RESET, 1);
-	msleep(MXT_RESET_TIME);
+	if (data->pdata->read_chg == NULL) {
+		msleep(MXT_RESET_NOCHGREAD);
+	} else {
+		switch (info->family_id) {
+		case MXT224_ID:
+			msleep(MXT224_RESET_TIME);
+			break;
+		case MXT1386_ID:
+			msleep(MXT1386_RESET_TIME);
+			break;
+		default:
+			msleep(MXT_RESET_TIME);
+		}
+		timeout_counter = 0;
+		while ((timeout_counter++ <= 100) && data->pdata->read_chg())
+			msleep(2);
+		if (timeout_counter >= 100) {
+			dev_err(&client->dev, "No response after reset!\n");
+			return -EIO;
+		}
+	}
 
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
