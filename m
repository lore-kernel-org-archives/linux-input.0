From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2 2/3]  keyboard: imx_keypad: Adapt the new kpp clock name
Date: Fri, 6 Jul 2012 14:41:53 -0300
Message-ID: <1341596514-15972-2-git-send-email-fabio.estevam@freescale.com>
References: <1341596514-15972-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:38224
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757636Ab2GFRmC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Jul 2012 13:42:02 -0400
In-Reply-To: <1341596514-15972-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

With the new i.mx clock framework we should pass NULL as the keypad clock name.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 9d57945..4830615 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -467,7 +467,7 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 		goto failed_free_priv;
 	}
 
-	keypad->clk = clk_get(&pdev->dev, "kpp");
+	keypad->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk)) {
 		dev_err(&pdev->dev, "failed to get keypad clock\n");
 		error = PTR_ERR(keypad->clk);
-- 
1.7.1


