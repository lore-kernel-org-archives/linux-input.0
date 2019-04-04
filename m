From: Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 3/5] Input: s3c2410_ts: Use devm_platform_ioremap_resource()
Date: Thu,  4 Apr 2019 12:47:21 +0530
Message-ID: <1554362243-2888-4-git-send-email-mojha@codeaurora.org>
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
 drivers/input/touchscreen/s3c2410_ts.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 1173890..e11cdae 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -242,7 +242,6 @@ static int s3c2410ts_probe(struct platform_device *pdev)
 	struct s3c2410_ts_mach_info *info;
 	struct device *dev = &pdev->dev;
 	struct input_dev *input_dev;
-	struct resource *res;
 	int ret = -EINVAL;
 
 	/* Initialise input stuff */
@@ -277,14 +276,7 @@ static int s3c2410ts_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "no resource for registers\n");
-		ret = -ENOENT;
-		goto err_clk;
-	}
-
-	ts.io = ioremap(res->start, resource_size(res));
+	ts.io = devm_platform_ioremap_resource(pdev, 0);
 	if (ts.io == NULL) {
 		dev_err(dev, "cannot map registers\n");
 		ret = -ENOMEM;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
