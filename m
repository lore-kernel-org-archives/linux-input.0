From: Sebastian Reichel <sre@debian.org>
Subject: [PATCHv7 4/4] Input: twl4030-pwrbutton: simplify driver using devm_*
Date: Fri,  8 Nov 2013 23:11:27 +0100
Message-ID: <1383948687-32279-5-git-send-email-sre@debian.org>
References: <1383948687-32279-1-git-send-email-sre@debian.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1383948687-32279-1-git-send-email-sre@debian.org>
Sender: linux-doc-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-input@vger.kernel.org

Use managed irq resource to simplify the driver.

Signed-off-by: Sebastian Reichel <sre@debian.org>
Reviewed-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/input/misc/twl4030-pwrbutton.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index 48639ff..be1759c 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -58,7 +58,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 	int irq = platform_get_irq(pdev, 0);
 	int err;
 
-	pwr = input_allocate_device();
+	pwr = devm_input_allocate_device(&pdev->dev);
 	if (!pwr) {
 		dev_dbg(&pdev->dev, "Can't allocate power button\n");
 		return -ENOMEM;
@@ -70,40 +70,23 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 	pwr->phys = "twl4030_pwrbutton/input0";
 	pwr->dev.parent = &pdev->dev;
 
-	err = request_threaded_irq(irq, NULL, powerbutton_irq,
+	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			"twl4030_pwrbutton", pwr);
 	if (err < 0) {
 		dev_err(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
-		goto free_input_dev;
+		return err;
 	}
 
 	err = input_register_device(pwr);
 	if (err) {
 		dev_err(&pdev->dev, "Can't register power button: %d\n", err);
-		goto free_irq;
+		return err;
 	}
 
 	platform_set_drvdata(pdev, pwr);
 
 	return 0;
-
-free_irq:
-	free_irq(irq, pwr);
-free_input_dev:
-	input_free_device(pwr);
-	return err;
-}
-
-static int __exit twl4030_pwrbutton_remove(struct platform_device *pdev)
-{
-	struct input_dev *pwr = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
-
-	free_irq(irq, pwr);
-	input_unregister_device(pwr);
-
-	return 0;
 }
 
 #if IS_ENABLED(CONFIG_OF)
@@ -116,7 +99,6 @@ MODULE_DEVICE_TABLE(of, twl4030_pwrbutton_dt_match_table);
 
 static struct platform_driver twl4030_pwrbutton_driver = {
 	.probe		= twl4030_pwrbutton_probe,
-	.remove		= __exit_p(twl4030_pwrbutton_remove),
 	.driver		= {
 		.name	= "twl4030_pwrbutton",
 		.owner	= THIS_MODULE,
-- 
1.8.4.rc3

