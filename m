From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 3/4] Input: touchscreen - Use the preferred method for kzalloc()
Date: Mon, 14 Sep 2015 13:53:19 -0300
Message-ID: <1442249600-666-3-git-send-email-fabio.estevam@freescale.com>
References: <1442249600-666-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0140.outbound.protection.outlook.com ([65.55.169.140]:2446
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752316AbbINRIh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2015 13:08:37 -0400
In-Reply-To: <1442249600-666-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: haibo.chen@freescale.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

According to Documentation/CodingStyle:

"The preferred form for passing a size of a struct is the following:

	p = kmalloc(sizeof(*p), ...);"

, so do as suggested.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/touchscreen/imx6ul_tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 4957d8b..67c73f2 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -347,7 +347,7 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 	int tsc_irq;
 	int adc_irq;
 
-	tsc = devm_kzalloc(&pdev->dev, sizeof(struct imx6ul_tsc), GFP_KERNEL);
+	tsc = devm_kzalloc(&pdev->dev, sizeof(*tsc), GFP_KERNEL);
 	if (!tsc)
 		return -ENOMEM;
 
-- 
1.9.1

