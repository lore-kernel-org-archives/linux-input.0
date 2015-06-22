From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: imx_keypad - check for clk_prepare_enable() error
Date: Mon, 22 Jun 2015 01:01:18 -0300
Message-ID: <1434945678-8027-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:35930 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbbFVEBn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2015 00:01:43 -0400
Received: by qcet6 with SMTP id t6so22820738qce.3
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2015 21:01:42 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 2e855e6..d2ea863 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -506,7 +506,9 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	input_set_drvdata(input_dev, keypad);
 
 	/* Ensure that the keypad will stay dormant until opened */
-	clk_prepare_enable(keypad->clk);
+	error = clk_prepare_enable(keypad->clk);
+	if (error)
+		return error;
 	imx_keypad_inhibit(keypad);
 	clk_disable_unprepare(keypad->clk);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
