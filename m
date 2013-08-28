From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 1/2] input: ti_am335x_tsc: Enable shared IRQ for TSC
Date: Wed, 28 Aug 2013 12:42:11 +0200
Message-ID: <20130828104211.GB14111@linutronix.de>
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com>
 <1377470724-15710-2-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377470724-15710-2-git-send-email-zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

* Zubair Lutfullah | 2013-08-25 23:45:23 [+0100]:

>diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
>index e1c5300..4124e580 100644
>--- a/drivers/input/touchscreen/ti_am335x_tsc.c
>+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
>@@ -315,11 +321,17 @@ static irqreturn_t titsc_irq(int irq, void *dev)
> 	}
> 
> 	if (irqclr) {
>-		titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
>-		am335x_tsc_se_update(ts_dev->mfd_tscadc);
>-		return IRQ_HANDLED;
>+		titsc_writel(ts_dev, REG_IRQSTATUS, (status | irqclr));
>+		am335x_tsc_se_set(ts_dev->mfd_tscadc, ts_dev->step_mask);
> 	}
>-	return IRQ_NONE;
>+
>+	/* If any IRQ flags left, return none. So ADC can handle its IRQs */
>+	status = titsc_readl(ts_dev, REG_IRQSTATUS);
>+	if (status == false)
>+		return IRQ_HANDLED;
>+	else
>+		return IRQ_NONE;

If I understand this correctly you return IRQ_NONE the TSC interrupt has
been handled and no ADC interrupt is outstanding.
This is bad because if you received 1k _only_ TSC interrupts you return
always IRQ_NONE and the irq-core will disable the interrupt line. You
don't want this.

Now, if you handle an interrupt at the TSC level and return IRQ_HANDLED
then the second handler, the ADC in your case, is also invoked.
So you can drop this and return IRQ_HANDLED if you *did* something here
and NONE if didn't do anything.

Basides that, I'm fine with it.

>+
> }

Sebastian
