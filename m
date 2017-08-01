From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/2] Input: pxa27x_keypad: Handle return value of clk_prepare_enable.
Date: Tue,  1 Aug 2017 15:34:10 +0530
Message-ID: <462d2ba4a19174ca1af9efe74f57fd815c0034d1.1501581502.git.arvind.yadav.cs@gmail.com>
References: <e18b64df1c144ac6ac05bd16e0d5d0cd59a20d13.1501581502.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36071 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdHAKEZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 1 Aug 2017 06:04:25 -0400
In-Reply-To: <e18b64df1c144ac6ac05bd16e0d5d0cd59a20d13.1501581502.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/keyboard/pxa27x_keypad.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 3841fa3..a3396a7 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -644,9 +644,12 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 static int pxa27x_keypad_open(struct input_dev *dev)
 {
 	struct pxa27x_keypad *keypad = input_get_drvdata(dev);
-
+	int ret;
 	/* Enable unit clock */
-	clk_prepare_enable(keypad->clk);
+	ret = clk_prepare_enable(keypad->clk);
+	if (ret)
+		return ret;
+
 	pxa27x_keypad_config(keypad);
 
 	return 0;
@@ -683,6 +686,7 @@ static int pxa27x_keypad_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 	struct input_dev *input_dev = keypad->input_dev;
+	int ret;
 
 	/*
 	 * If the keypad is used as wake up source, the clock is not turned
@@ -695,7 +699,11 @@ static int pxa27x_keypad_resume(struct device *dev)
 
 		if (input_dev->users) {
 			/* Enable unit clock */
-			clk_prepare_enable(keypad->clk);
+			ret = clk_prepare_enable(keypad->clk);
+			if (ret) {
+				mutex_unlock(&input_dev->mutex);
+				return ret;
+			}
 			pxa27x_keypad_config(keypad);
 		}
 
-- 
1.9.1

