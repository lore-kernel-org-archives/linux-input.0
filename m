From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: imx_keypad - Place SIMPLE_DEV_PM_OPS inside CONFIG_PM_SLEEP if block
Date: Thu, 11 Apr 2013 02:16:00 -0300
Message-ID: <1365657360-877-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:52963 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab3DKGJk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Apr 2013 02:09:40 -0400
Received: by mail-yh0-f41.google.com with SMTP id q11so193493yhf.14
        for <linux-input@vger.kernel.org>; Wed, 10 Apr 2013 23:09:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

SIMPLE_DEV_PM_OPS should be inside the CONFIG_PM_SLEEP 'if' block because
imx_kbd_suspend and imx_kbd_resume definitions are inside this block.

While at it, also add a definition for IMX_KBD_PM_OPS, which can handle the case
when CONFIG_PM_SLEEP is not selected.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 03c8cc5..2663c91 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -580,15 +580,17 @@ err_clk:
 
 	return ret;
 }
-#endif
-
 static SIMPLE_DEV_PM_OPS(imx_kbd_pm_ops, imx_kbd_suspend, imx_kbd_resume);
+#define IMX_KBD_PM_OPS (&imx_kbd_pm_ops)
+#else
+#define IMX_KBD_PM_OPS NULL
+#endif /* CONFIG_PM_SLEEP */
 
 static struct platform_driver imx_keypad_driver = {
 	.driver		= {
 		.name	= "imx-keypad",
 		.owner	= THIS_MODULE,
-		.pm	= &imx_kbd_pm_ops,
+		.pm	= IMX_KBD_PM_OPS,
 		.of_match_table = of_match_ptr(imx_keypad_of_match),
 	},
 	.probe		= imx_keypad_probe,
-- 
1.7.9.5

