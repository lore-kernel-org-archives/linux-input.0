From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] Input: fix error return code in atmel_tsadcc_probe()
Date: Tue, 28 May 2013 13:19:57 +0800
Message-ID: <CAPgLHd_WUdJe+4mEDxXOoqZzGyQBb49wO=OQ+kz_3_nNLV26xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:48551 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458Ab3E1FT7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 May 2013 01:19:59 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik8so2955771bkc.23
        for <linux-input@vger.kernel.org>; Mon, 27 May 2013 22:19:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: josh.wu@atmel.com, dmitry.torokhov@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

If pdata is NULL, atmel_tsadcc_probe() will release all the resources
and return 0, but we need a error code is returned in this case.
Fix to return -EINVAL and move the check for pdata to the begin
of this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/touchscreen/atmel_tsadcc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_tsadcc.c b/drivers/input/touchscreen/atmel_tsadcc.c
index 75a0693..fbc72dd 100644
--- a/drivers/input/touchscreen/atmel_tsadcc.c
+++ b/drivers/input/touchscreen/atmel_tsadcc.c
@@ -187,6 +187,9 @@ static int atmel_tsadcc_probe(struct platform_device *pdev)
 	unsigned int	prsc;
 	unsigned int	reg;
 
+	if (!pdata)
+		return -EINVAL;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "no mmio resource defined.\n");
@@ -265,9 +268,6 @@ static int atmel_tsadcc_probe(struct platform_device *pdev)
 	prsc = clk_get_rate(ts_dev->clk);
 	dev_info(&pdev->dev, "Master clock is set at: %d Hz\n", prsc);
 
-	if (!pdata)
-		goto err_fail;
-
 	if (!pdata->adc_clock)
 		pdata->adc_clock = ADC_DEFAULT_CLOCK;
 

