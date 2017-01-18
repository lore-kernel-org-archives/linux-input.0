From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 13/33] Input: bfin_rotary - Use 'dev' instead of dereferencing it and other changes
Date: Wed, 18 Jan 2017 09:46:34 -0800
Message-ID: <1484761614-12225-14-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58939 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbdARRsy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 12:48:54 -0500
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Use local variable 'dev' instead of dereferencing it several times.
Other relevant changes:
  Replace devm_add_action() with devm_add_action_or_reset()

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace devm_add_action() followed by failure action with
  devm_add_action_or_reset()
- Drop unnecessary braces around conditional return statements
- Use local variable 'struct device *dev' consistently

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/bfin_rotary.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index a0fc18fdfc0c..9f5790c6e06b 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -141,25 +141,23 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 
 	/* Basic validation */
 	if ((pdata->rotary_up_key && !pdata->rotary_down_key) ||
-	    (!pdata->rotary_up_key && pdata->rotary_down_key)) {
+	    (!pdata->rotary_up_key && pdata->rotary_down_key))
 		return -EINVAL;
-	}
 
 	if (pdata->pin_list) {
 		error = peripheral_request_list(pdata->pin_list,
-						dev_name(&pdev->dev));
+						dev_name(dev));
 		if (error) {
 			dev_err(dev, "requesting peripherals failed: %d\n",
 				error);
 			return error;
 		}
 
-		error = devm_add_action(dev, bfin_rotary_free_action,
-					pdata->pin_list);
+		error = devm_add_action_or_reset(dev, bfin_rotary_free_action,
+						 pdata->pin_list);
 		if (error) {
 			dev_err(dev, "setting cleanup action failed: %d\n",
 				error);
-			peripheral_free_list(pdata->pin_list);
 			return error;
 		}
 	}
@@ -189,7 +187,7 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 
 	input->name = pdev->name;
 	input->phys = "bfin-rotary/input0";
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = dev;
 
 	input_set_drvdata(input, rotary);
 
@@ -224,8 +222,8 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	error = devm_request_irq(dev, rotary->irq, bfin_rotary_isr,
-				 0, dev_name(dev), rotary);
+	error = devm_request_irq(dev, rotary->irq, bfin_rotary_isr, 0,
+				 dev_name(dev), rotary);
 	if (error) {
 		dev_err(dev, "unable to claim irq %d; error %d\n",
 			rotary->irq, error);
@@ -239,7 +237,7 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, rotary);
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(dev, 1);
 
 	return 0;
 }
-- 
2.7.4

