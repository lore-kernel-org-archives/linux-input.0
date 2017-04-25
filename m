From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] input: touchscreen: mxs-lradc: Fix return value check in mxs_lradc_ts_probe()
Date: Tue, 25 Apr 2017 06:26:46 +0000
Message-ID: <20170425062646.26043-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34998 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980632AbdDYG0x (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 02:26:53 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so8800660pge.2
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 23:26:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/input/touchscreen/mxs-lradc-ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index 4b4aebf..ff9cda2 100644
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

