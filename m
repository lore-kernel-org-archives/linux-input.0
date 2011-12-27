From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] Input: samsung-keypad - Set up driver data prior to registering
Date: Tue, 27 Dec 2011 17:18:27 +0000
Message-ID: <1325006308-21149-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47131 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129Ab1L0RSe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Dec 2011 12:18:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

As soon as we register the platform device we may be opened and hence
interrupted, meaning that we need to have the driver data set up for the
interrupt handler to use. Move registration of the input device after the
driver data is set up, also moving the wakeup setup for future changes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/keyboard/samsung-keypad.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index aa936ee..1aacf07 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -467,13 +467,13 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
 		goto err_put_clk;
 	}
 
+	device_init_wakeup(&pdev->dev, pdata->wakeup);
+	platform_set_drvdata(pdev, keypad);
+
 	error = input_register_device(keypad->input_dev);
 	if (error)
 		goto err_free_irq;
 
-	device_init_wakeup(&pdev->dev, pdata->wakeup);
-	platform_set_drvdata(pdev, keypad);
-
 	if (pdev->dev.of_node) {
 		devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
 		devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
-- 
1.7.7.3

