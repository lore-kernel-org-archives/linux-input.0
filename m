From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 09/10 v2] Input: sirfsoc-onkey: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 16:25:16 +0530
Message-ID: <fe9a26770ba88ab9efee23dc28782dc0891b1d1a.1510999334.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45739 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424107AbdKRKz5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 05:55:57 -0500
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <76d6a73ba51e1a8a86d8d9a1d0bbbf7723d5153a.1510999334.git.arvind.yadav.cs@gmail.com>
References: <76d6a73ba51e1a8a86d8d9a1d0bbbf7723d5153a.1510999334.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, mcuos.com@gmail.com, linux@roeck-us.net, linux@armlinux.org.uk, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/input/misc/sirfsoc-onkey.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 4fd038d..de04b48 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -149,6 +149,9 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 	sirfsoc_pwrc_toggle_interrupts(pwrcdrv, false);
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq;
+
 	error = devm_request_irq(&pdev->dev, irq,
 				 sirfsoc_pwrc_isr, 0,
 				 "sirfsoc_pwrc_int", pwrcdrv);
-- 
2.7.4

