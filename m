From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] input: touchscreen: mxs-lradc: Use devm_ioremap_resource()
Date: Wed, 21 Jun 2017 11:03:24 -0300
Message-ID: <1498053804-11297-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:35331
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752006AbdFUODp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 21 Jun 2017 10:03:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: festevam@gmail.com, marex@denx.de, ksenija.stanojevic@gmail.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

In case of error devm_ioremap() returns NULL pointer not ERR_PTR().

The iores NULL check is also missing.

Fix both problems by using devm_ioremap_resource() variant instead.

Fixes: d81ca730e3e4 ("input: touchscreen: mxs-lradc: Add support for touchscreen")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/input/touchscreen/mxs-lradc-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index 58c016c..0f8c9e7 100644
--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -630,7 +630,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 	spin_lock_init(&ts->lock);
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
+	ts->base = devm_ioremap_resource(dev, iores);
 	if (IS_ERR(ts->base))
 		return PTR_ERR(ts->base);
 
-- 
2.7.4

