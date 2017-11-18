From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 10/10 v2] Input: palmas-pwrbutton: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 16:25:17 +0530
Message-ID: <cf9a8dd0a867bb4a9b151523435146f0fb9e2c06.1510999335.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44563 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424128AbdKRK4B (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 05:56:01 -0500
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

 drivers/input/misc/palmas-pwrbutton.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index 1e1baed..f9b05cf 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -210,6 +210,11 @@ static int palmas_pwron_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&pwron->input_work, palmas_power_button_work);
 
 	pwron->irq = platform_get_irq(pdev, 0);
+	if (pwron->irq <= 0) {
+		error = pwron->irq;
+		goto err_free_input;
+	}
+
 	error = request_threaded_irq(pwron->irq, NULL, pwron_irq,
 				     IRQF_TRIGGER_HIGH |
 					IRQF_TRIGGER_LOW |
-- 
2.7.4

