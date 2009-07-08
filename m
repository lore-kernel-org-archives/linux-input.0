From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] input:Add clk api support for w90p910 touchscreen
Date: Wed, 08 Jul 2009 13:22:56 +0800
Message-ID: <4A542D30.2040003@gmail.com>
References: <4A535B97.4010700@gmail.com> <5d5443650907071019w45474b2dhd0a175a0ffac4f3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:57099 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbZGHFXC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2009 01:23:02 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1661281rvb.1
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2009 22:23:02 -0700 (PDT)
In-Reply-To: <5d5443650907071019w45474b2dhd0a175a0ffac4f3a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Dear Trilok,

You are right, here should be put "NULL",thanks for your help.
Now, I fixed up my patch.

Add clk api support for w90p910 touchscreen.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 drivers/input/touchscreen/w90p910_ts.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index 6071f58..bf8dd52 100644
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
+	w90p910_ts->clk = clk_get(&pdev->dev, NULL);
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

B&R
Wan.

