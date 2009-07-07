From: Wan ZongShun <mcuos.com@gmail.com>
Subject: [PATCH] input:Add clk api support for w90p910 touchscreen
Date: Tue, 07 Jul 2009 22:28:39 +0800
Message-ID: <4A535B97.4010700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:34666 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbZGGO2w (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2009 10:28:52 -0400
Received: by pxi28 with SMTP id 28so4267316pxi.33
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2009 07:28:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Dear Dmitry,

Now,the w90p910 clock API has been submitted to "linux-arm-kernel",so using it for w90p910 touchscreen driver.Thanks!


Add clk api support for w90p910 touchscreen.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 drivers/input/touchscreen/w90p910_ts.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index 6071f58..4a42d66 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 
@@ -47,6 +48,7 @@ enum ts_state {
 struct w90p910_ts {
 	struct input_dev *input;
 	struct timer_list timer;
+	struct clk *clk;
 	int irq_num;
 	void __iomem *clocken;
 	void __iomem *ts_reg;
@@ -166,8 +168,7 @@ static int w90p910_open(struct input_dev *dev)
 	unsigned long val;
 
 	/* enable the ADC clock */
-	val = __raw_readl(w90p910_ts->clocken);
-	__raw_writel(val | ADC_CLK_EN, w90p910_ts->clocken);
+	clk_enable(w90p910_ts->clk);
 
 	__raw_writel(ADC_RST1, w90p910_ts->ts_reg);
 	msleep(1);
@@ -211,8 +212,8 @@ static void w90p910_close(struct input_dev *dev)
 	del_timer_sync(&w90p910_ts->timer);
 
 	/* stop the ADC clock */
-	val = __raw_readl(w90p910_ts->clocken);
-	__raw_writel(val & ~ADC_CLK_EN, w90p910_ts->clocken);
+	clk_disable(w90p910_ts->clk);
+	clk_put(w90p910_ts->clk);
 }
 
 static int __devinit w90x900ts_probe(struct platform_device *pdev)
@@ -253,9 +254,9 @@ static int __devinit w90x900ts_probe(struct platform_device *pdev)
 		goto fail2;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res) {
-		err = -ENXIO;
+	w90p910_ts->clk = clk_get(&pdev->dev, pdev->name);
+	if (IS_ERR(w90p910_ts->clk)) {
+		err = PTR_ERR(w90p910_ts->clk);
 		goto fail3;
 	}
 
@@ -283,18 +284,19 @@ static int __devinit w90x900ts_probe(struct platform_device *pdev)
 	if (request_irq(w90p910_ts->irq_num, w90p910_ts_interrupt,
 			IRQF_DISABLED, "w90p910ts", w90p910_ts)) {
 		err = -EBUSY;
-		goto fail3;
+		goto fail4;
 	}
 
 	err = input_register_device(w90p910_ts->input);
 	if (err)
-		goto fail4;
+		goto fail5;
 
 	platform_set_drvdata(pdev, w90p910_ts);
 
 	return 0;
 
-fail4:	free_irq(w90p910_ts->irq_num, w90p910_ts);
+fail5:	free_irq(w90p910_ts->irq_num, w90p910_ts);
+fail4:	clk_put(w90p910_ts->clk);
 fail3:	iounmap(w90p910_ts->ts_reg);
 fail2:	release_mem_region(res->start, res->end - res->start + 1);
 fail1:	input_free_device(input_dev);
-- 
1.5.6.3
