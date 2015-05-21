From: Heiner Kallweit <heiner.kallweit@web.de>
Subject: [PATCH] touchscreen: stmpe-ts: enable module autoload
Date: Thu, 21 May 2015 23:19:52 +0200
Message-ID: <555E4BF8.80401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:56905 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756546AbbEUVUF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 17:20:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Even with poper DT config the module didn't autoload.
That's fixed by this additional alias.

Tested successfully with a STMPE610-based Adafruit PITFT Plus 3.5"
on RPI2 under Arch Linux ARM (kernel 3.18.13).

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/input/touchscreen/stmpe-ts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index e4c3125..1940e3c 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -393,4 +393,5 @@ module_platform_driver(stmpe_ts_driver);
 MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
 MODULE_DESCRIPTION("STMPEXXX touchscreen driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:" STMPE_TS_NAME);
 MODULE_ALIAS("platform:" STMPE_TS_NAME);
-- 
2.4.1

