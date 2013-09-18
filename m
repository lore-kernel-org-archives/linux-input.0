From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH v2] input: pxa27x_keypad: fix NULL pointer dereference
Date: Wed, 18 Sep 2013 08:03:44 -0700
Message-ID: <1379516624-3789-1-git-send-email-mikedunn@newsguy.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.newsguy.com ([74.209.136.69]:63561 "EHLO smtp.newsguy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612Ab3IRPFs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Sep 2013 11:05:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mike Dunn <mikedunn@newsguy.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>

A NULL pointer dereference exception occurs in the driver probe function when
device tree is used.  The pdata pointer will be NULL in this case, but the code
dereferences it in all cases.  When device tree is used, a platform data
structure is allocated and initialized, and in all cases this pointer is copied
to the driver's private data, so the variable being tested should be accessed
through the driver's private data structure.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
Changelog:
v2:
Initialize pdata for DT case, instead of referencing through keypad struct.

 drivers/input/keyboard/pxa27x_keypad.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 134c3b4..d02bdb2 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -788,8 +788,10 @@ static int pxa27x_keypad_probe(struct platform_device *pdev)
 
 	if (pdata)
 		error = pxa27x_keypad_build_keycode(keypad);
-	else
+	else {
 		error = pxa27x_keypad_build_keycode_from_dt(keypad);
+		pdata = keypad->pdata;
+	}
 	if (error) {
 		dev_err(&pdev->dev, "failed to build keycode\n");
 		goto failed_put_clk;
-- 
1.8.1.5

