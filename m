From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] Input: nspire-keypad - remove redundant dev_err call in nspire_keypad_probe()
Date: Wed, 26 Jun 2013 09:56:54 +0800
Message-ID: <CAPgLHd9GvrnP5-039TRMcmqHTZmezGGpgDwGmiNurB9G7PEZew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:38589 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3FZB4z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jun 2013 21:56:55 -0400
Received: by mail-bk0-f54.google.com with SMTP id it16so4567442bkc.41
        for <linux-input@vger.kernel.org>; Tue, 25 Jun 2013 18:56:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, dt.tangr@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/keyboard/nspire-keypad.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/nspire-keypad.c b/drivers/input/keyboard/nspire-keypad.c
index 1b0d04c..e0a1339 100644
--- a/drivers/input/keyboard/nspire-keypad.c
+++ b/drivers/input/keyboard/nspire-keypad.c
@@ -209,10 +209,8 @@ static int nspire_keypad_probe(struct platform_device *pdev)
 	}
 
 	keypad->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(keypad->reg_base)) {
-		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+	if (IS_ERR(keypad->reg_base))
 		return PTR_ERR(keypad->reg_base);
-	}
 
 	keypad->input = input = devm_input_allocate_device(&pdev->dev);
 	if (!input) {

