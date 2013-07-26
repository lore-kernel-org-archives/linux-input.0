From: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] input: ti_tsc: Enable shared IRQ for TSC
Date: Sat, 27 Jul 2013 00:51:13 +0100
Message-ID: <1374882674-18403-2-git-send-email-zubair.lutfullah@gmail.com>
References: <1374882674-18403-1-git-send-email-zubair.lutfullah@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374882674-18403-1-git-send-email-zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>

Touchscreen and ADC share the same IRQ line from parent MFD core.
Previously only Touchscreen was interrupt based.
With continuous mode support added in ADC driver, driver requires
interrupt to process the ADC samples, so enable shared IRQ flag bit for
touchscreen.

Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
Acked-by: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Signed-off-by: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index e1c5300..68d1250 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -260,8 +260,18 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	unsigned int fsm;
 
 	status = titsc_readl(ts_dev, REG_IRQSTATUS);
-	if (status & IRQENB_FIFO0THRES) {
-
+	/*
+	 * ADC and touchscreen share the IRQ line.
+	 * FIFO1 threshold, FIFO1 Overrun and FIFO1 underflow
+	 * interrupts are used by ADC,
+	 * hence return from touchscreen IRQ handler if FIFO1
+	 * related interrupts occurred.
+	 */
+	if ((status & IRQENB_FIFO1THRES) ||
+			(status & IRQENB_FIFO1OVRRUN) ||
+			(status & IRQENB_FIFO1UNDRFLW))
+		return IRQ_NONE;
+	else if (status & IRQENB_FIFO0THRES) {
 		titsc_read_coordinates(ts_dev, &x, &y, &z1, &z2);
 
 		if (ts_dev->pen_down && z1 != 0 && z2 != 0) {
@@ -315,7 +325,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	}
 
 	if (irqclr) {
-		titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
+		titsc_writel(ts_dev, REG_IRQSTATUS, (status | irqclr));
 		am335x_tsc_se_update(ts_dev->mfd_tscadc);
 		return IRQ_HANDLED;
 	}
@@ -389,7 +399,7 @@ static int titsc_probe(struct platform_device *pdev)
 	}
 
 	err = request_irq(ts_dev->irq, titsc_irq,
-			  0, pdev->dev.driver->name, ts_dev);
+			  IRQF_SHARED, pdev->dev.driver->name, ts_dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to allocate irq.\n");
 		goto err_free_mem;
-- 
1.7.9.5
