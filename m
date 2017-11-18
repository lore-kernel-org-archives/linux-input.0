From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 04/10 v3] Input: serio: Fix platform_get_irq's error checking
Date: Sat, 18 Nov 2017 16:25:11 +0530
Message-ID: <8104ffc3b7bedee525c0cba9144cedaf04087fd4.1510999558.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, mcuos.com@gmail.com, linux@roeck-us.net, linux@armlinux.org.uk, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              irq is unsigned. used struct sun4i_ps2data int variable drvdata->irq.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/input/serio/sun4i-ps2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/sun4i-ps2.c b/drivers/input/serio/sun4i-ps2.c
index 04b96fe..38bb163 100644
--- a/drivers/input/serio/sun4i-ps2.c
+++ b/drivers/input/serio/sun4i-ps2.c
@@ -210,7 +210,6 @@ static int sun4i_ps2_probe(struct platform_device *pdev)
 	struct sun4i_ps2data *drvdata;
 	struct serio *serio;
 	struct device *dev = &pdev->dev;
-	unsigned int irq;
 	int error;
 
 	drvdata = kzalloc(sizeof(struct sun4i_ps2data), GFP_KERNEL);
@@ -263,14 +262,13 @@ static int sun4i_ps2_probe(struct platform_device *pdev)
 	writel(0, drvdata->reg_base + PS2_REG_GCTL);
 
 	/* Get IRQ for the device */
-	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
+	drvdata->irq = platform_get_irq(pdev, 0);
+	if (drvdata->irq <= 0) {
 		dev_err(dev, "no IRQ found\n");
-		error = -ENXIO;
+		error = drvdata->irq;
 		goto err_disable_clk;
 	}
 
-	drvdata->irq = irq;
 	drvdata->serio = serio;
 	drvdata->dev = dev;
 
-- 
2.7.4
