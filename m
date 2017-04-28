From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 1/2] Input: twl4030-pwrbutton: use correct device for irq request
Date: Fri, 28 Apr 2017 14:28:54 +0200
Message-ID: <20170428122855.3185-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52197 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425828AbdD1M3C (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 08:29:02 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>

The interrupt should be requested for the platform device
and not for the input device.

Fixes: 7f9ce649d267 ("Input: twl4030-pwrbutton - simplify driver using devm_*")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/input/misc/twl4030-pwrbutton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index 54162d2cbcfc..7c4504c31b07 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -70,7 +70,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 	pwr->phys = "twl4030_pwrbutton/input0";
 	pwr->dev.parent = &pdev->dev;
 
-	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
 			IRQF_ONESHOT,
 			"twl4030_pwrbutton", pwr);
-- 
2.11.0

