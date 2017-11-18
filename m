From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 07/10 v3] Input: sun4i-ts: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 16:25:14 +0530
Message-ID: <184c9420c0824fe60df98db0922762e3abfb2e05.1510999558.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34504 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946661AbdKRKzv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 05:55:51 -0500
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, mcuos.com@gmail.com, linux@roeck-us.net, linux@armlinux.org.uk, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              ts->irq is unsigned. used int irq variable.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/input/touchscreen/sun4i-ts.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index d2e14d9..315f26b 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -251,6 +251,7 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 	bool ts_attached;
 	u32 tp_sensitive_adjust = 15;
 	u32 filter_type = 1;
+	int irq;
 
 	ts = devm_kzalloc(dev, sizeof(struct sun4i_ts_data), GFP_KERNEL);
 	if (!ts)
@@ -314,7 +315,10 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 	if (IS_ERR(ts->base))
 		return PTR_ERR(ts->base);
 
-	ts->irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq;
+	ts->irq = irq;
 	error = devm_request_irq(dev, ts->irq, sun4i_ts_irq, 0, "sun4i-ts", ts);
 	if (error)
 		return error;
-- 
2.7.4

