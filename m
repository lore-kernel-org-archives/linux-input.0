From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] Input: olpc_apsp - remove redundant dev_err call in olpc_apsp_probe()
Date: Wed, 17 Jul 2013 13:31:05 +0800
Message-ID: <CAPgLHd-tOWoxE-qYOkX_HcQRaUsifn0MQH=i+2KDARLKAxz2KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:57173 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab3GQFbH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jul 2013 01:31:07 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so549797bkc.6
        for <linux-input@vger.kernel.org>; Tue, 16 Jul 2013 22:31:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, dsd@laptop.org
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/serio/olpc_apsp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
index 818aa46..c96e3bd 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -187,10 +187,8 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 		return -ENOENT;
 
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->base)) {
-		dev_err(&pdev->dev, "Failed to map WTM registers\n");
+	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
-	}
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq < 0)

