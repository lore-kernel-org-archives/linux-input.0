From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2 3/3] keyboard: imx_keypad: Check error returned by clk_prepare_enable()
Date: Fri, 6 Jul 2012 14:41:54 -0300
Message-ID: <1341596514-15972-3-git-send-email-fabio.estevam@freescale.com>
References: <1341596514-15972-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:23660
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758056Ab2GFRmp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Jul 2012 13:42:45 -0400
In-Reply-To: <1341596514-15972-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Check error returned by clk_prepare_enable().

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 4830615..bdb8ee7 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -385,13 +385,17 @@ static int imx_keypad_open(struct input_dev *dev)
 {
 	struct imx_keypad *keypad = input_get_drvdata(dev);
 
+	int ret;
 	dev_dbg(&dev->dev, ">%s\n", __func__);
 
 	/* We became active from now */
 	keypad->enabled = true;
 
 	/* Enable the kpp clock */
-	clk_prepare_enable(keypad->clk);
+	ret = clk_prepare_enable(keypad->clk);
+	if (ret)
+		return ret;
+
 	imx_keypad_config(keypad);
 
 	/* Sanity control, not all the rows must be actived now. */
@@ -596,18 +600,23 @@ static int imx_kbd_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_keypad *kbd = platform_get_drvdata(pdev);
 	struct input_dev *input_dev = kbd->input_dev;
+	int ret = 0;
 
 	if (device_may_wakeup(&pdev->dev))
 		disable_irq_wake(kbd->irq);
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
-		clk_prepare_enable(kbd->clk);
+	if (input_dev->users) {
+		ret = clk_prepare_enable(kbd->clk);
+		if (ret)
+			goto err_clk;
+	}
 
+err_clk:
 	mutex_unlock(&input_dev->mutex);
 
-	return 0;
+	return ret;
 }
 #endif
 
-- 
1.7.1


