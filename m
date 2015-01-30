From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] Input: cap11xx - fix module alias
Date: Fri, 30 Jan 2015 09:28:13 +0800
Message-ID: <1422581293.4982.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:50073 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbbA3B2S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 20:28:18 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so45570537pab.6
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2015 17:28:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matt Ranostay <mranostay@gmail.com>, Daniel Mack <daniel@zonque.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

This is a I2C driver, so use i2c prefix for the module alias.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/input/keyboard/cap11xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 4f59f0b..938f0d5 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -370,7 +370,7 @@ static struct i2c_driver cap11xx_i2c_driver = {
 
 module_i2c_driver(cap11xx_i2c_driver);
 
-MODULE_ALIAS("platform:cap11xx");
+MODULE_ALIAS("i2c:cap11xx");
 MODULE_DESCRIPTION("Microchip CAP11XX driver");
 MODULE_AUTHOR("Daniel Mack <linux@zonque.org>");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1



