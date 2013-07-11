From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] Input: imx_keypad - check the return value from clk_prepare_enable()
Date: Thu, 11 Jul 2013 01:44:47 -0300
Message-ID: <1373517888-15615-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:64486 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab3GKEuZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Jul 2013 00:50:25 -0400
Received: by mail-yh0-f50.google.com with SMTP id i72so3083961yha.37
        for <linux-input@vger.kernel.org>; Wed, 10 Jul 2013 21:50:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 03c8cc5..99d3360 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -512,7 +512,9 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	input_set_drvdata(input_dev, keypad);
 
 	/* Ensure that the keypad will stay dormant until opened */
-	clk_prepare_enable(keypad->clk);
+	error = clk_prepare_enable(keypad->clk);
+	if (error)
+		return error;
 	imx_keypad_inhibit(keypad);
 	clk_disable_unprepare(keypad->clk);
 
-- 
1.8.1.2

