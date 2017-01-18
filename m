From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 19/33] Input: tps65218-pwrbutton - Drop unnecessary call to platform_set_drvdata and other changes
Date: Wed, 18 Jan 2017 09:46:40 -0800
Message-ID: <1484761614-12225-20-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58944 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbdARRsz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 12:48:55 -0500
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>, Marcin Niestroj <m.niestroj@grinn-global.com>

There is no call to platform_get_drvdata() or dev_get_drvdata().
Drop the unnecessary call to platform_set_drvdata().
Other relevant changes:
  Use existing variable 'dev' instead of dereferencing it several times

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace 'goto l; ... l: return e;' with 'return e;'
- Drop platform_set_drvdata()
- Use local variable 'struct device *dev' consistently

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/tps65218-pwrbutton.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
index cc74a41bdb0d..33f48a622fc6 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -70,7 +70,7 @@ static irqreturn_t tps6521x_pb_irq(int irq, void *_pwr)
 	error = regmap_read(pwr->regmap, tps_data->reg_status, &reg);
 	if (error) {
 		dev_err(pwr->dev, "can't read register: %d\n", error);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	if (reg & tps_data->pb_mask) {
@@ -82,7 +82,6 @@ static irqreturn_t tps6521x_pb_irq(int irq, void *_pwr)
 
 	input_sync(pwr->idev);
 
-out:
 	return IRQ_HANDLED;
 }
 
@@ -95,7 +94,7 @@ static int tps6521x_pb_probe(struct platform_device *pdev)
 	int error;
 	int irq;
 
-	match = of_match_node(of_tps6521x_pb_match, pdev->dev.of_node);
+	match = of_match_node(of_tps6521x_pb_match, dev->of_node);
 	if (!match)
 		return -ENXIO;
 
@@ -118,10 +117,9 @@ static int tps6521x_pb_probe(struct platform_device *pdev)
 
 	input_set_capability(idev, EV_KEY, KEY_POWER);
 
-	pwr->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	pwr->regmap = dev_get_regmap(dev->parent, NULL);
 	pwr->dev = dev;
 	pwr->idev = idev;
-	platform_set_drvdata(pdev, pwr);
 	device_init_wakeup(dev, true);
 
 	irq = platform_get_irq(pdev, 0);
@@ -136,8 +134,7 @@ static int tps6521x_pb_probe(struct platform_device *pdev)
 						IRQF_ONESHOT,
 					  pwr->data->name, pwr);
 	if (error) {
-		dev_err(dev, "failed to request IRQ #%d: %d\n",
-			irq, error);
+		dev_err(dev, "failed to request IRQ #%d: %d\n", irq, error);
 		return error;
 	}
 
-- 
2.7.4

