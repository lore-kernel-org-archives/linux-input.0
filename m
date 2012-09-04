From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2] Input: imx_keypad - Fix missing clk conversions
Date: Tue, 4 Sep 2012 10:39:05 -0300
Message-ID: <1346765945-31453-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:7278
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753151Ab2IDNjS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Sep 2012 09:39:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

commit a1e636e6d3 (Input: imx_keypad - adapt the new kpp clock name)
missed to update clk_enable/clk_disable from imx_keypad_probe().

Fix it so that we do not get clk warnings at boot.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Add commit id
 drivers/input/keyboard/imx_keypad.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index ce68e36..cdc2526 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -516,9 +516,9 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 	input_set_drvdata(input_dev, keypad);
 
 	/* Ensure that the keypad will stay dormant until opened */
-	clk_enable(keypad->clk);
+	clk_prepare_enable(keypad->clk);
 	imx_keypad_inhibit(keypad);
-	clk_disable(keypad->clk);
+	clk_disable_unprepare(keypad->clk);
 
 	error = request_irq(irq, imx_keypad_irq_handler, 0,
 			    pdev->name, keypad);
-- 
1.7.9.5


