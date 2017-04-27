From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next v2] input: touchscreen: mxs-lradc: Fix return value check in mxs_lradc_ts_probe()
Date: Thu, 27 Apr 2017 15:13:52 +0000
Message-ID: <20170427151352.23463-1-weiyj.lk@gmail.com>
References: <20170425062646.26043-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33759 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966066AbdD0POA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Apr 2017 11:14:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id c198so11183716pfc.0
        for <linux-input@vger.kernel.org>; Thu, 27 Apr 2017 08:14:00 -0700 (PDT)
In-Reply-To: <20170425062646.26043-1-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marek Vasut <marex@denx.de>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_ioremap() returns NULL pointer not
ERR_PTR(). Use devm_ioremap_resource() instead of devm_ioremap().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: use devm_ioremap_resource()
---
 drivers/input/touchscreen/mxs-lradc-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index 4b4aebf..2c5076c 100644
--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -630,7 +630,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 	spin_lock_init(&ts->lock);
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
+	ts->base = devm_ioremap_resource(dev, iores);
 	if (IS_ERR(ts->base))
 		return PTR_ERR(ts->base);

