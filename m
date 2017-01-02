From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] Input: adxl34x - Make it enumerable in ACPI environment
Date: Mon,  2 Jan 2017 14:06:23 +0200
Message-ID: <20170102120624.178283-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56962 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755411AbdABMGe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Jan 2017 07:06:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The ACPI-enabled platform may contain _DSD method to enable this driver using
compatible string.

Remove OF specifics to re-use existing code on ACPI-enabled platforms.

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/misc/adxl34x-i2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index a8b0a2eec344..7fed92fb8cc1 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -136,7 +136,6 @@ static const struct i2c_device_id adxl34x_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, adxl34x_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id adxl34x_of_id[] = {
 	/*
 	 * The ADXL346 is backward-compatible with the ADXL345. Differences are
@@ -153,13 +152,12 @@ static const struct of_device_id adxl34x_of_id[] = {
 };
 
 MODULE_DEVICE_TABLE(of, adxl34x_of_id);
-#endif
 
 static struct i2c_driver adxl34x_driver = {
 	.driver = {
 		.name = "adxl34x",
 		.pm = &adxl34x_i2c_pm,
-		.of_match_table = of_match_ptr(adxl34x_of_id),
+		.of_match_table = adxl34x_of_id,
 	},
 	.probe    = adxl34x_i2c_probe,
 	.remove   = adxl34x_i2c_remove,
-- 
2.11.0

