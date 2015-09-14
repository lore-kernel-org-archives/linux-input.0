From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2 2/4] Input: imx6ul_tsc - Check for negative return value
Date: Mon, 14 Sep 2015 14:00:01 -0300
Message-ID: <1442250003-4040-2-git-send-email-fabio.estevam@freescale.com>
References: <1442250003-4040-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bbn0104.outbound.protection.outlook.com ([157.56.111.104]:1248
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752409AbbINRAO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2015 13:00:14 -0400
In-Reply-To: <1442250003-4040-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: haibo.chen@freescale.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

We should check for negative values returned by platform_get_irq().

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Pass 'imx6ul_tsc' in the Subject

 drivers/input/touchscreen/imx6ul_tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 0a96b76..4957d8b 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -416,7 +416,7 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 	}
 
 	adc_irq = platform_get_irq(pdev, 1);
-	if (adc_irq <= 0) {
+	if (adc_irq < 0) {
 		dev_err(&pdev->dev, "no adc irq resource?\n");
 		return adc_irq;
 	}
-- 
1.9.1

