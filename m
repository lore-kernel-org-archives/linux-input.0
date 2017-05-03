From: "jeffrey.lin" <yajohn@gmail.com>
Subject: [PATCH] driver: input :touchscreen : Change Raydium firmware update parameter
Date: Wed,  3 May 2017 23:37:17 +0800
Message-ID: <20170503153717.328-1-jeffrey.lin@rad-ic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33266 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdECPhZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 3 May 2017 11:37:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, bleung@chromium.org, groeck@chromium.org, Katherine.Hsieh@quantatw.com
Cc: jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, calvin.tseng@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, "jeffrey.lin" <jeffrey.lin@raydium.corp-partner.google.com>

From: "jeffrey.lin" <jeffrey.lin@raydium.corp-partner.google.com>

Change boot mode trigger parameter of Raydium firmware update.

Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index a99fb5cac5a0..8a81257634ba 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -450,7 +450,7 @@ static bool raydium_i2c_boot_trigger(struct i2c_client *client)
 		{ 0x08, 0x04, 0x09, 0x00, 0x50, 0xA5 },
 		{ 0x08, 0x0C, 0x09, 0x00, 0x50, 0x00 },
 		{ 0x06, 0x01, 0x00, 0x00, 0x00, 0x00 },
-		{ 0x02, 0xA2, 0x00, 0x00, 0x00, 0x00 },
+		{ 0x02, 0xA1, 0x00, 0x00, 0x00, 0x00 },
 	};
 	int i;
 	int error;
@@ -1199,7 +1199,7 @@ static SIMPLE_DEV_PM_OPS(raydium_i2c_pm_ops,
 			 raydium_i2c_suspend, raydium_i2c_resume);
 
 static const struct i2c_device_id raydium_i2c_id[] = {
-	{ "raydium_i2c" , 0 },
+	{ "raydium_i2c", 0 },
 	{ "rm32380", 0 },
 	{ /* sentinel */ }
 };
-- 
2.12.2

