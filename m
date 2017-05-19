From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] input: axp20x-pek: Add wakeup support
Date: Fri, 19 May 2017 16:06:26 +0200
Message-ID: <20170519140626.31757-2-hdegoede@redhat.com>
References: <20170519140626.31757-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752010AbdESOGf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 10:06:35 -0400
In-Reply-To: <20170519140626.31757-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

At least on devices with the AXP288 PMIC the device is expected to
wakeup from suspend when the power-button gets pressed, add support
for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/axp20x-pek.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 3f1f9434eb9a..6b1998b2e436 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -253,6 +253,9 @@ static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
 		return error;
 	}
 
+	if (axp20x_pek->axp20x->variant == AXP288_ID)
+		enable_irq_wake(axp20x_pek->irq_dbr);
+
 	return 0;
 }
 
@@ -317,10 +320,35 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused axp20x_pek_resume_noirq(struct device *dev)
+{
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
+
+	if (axp20x_pek->axp20x->variant != AXP288_ID)
+		return 0;
+
+	/*
+	 * Clear interrupts from button presses during suspend, to avoid
+	 * a wakeup power-button press getting reported to userspace.
+	 */
+	regmap_write(axp20x_pek->axp20x->regmap,
+		     AXP20X_IRQ1_STATE + AXP288_IRQ_POKN / 8,
+		     BIT(AXP288_IRQ_POKN % 8));
+
+	return 0;
+}
+
+const struct dev_pm_ops axp20x_pek_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.resume_noirq = axp20x_pek_resume_noirq,
+#endif
+};
+
 static struct platform_driver axp20x_pek_driver = {
 	.probe		= axp20x_pek_probe,
 	.driver		= {
 		.name		= "axp20x-pek",
+		.pm		= &axp20x_pek_pm_ops,
 	},
 };
 module_platform_driver(axp20x_pek_driver);
-- 
2.12.2

