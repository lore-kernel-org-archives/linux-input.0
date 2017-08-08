From: Pan Bian <bianpan2016@163.com>
Subject: input: touchscreen: mxs-lradc: use correct error check
Date: Tue,  8 Aug 2017 21:00:37 +0800
Message-ID: <1502197237-19251-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m12-12.163.com ([220.181.12.12]:52250 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752051AbdHHNBb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 8 Aug 2017 09:01:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Marek Vasut <marex@denx.de>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>

Function devm_ioremap() will return a NULL pointer on failure. However,
in function mxs_lradc_ts_probe(), its return value is checked with
IS_ERR(), which cannot detect the exceptional case.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/input/touchscreen/mxs-lradc-ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index 58c016c..9bcc98c6 100644
--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -631,8 +631,8 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
-	if (IS_ERR(ts->base))
-		return PTR_ERR(ts->base);
+	if (!ts->base)
+		return -ENOMEM;
 
 	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
 				   &ts_wires);
-- 
1.9.1


