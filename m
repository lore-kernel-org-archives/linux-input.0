From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: [PATCHv2] input: rotary encoder: Add wake up support
Date: Thu, 29 Jan 2015 12:10:18 +0100
Message-ID: <1422529818-6140-2-git-send-email-sylvain.rochet@finsecur.com>
References: <1422529818-6140-1-git-send-email-sylvain.rochet@finsecur.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:57466 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbbA2LKX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 06:10:23 -0500
In-Reply-To: <1422529818-6140-1-git-send-email-sylvain.rochet@finsecur.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sylvain Rochet <sylvain.rochet@finsecur.com>

This patch add wake up support for rotary encoders.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
 Documentation/input/rotary-encoder.txt             |  1 +
 drivers/input/misc/rotary_encoder.c                | 37 ++++++++++++++++++++++
 include/linux/rotary_encoder.h                     |  1 +
 4 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index 3315495..2c643a3 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -15,6 +15,7 @@ Optional properties:
 - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
   greater than the specified steps or smaller than 0. For absolute axis only.
 - rotary-encoder,half-period: Makes the driver work on half-period mode.
+- wakeup-source: Boolean, rotary encoder can wake-up the system.
 
 See Documentation/input/rotary-encoder.txt for more information.
 
diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
index 92e68bc..ed158d3 100644
--- a/Documentation/input/rotary-encoder.txt
+++ b/Documentation/input/rotary-encoder.txt
@@ -109,6 +109,7 @@ static struct rotary_encoder_platform_data my_rotary_encoder_info = {
 	.inverted_a	= 0,
 	.inverted_b	= 0,
 	.half_period	= false,
+	.wakeup_source	= false,
 };
 
 static struct platform_device rotary_encoder_device = {
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index f27f81e..79a94cb 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -26,6 +26,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
+#include <linux/pm.h>
 
 #define DRV_NAME "rotary-encoder"
 
@@ -180,6 +181,8 @@ static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(struct devic
 					"rotary-encoder,rollover", NULL);
 	pdata->half_period = !!of_get_property(np,
 					"rotary-encoder,half-period", NULL);
+	pdata->wakeup_source = !!of_get_property(np,
+					"wakeup-source", NULL);
 
 	return pdata;
 }
@@ -280,6 +283,8 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		goto exit_free_irq_b;
 	}
 
+	device_init_wakeup(&pdev->dev, pdata->wakeup_source);
+
 	platform_set_drvdata(pdev, encoder);
 
 	return 0;
@@ -306,6 +311,8 @@ static int rotary_encoder_remove(struct platform_device *pdev)
 	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
 	const struct rotary_encoder_platform_data *pdata = encoder->pdata;
 
+	device_init_wakeup(&pdev->dev, 0);
+
 	free_irq(encoder->irq_a, encoder);
 	free_irq(encoder->irq_b, encoder);
 	gpio_free(pdata->gpio_a);
@@ -320,11 +327,41 @@ static int rotary_encoder_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int rotary_encoder_suspend(struct device *dev)
+{
+	struct rotary_encoder *encoder = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(encoder->irq_a);
+		enable_irq_wake(encoder->irq_b);
+	}
+
+	return 0;
+}
+
+static int rotary_encoder_resume(struct device *dev)
+{
+	struct rotary_encoder *encoder = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev)) {
+		disable_irq_wake(encoder->irq_a);
+		disable_irq_wake(encoder->irq_b);
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(rotary_encoder_pm_ops,
+		 rotary_encoder_suspend, rotary_encoder_resume);
+
 static struct platform_driver rotary_encoder_driver = {
 	.probe		= rotary_encoder_probe,
 	.remove		= rotary_encoder_remove,
 	.driver		= {
 		.name	= DRV_NAME,
+		.pm	= &rotary_encoder_pm_ops,
 		.of_match_table = of_match_ptr(rotary_encoder_of_match),
 	}
 };
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
index 3f594dc..b33f2d2 100644
--- a/include/linux/rotary_encoder.h
+++ b/include/linux/rotary_encoder.h
@@ -11,6 +11,7 @@ struct rotary_encoder_platform_data {
 	bool relative_axis;
 	bool rollover;
 	bool half_period;
+	bool wakeup_source;
 };
 
 #endif /* __ROTARY_ENCODER_H__ */
-- 
2.1.4

