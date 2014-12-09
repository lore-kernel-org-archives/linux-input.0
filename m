From: Asaf Vertz <asaf.vertz@tandemg.com>
Subject: [PATCH] input: edt-ft5x06: fixed a macro coding style issue
Date: Tue, 9 Dec 2014 08:34:56 +0200
Message-ID: <20141209063456.GA15121@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:49007 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbaLIGfB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Dec 2014 01:35:01 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so6798933wib.4
        for <linux-input@vger.kernel.org>; Mon, 08 Dec 2014 22:35:00 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: LW@KARO-electronics.de, B38611@freescale.com, maksqwe1@ukr.net, jg1.han@samsung.com, linux@rasmusvillemoes.dk, fabf@skynet.be, asaf.vertz@tandemg.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Fixed a coding style error, macros with complex values should be
enclosed in parentheses.

Signed-off-by: Asaf Vertz <asaf.vertz@tandemg.com>
---
 drivers/input/touchscreen/edt-ft5x06.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ee3434f..6db9253 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -849,10 +849,11 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 	return 0;
 }
 
-#define EDT_ATTR_CHECKSET(name, reg) \
+#define EDT_ATTR_CHECKSET(name, reg) { \
 	if (pdata->name >= edt_ft5x06_attr_##name.limit_low &&		\
 	    pdata->name <= edt_ft5x06_attr_##name.limit_high)		\
-		edt_ft5x06_register_write(tsdata, reg, pdata->name)
+		edt_ft5x06_register_write(tsdata, reg, pdata->name);	\
+}
 
 #define EDT_GET_PROP(name, reg) {				\
 	u32 val;						\
-- 
1.7.0.4

