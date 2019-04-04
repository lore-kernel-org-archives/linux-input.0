From: Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 5/5] Input: ts4800-ts: Use devm_platform_ioremap_resource()
Date: Thu,  4 Apr 2019 12:47:23 +0530
Message-ID: <1554362243-2888-6-git-send-email-mojha@codeaurora.org>
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
 drivers/input/touchscreen/ts4800-ts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ts4800-ts.c b/drivers/input/touchscreen/ts4800-ts.c
index fed73ee..5b4f536 100644
--- a/drivers/input/touchscreen/ts4800-ts.c
+++ b/drivers/input/touchscreen/ts4800-ts.c
@@ -148,7 +148,6 @@ static int ts4800_ts_probe(struct platform_device *pdev)
 {
 	struct input_polled_dev *poll_dev;
 	struct ts4800_ts *ts;
-	struct resource *res;
 	int error;
 
 	ts = devm_kzalloc(&pdev->dev, sizeof(*ts), GFP_KERNEL);
@@ -159,8 +158,7 @@ static int ts4800_ts_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ts->base = devm_ioremap_resource(&pdev->dev, res);
+	ts->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ts->base))
 		return PTR_ERR(ts->base);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
