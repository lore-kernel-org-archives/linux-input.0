From: Asaf Vertz <asaf.vertz@tandemg.com>
Subject: [PATCH v2] input: edt-ft5x06: fixed a macro coding style issue
Date: Tue, 9 Dec 2014 10:08:16 +0200
Message-ID: <20141209080816.GA19581@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:60333 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbaLIIIU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Dec 2014 03:08:20 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so785461wiw.3
        for <linux-input@vger.kernel.org>; Tue, 09 Dec 2014 00:08:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: LW@KARO-electronics.de, B38611@freescale.com, maksqwe1@ukr.net, jg1.han@samsung.com, linux@rasmusvillemoes.dk, fabf@skynet.be, joe@perches.com, asaf.vertz@tandemg.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Fixed a coding style error, macros with complex values should be
enclosed in parentheses.

Signed-off-by: Asaf Vertz <asaf.vertz@tandemg.com>
---
Changes in v2:
  - use do {...} while (0)  instead of {...}

 drivers/input/touchscreen/edt-ft5x06.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ee3434f..d22ed56 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -850,9 +850,11 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 }
 
 #define EDT_ATTR_CHECKSET(name, reg) \
+do {								\
 	if (pdata->name >= edt_ft5x06_attr_##name.limit_low &&		\
 	    pdata->name <= edt_ft5x06_attr_##name.limit_high)		\
-		edt_ft5x06_register_write(tsdata, reg, pdata->name)
+		edt_ft5x06_register_write(tsdata, reg, pdata->name);	\
+} while (0)
 
 #define EDT_GET_PROP(name, reg) {				\
 	u32 val;						\
-- 
1.7.0.4

