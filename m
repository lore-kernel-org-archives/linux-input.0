From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] input:Add clk api support for w90p910 touchscreen
Date: Wed, 08 Jul 2009 15:10:21 +0800
Message-ID: <4A54465D.1020105@gmail.com>
References: <4A535B97.4010700@gmail.com> <5d5443650907071019w45474b2dhd0a175a0ffac4f3a@mail.gmail.com> <4A542D30.2040003@gmail.com> <20090708065130.GD3309@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:53745 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbZGHHKh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2009 03:10:37 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1678495rvb.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2009 00:10:37 -0700 (PDT)
In-Reply-To: <20090708065130.GD3309@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Dear Dmitry,

Okay, this clocken should be removed here.
I fixed up my patch and re-submitted it.
thanks a lot for your help.

Add clk api support for w90p910 touchscreen.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 drivers/input/touchscreen/w90p910_ts.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index 6071f58..7bef19e 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 
@@ -47,8 +48,8 @@ enum ts_state {
 struct w90p910_ts {
 	struct input_dev *input;
 	struct timer_list timer;
+	struct clk *clk;
 	int irq_num;
-	void __iomem *clocken;
 	void __iomem *ts_reg;
 	spinlock_t lock;
 	enum ts_state state;
@@ -166,8 +167,7 @@ static int w90p910_open(struct input_dev *dev)
 	unsigned long val;
 
 	/* enable the ADC clock */
-	val = __raw_readl(w90p910_ts->clocken);
-	__raw_writel(val | ADC_CLK_EN, w90p910_ts->clocken);
+	clk_enable(w90p910_ts->clk);
 
 	__raw_writel(ADC_RST1, w90p910_ts->ts_reg);
 	msleep(1);
@@ -211,8 +211,8 @@ static void w90p910_close(struct input_dev *dev)
 	del_timer_sync(&w90p910_ts->timer);
 
 	/* stop the ADC clock */
-	val = __raw_readl(w90p910_ts->clocken);
-	__raw_writel(val & ~ADC_CLK_EN, w90p910_ts->clocken);
+	clk_disable(w90p910_ts->clk);
+	clk_put(w90p910_ts->clk);
 }
 
 static int __devinit w90x900ts_probe(struct platform_device *pdev)
@@ -253,14 +253,12 @@ static int __devinit w90x900ts_probe(struct platform_device *pdev)
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
 
-	w90p910_ts->clocken = (void __iomem *)res->start;
-
 	input_dev->name = "W90P910 TouchScreen";
 	input_dev->phys = "w90p910ts/event0";
 	input_dev->id.bustype = BUS_HOST;
@@ -283,18 +281,19 @@ static int __devinit w90x900ts_probe(struct platform_device *pdev)
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
