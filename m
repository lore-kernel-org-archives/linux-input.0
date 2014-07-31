From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: imx_keypad - Remove ifdef
Date: Thu, 31 Jul 2014 15:42:05 -0300
Message-ID: <1406832125-3814-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:52921 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaGaSm0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2014 14:42:26 -0400
Received: by mail-vc0-f177.google.com with SMTP id hy4so4829675vcb.22
        for <linux-input@vger.kernel.org>; Thu, 31 Jul 2014 11:42:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

We can annonate the suspend/resume functions with '__maybe_unused' and get rid
of the ifdef, which makes the code smaller and simpler

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 8280cb1..20a99c3 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -531,8 +531,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int imx_kbd_suspend(struct device *dev)
+static int __maybe_unused imx_kbd_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_keypad *kbd = platform_get_drvdata(pdev);
@@ -552,7 +551,7 @@ static int imx_kbd_suspend(struct device *dev)
 	return 0;
 }
 
-static int imx_kbd_resume(struct device *dev)
+static int __maybe_unused imx_kbd_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_keypad *kbd = platform_get_drvdata(pdev);
@@ -575,7 +574,6 @@ err_clk:
 
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(imx_kbd_pm_ops, imx_kbd_suspend, imx_kbd_resume);
 
-- 
1.9.1

