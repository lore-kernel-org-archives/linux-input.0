From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] input: gpio-keys-polled: Add support for EV_REP
Date: Thu, 29 Nov 2012 20:46:01 +0400
Message-ID: <1354207561-24971-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback6.mail.ru ([94.100.176.134]:58779 "EHLO
	fallback6.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab2K2Q7j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 11:59:39 -0500
Received: from smtp50.i.mail.ru (smtp50.i.mail.ru [94.100.177.110])
	by fallback6.mail.ru (mPOP.Fallback_MX) with ESMTP id 89DC29BDB897
	for <linux-input@vger.kernel.org>; Thu, 29 Nov 2012 20:46:25 +0400 (MSK)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/keyboard/gpio_keys_polled.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 32e5087..952c33d 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -245,7 +245,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	input = poll_dev->input;
 
-	input->evbit[0] = BIT(EV_KEY);
+	input->evbit[0] = BIT(EV_KEY) | (pdata->rep ? BIT(EV_REP) : 0);
 	input->name = pdev->name;
 	input->phys = DRV_NAME"/input0";
 	input->dev.parent = &pdev->dev;
-- 
1.7.8.6

