From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] input: axp20x-pek: Add wakeup support
Date: Mon, 17 Apr 2017 22:13:32 +0200
Message-ID: <20170417201332.13983-4-hdegoede@redhat.com>
References: <20170417201332.13983-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752462AbdDQUNi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Apr 2017 16:13:38 -0400
In-Reply-To: <20170417201332.13983-1-hdegoede@redhat.com>
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
index be50a7f..5b37a3a 100644
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
 
@@ -319,10 +322,35 @@ static int axp20x_pek_probe(struct platform_device *pdev)
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
2.9.3

