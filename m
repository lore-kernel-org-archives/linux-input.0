From: Benson Leung <bleung@chromium.org>
Subject: [PATCH 2/2] Platform: x86: chromeos_laptop : Add basic platform data for atmel devices
Date: Fri,  1 Mar 2013 17:20:54 -0800
Message-ID: <1362187254-9227-3-git-send-email-bleung@chromium.org>
References: <1362187254-9227-1-git-send-email-bleung@chromium.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1362187254-9227-1-git-send-email-bleung@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: olofj@chromium.org, miletus@chromium.org, dmitry.torokhov@gmail.com, matthew.garrett@nebula.com, rydberg@euromail.se, djkurtz@chromium.org, jy0922.shim@samsung.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: bleung@chromium.org
List-Id: linux-input@vger.kernel.org

Add basic platform data to get the current upstream driver working
with the 224s touchpad and 1664s touchscreen.
We will be using NULL config so we will use the settings from the
devices' NVRAMs.

Signed-off-by: Benson Leung <bleung@chromium.org>

Change-Id: I712bf4726fb4b194fbde44ad200c54d13dc3bdb9
---
 drivers/platform/x86/chromeos_laptop.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/chromeos_laptop.c b/drivers/platform/x86/chromeos_laptop.c
index 80b8d32..47d665b 100644
--- a/drivers/platform/x86/chromeos_laptop.c
+++ b/drivers/platform/x86/chromeos_laptop.c
@@ -23,6 +23,8 @@
 
 #include <linux/dmi.h>
 #include <linux/i2c.h>
+#include <linux/i2c/atmel_mxt_ts.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
@@ -68,15 +70,43 @@ static struct i2c_board_info __initdata tsl2563_als_device = {
 	I2C_BOARD_INFO("tsl2563", TAOS_ALS_I2C_ADDR),
 };
 
+static struct mxt_platform_data atmel_224s_tp_platform_data = {
+	.x_line			= 18,
+	.y_line			= 12,
+	.x_size			= 102*20,
+	.y_size			= 68*20,
+	.blen			= 0x80,	/* Gain setting is in upper 4 bits */
+	.threshold		= 0x32,
+	.voltage		= 0,	/* 3.3V */
+	.orient			= MXT_VERTICAL_FLIP,
+	.irqflags		= IRQF_TRIGGER_FALLING,
+	.config			= NULL,
+	.config_length		= 0,
+};
+
 static struct i2c_board_info __initdata atmel_224s_tp_device = {
 	I2C_BOARD_INFO("atmel_mxt_tp", ATMEL_TP_I2C_ADDR),
-	.platform_data = NULL,
+	.platform_data = &atmel_224s_tp_platform_data,
 	.flags		= I2C_CLIENT_WAKE,
 };
 
+static struct mxt_platform_data atmel_1664s_platform_data = {
+	.x_line			= 32,
+	.y_line			= 50,
+	.x_size			= 1700,
+	.y_size			= 2560,
+	.blen			= 0x89,	/* Gain setting is in upper 4 bits */
+	.threshold		= 0x28,
+	.voltage		= 0,	/* 3.3V */
+	.orient			= MXT_ROTATED_90_COUNTER,
+	.irqflags		= IRQF_TRIGGER_FALLING,
+	.config			= NULL,
+	.config_length		= 0,
+};
+
 static struct i2c_board_info __initdata atmel_1664s_device = {
 	I2C_BOARD_INFO("atmel_mxt_ts", ATMEL_TS_I2C_ADDR),
-	.platform_data = NULL,
+	.platform_data = &atmel_1664s_platform_data,
 	.flags		= I2C_CLIENT_WAKE,
 };
 
-- 
1.8.1.3
