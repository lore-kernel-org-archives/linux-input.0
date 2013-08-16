From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 3/4] input: ti_tsc: Enable shared IRQ for TSC and add
 overrun, underflow checks
Date: Fri, 16 Aug 2013 11:14:09 +0200
Message-ID: <20130816091409.GC26895@linutronix.de>
References: <1376412499-21007-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376412499-21007-4-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376412499-21007-4-git-send-email-zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

* Zubair Lutfullah | 2013-08-13 17:48:18 [+0100]:

>Enable shared IRQ to allow ADC to share IRQ line from
>parent MFD core. Only FIFO0 IRQs are for TSC and handled
>on the TSC side.
>
>Patch also adds overrun and underflow irq handlers.
>
>Russ Dill (TI) worked on overrun and underflow handlers.
>Rachna Patil (TI) laid ground work for shared IRQ.
>
>Signed-off-by: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>---
> drivers/input/touchscreen/ti_am335x_tsc.c |   37 +++++++++++++++++++++++++----
> include/linux/mfd/ti_am335x_tscadc.h      |    2 ++
> 2 files changed, 34 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
>index 766bc7e..9c114b2 100644
>--- a/drivers/input/touchscreen/ti_am335x_tsc.c
>+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
>@@ -256,14 +256,39 @@ static irqreturn_t titsc_irq(int irq, void *dev)
> {
> 	struct titsc *ts_dev = dev;
> 	struct input_dev *input_dev = ts_dev->input;
>-	unsigned int status, irqclr = 0;
>+	unsigned int status, irqclr = 0, config = 0;
> 	unsigned int x = 0, y = 0;
> 	unsigned int z1, z2, z;
> 	unsigned int fsm;
> 
> 	status = titsc_readl(ts_dev, REG_IRQSTATUS);
>-	if (status & IRQENB_FIFO0THRES) {
>+	/*
>+	 * ADC and touchscreen share the IRQ line.
>+	 * FIFO1 threshold, FIFO1 Overrun and FIFO1 underflow
>+	 * interrupts are used by ADC. Handle FIFO0 IRQs here only
>+	 * and check if any IRQs left in case both fifos interrupt.
>+	 * If any irq left, return none, else return handled.
>+	 */
>+	if ((status & IRQENB_FIFO0OVRRUN) ||
>+			(status & IRQENB_FIFO0UNDRFLW)) {
>+
>+		config = titsc_readl(ts_dev, REG_CTRL);
>+		config &= ~(CNTRLREG_TSCSSENB);
>+		titsc_writel(ts_dev, REG_CTRL, config);
>+
>+		if (status & IRQENB_FIFO0UNDRFLW) {
>+			titsc_writel(ts_dev, REG_IRQSTATUS,
>+				(status | IRQENB_FIFO0UNDRFLW));
>+			irqclr |= IRQENB_FIFO0UNDRFLW;
>+		} else {
>+			titsc_writel(ts_dev, REG_IRQSTATUS,
>+				(status | IRQENB_FIFO0OVRRUN));
>+			irqclr |= IRQENB_FIFO0OVRRUN;
>+		}

You don't do anything on overflow / underflow. Is this due to the fact
once enabled for FIFO1 it also triggers for FIFO0?

>+		titsc_writel(ts_dev, REG_CTRL,
>+			(config | CNTRLREG_TSCSSENB));
>+	} else if (status & IRQENB_FIFO0THRES) {
> 		titsc_read_coordinates(ts_dev, &x, &y, &z1, &z2);
> 
> 		if (ts_dev->pen_down && z1 != 0 && z2 != 0) {
>@@ -317,9 +342,11 @@ static irqreturn_t titsc_irq(int irq, void *dev)
> 	}
> 
> 	if (irqclr) {
>-		titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
>+		titsc_writel(ts_dev, REG_IRQSTATUS, (status | irqclr));

Shouldn't FIFO1UNDRFLW & OVRRUN be handled by the adc driver? Why do you
or the unhandled bits as well here?

> 		am335x_tsc_se_set(ts_dev->mfd_tscadc, ts_dev->step_mask);
>-		return IRQ_HANDLED;
>+		status = titsc_readl(ts_dev, REG_IRQSTATUS);
>+		if (status == false)
>+			return IRQ_HANDLED;

And why this? If you something you handled it, if you didn't you return
NONE. Why does it depend on REG_IRQSTATUS?

> 	}
> 	return IRQ_NONE;
> }

Sebastian
