From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 08/10 v3] Input: twl4030-pwrbutton: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 16:25:15 +0530
Message-ID: <bed6484b6919f26e7119934a33b6f9b1e94de3c9.1510999334.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38184 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422816AbdKRKzy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 05:55:54 -0500
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
              return irq instead of -ENODEV.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/input/misc/twl4030-pwrbutton.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index b307cca..0dcf311 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -58,6 +58,9 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 	int irq = platform_get_irq(pdev, 0);
 	int err;
 
+	if (irq <= 0)
+		return irq;
+
 	pwr = devm_input_allocate_device(&pdev->dev);
 	if (!pwr) {
 		dev_err(&pdev->dev, "Can't allocate power button\n");
-- 
2.7.4

