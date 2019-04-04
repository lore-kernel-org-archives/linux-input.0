From: Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 1/5] Input: fsl-imx25-tcq: Use devm_platform_ioremap_resource()
Date: Thu,  4 Apr 2019 12:47:19 +0530
Message-ID: <1554362243-2888-2-git-send-email-mojha@codeaurora.org>
References: <1554362243-2888-1-git-send-email-mojha@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554362243-2888-1-git-send-email-mojha@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mukesh Ojha <mojha@codeaurora.org>
List-Id: linux-input@vger.kernel.org

devm_platform_ioremap_resource() internally have platform_get_resource()
and devm_ioremap_resource() in it. So instead of calling them separately
use devm_platform_ioremap_resource() directly.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 drivers/input/touchscreen/fsl-imx25-tcq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
index 1d6c8f4..b66df8a 100644
--- a/drivers/input/touchscreen/fsl-imx25-tcq.c
+++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
@@ -503,7 +503,6 @@ static int mx25_tcq_probe(struct platform_device *pdev)
 	struct input_dev *idev;
 	struct mx25_tcq_priv *priv;
 	struct mx25_tsadc *tsadc = dev_get_drvdata(dev->parent);
-	struct resource *res;
 	void __iomem *mem;
 	int error;
 
@@ -512,8 +511,7 @@ static int mx25_tcq_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mem = devm_ioremap_resource(dev, res);
+	mem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
