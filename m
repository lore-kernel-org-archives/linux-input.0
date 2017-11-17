From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 09/10] Input: sirfsoc-onkey: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 00:45:31 +0530
Message-ID: <1510946132-13554-10-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33930 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161646AbdKQTQ2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 14:16:28 -0500
In-Reply-To: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/misc/sirfsoc-onkey.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 4fd038d..de04b48 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -149,6 +149,9 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 	sirfsoc_pwrc_toggle_interrupts(pwrcdrv, false);
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	error = devm_request_irq(&pdev->dev, irq,
 				 sirfsoc_pwrc_isr, 0,
 				 "sirfsoc_pwrc_int", pwrcdrv);
-- 
2.7.4

