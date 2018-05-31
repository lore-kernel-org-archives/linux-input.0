From: flibitijibibo@gmail.com
Subject: [PATCH v3] goodix: Add new I2C/ACPI ids for GPD Win 2 touch screen
Date: Thu, 31 May 2018 08:10:52 -0400
Message-ID: <20180531121052.18489-1-flibitijibibo@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: hadess@hadess.net, Ethan Lee <flibitijibibo@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Ethan Lee <flibitijibibo@gmail.com>

GPD Win 2 Website: http://www.gpd.hk/gpdwin2.asp

Tested on a unit from the first production run sent to Indiegogo backers

Signed-off-by: Ethan Lee <flibitijibibo@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/input/touchscreen/goodix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 9736c83dd418..6a4ffe800194 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -926,6 +926,7 @@ static SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend, goodix_resume);
 
 static const struct i2c_device_id goodix_ts_id[] = {
 	{ "GDIX1001:00", 0 },
+	{ "GDIX1002:00", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
@@ -933,6 +934,7 @@ MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id goodix_acpi_match[] = {
 	{ "GDIX1001", 0 },
+	{ "GDIX1002", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
-- 
2.13.6
