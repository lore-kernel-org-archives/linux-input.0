From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] Input: drv2667 - Remove wrong and unneeded
 drv2667-haptics modalias
Date: Sat, 31 Jan 2015 13:21:45 +0800
Message-ID: <1422681705.10152.2.camel@phoenix>
References: <1422681645.10152.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42592 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbAaFVt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 00:21:49 -0500
Received: by mail-pa0-f42.google.com with SMTP id bj1so60472126pad.1
        for <linux-input@vger.kernel.org>; Fri, 30 Jan 2015 21:21:49 -0800 (PST)
In-Reply-To: <1422681645.10152.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

This is a I2C driver, so it's wrong to use platform prefix for the modalias.
We have all needed i2c aliases coming form MODULE_DEVICE_TABLE,
so remove the wrong and unneeded drv2667-haptics modalias.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/input/misc/drv2667.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
index a021744..fc0fddf 100644
--- a/drivers/input/misc/drv2667.c
+++ b/drivers/input/misc/drv2667.c
@@ -492,7 +492,6 @@ static struct i2c_driver drv2667_driver = {
 };
 module_i2c_driver(drv2667_driver);
 
-MODULE_ALIAS("platform:drv2667-haptics");
 MODULE_DESCRIPTION("TI DRV2667 haptics driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
-- 
1.9.1



