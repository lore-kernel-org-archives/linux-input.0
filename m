From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH] input: pxa27x_keypad: fix NULL pointer dereference
Date: Mon, 16 Sep 2013 09:44:02 -0700
Message-ID: <1379349842-13089-1-git-send-email-mikedunn@newsguy.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.newsguy.com ([74.209.136.71]:65211 "EHLO
	smtp1.newsguy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab3IPRGw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Sep 2013 13:06:52 -0400
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
 drivers/input/keyboard/pxa27x_keypad.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 134c3b4..3b2a614 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -795,8 +795,10 @@ static int pxa27x_keypad_probe(struct platform_device *pdev)
 		goto failed_put_clk;
 	}
 
-	if ((pdata->enable_rotary0 && keypad->rotary_rel_code[0] != -1) ||
-	    (pdata->enable_rotary1 && keypad->rotary_rel_code[1] != -1)) {
+	if ((keypad->pdata->enable_rotary0 &&
+	     keypad->rotary_rel_code[0] != -1) ||
+	    (keypad->pdata->enable_rotary1 &&
+	     keypad->rotary_rel_code[1] != -1)) {
 		input_dev->evbit[0] |= BIT_MASK(EV_REL);
 	}
 
-- 
1.8.1.5

