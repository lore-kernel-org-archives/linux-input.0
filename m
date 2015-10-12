From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: [PATCH v4 2/2] input: rotary encoder: Add wake up support
Date: Mon, 12 Oct 2015 21:13:32 +0200
Message-ID: <1444677212-9590-3-git-send-email-sylvain.rochet@finsecur.com>
References: <1444677212-9590-1-git-send-email-sylvain.rochet@finsecur.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:51938 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbbJLTNf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 15:13:35 -0400
In-Reply-To: <1444677212-9590-1-git-send-email-sylvain.rochet@finsecur.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sylvain Rochet <sylvain.rochet@finsecur.com>

This patch adds wake up support to GPIO rotary encoders.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/misc/rotary_encoder.c | 39 +++++++++++++++++++++++++++++++++++++
 include/linux/rotary_encoder.h      |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index f27f81e..0d86dc4 100644
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
@@ -280,6 +283,10 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		goto exit_free_irq_b;
 	}
 
+	device_set_wakeup_capable(&pdev->dev, true);
+	if (pdata->wakeup_source)
+		device_wakeup_enable(&pdev->dev);
+
 	platform_set_drvdata(pdev, encoder);
 
 	return 0;
@@ -306,6 +313,8 @@ static int rotary_encoder_remove(struct platform_device *pdev)
 	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
 	const struct rotary_encoder_platform_data *pdata = encoder->pdata;
 
+	device_init_wakeup(&pdev->dev, false);
+
 	free_irq(encoder->irq_a, encoder);
 	free_irq(encoder->irq_b, encoder);
 	gpio_free(pdata->gpio_a);
@@ -320,11 +329,41 @@ static int rotary_encoder_remove(struct platform_device *pdev)
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
2.5.1

