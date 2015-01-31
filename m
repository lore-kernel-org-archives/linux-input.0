From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] Input: drv260x - Remove wrong and unneeded
 drv260x-haptics modalias
Date: Sat, 31 Jan 2015 13:20:45 +0800
Message-ID: <1422681645.10152.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:49387 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbAaFUt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 00:20:49 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so60320023pab.12
        for <linux-input@vger.kernel.org>; Fri, 30 Jan 2015 21:20:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

This is a I2C driver, so it's wrong to use platform prefix for the modalias.
We have all needed i2c aliases coming form MODULE_DEVICE_TABLE,
so remove the wrong and unneeded drv260x-haptics modalias.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/input/misc/drv260x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index a364e10..5995780 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -733,7 +733,6 @@ static struct i2c_driver drv260x_driver = {
 };
 module_i2c_driver(drv260x_driver);
 
-MODULE_ALIAS("platform:drv260x-haptics");
 MODULE_DESCRIPTION("TI DRV260x haptics driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
-- 
1.9.1



