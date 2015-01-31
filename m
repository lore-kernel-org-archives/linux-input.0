From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] Input: cap11xx - Remove wrong and unneeded cap11xx modalias
Date: Sat, 31 Jan 2015 12:38:02 +0800
Message-ID: <1422679082.8722.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:64054 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbbAaEiH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 23:38:07 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so60143237pab.0
        for <linux-input@vger.kernel.org>; Fri, 30 Jan 2015 20:38:07 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matt Ranostay <mranostay@gmail.com>, Daniel Mack <daniel@zonque.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

This is a I2C driver, so it's wrong to use platform prefix for the modalias.
We have all needed i2c aliases coming form MODULE_DEVICE_TABLE,
so remove the wrong and unneeded cap11xx modalias.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/input/keyboard/cap11xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 4f59f0b..f07461a 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -370,7 +370,6 @@ static struct i2c_driver cap11xx_i2c_driver = {
 
 module_i2c_driver(cap11xx_i2c_driver);
 
-MODULE_ALIAS("platform:cap11xx");
 MODULE_DESCRIPTION("Microchip CAP11XX driver");
 MODULE_AUTHOR("Daniel Mack <linux@zonque.org>");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1



