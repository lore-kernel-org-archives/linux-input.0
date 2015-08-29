From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] Input: cyttsp - Remove unnecessary MODULE_ALIAS()
Date: Sat, 29 Aug 2015 03:05:24 +0200
Message-ID: <1440810324-14382-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60967 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbbH2BFn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 21:05:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Ferruh Yigit <fery@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The drivers have a I2C device ID table that is used to create the module
aliases and also "cyttsp" and "cyttsp4" are not supported I2C device IDs
so these module aliases are never used.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/input/touchscreen/cyttsp4_i2c.c | 1 -
 drivers/input/touchscreen/cyttsp_i2c.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_i2c.c b/drivers/input/touchscreen/cyttsp4_i2c.c
index 9a323dd915de..a9f95c7d3c00 100644
--- a/drivers/input/touchscreen/cyttsp4_i2c.c
+++ b/drivers/input/touchscreen/cyttsp4_i2c.c
@@ -86,4 +86,3 @@ module_i2c_driver(cyttsp4_i2c_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) I2C driver");
 MODULE_AUTHOR("Cypress");
-MODULE_ALIAS("i2c:cyttsp4");
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 519e2de2f8df..eee51b3f2e3f 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -86,4 +86,3 @@ module_i2c_driver(cyttsp_i2c_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) I2C driver");
 MODULE_AUTHOR("Cypress");
-MODULE_ALIAS("i2c:cyttsp");
-- 
2.4.3

