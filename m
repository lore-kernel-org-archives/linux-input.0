From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] Input: pmic8xxx-pwrkey - fix to pass correct device
 identity to free_irq()
Date: Tue, 17 Dec 2013 09:16:10 +0800
Message-ID: <CAPgLHd87FxZ6ur_WLC9Q9bjOfNbOTu6yzNWNcN-ar0=o1y48Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:50680 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab3LQBQL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 20:16:11 -0500
Received: by mail-bk0-f42.google.com with SMTP id w11so2611155bkz.29
        for <linux-input@vger.kernel.org>; Mon, 16 Dec 2013 17:16:10 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sboyd@codeaurora.org, lars@metafoo.de, sachin.kamat@linaro.org
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

free_irq() in the error handling case is missing when change
pass input device directly to interrupt.

Fixes: b27f8fee4965('Input: pmic8xxx-pwrkey - pass input device directly to interrupt')
Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/misc/pmic8xxx-pwrkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index ef93840..3914e5b 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -182,7 +182,7 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
 	return 0;
 
 free_press_irq:
-	free_irq(key_press_irq, pwrkey);
+	free_irq(key_press_irq, pwr);
 unreg_input_dev:
 	input_unregister_device(pwr);
 	pwr = NULL;

