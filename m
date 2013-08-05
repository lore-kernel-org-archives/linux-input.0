From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] input: ti_tsc: Enable shared IRQ for TSC
Date: Mon, 5 Aug 2013 18:02:02 +0100
Message-ID: <20130805170201.GA4310@gmail.com>
References: <1374882674-18403-1-git-send-email-zubair.lutfullah@gmail.com>
 <1374882674-18403-2-git-send-email-zubair.lutfullah@gmail.com>
 <51FE361B.5030900@kernel.org>
 <20130805161256.GA8794@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130805161256.GA8794-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 05, 2013 at 09:12:56AM -0700, Dmitry Torokhov wrote:
> > > Touchscreen and ADC share the same IRQ line from parent MFD core.
> > > Previously only Touchscreen was interrupt based.
> > > With continuous mode support added in ADC driver, driver requires
> > > interrupt to process the ADC samples, so enable shared IRQ flag bit for
> > > touchscreen.
> > > 
> > > @@ -260,8 +260,18 @@ static irqreturn_t titsc_irq(int irq, void *dev)
> > >  	unsigned int fsm;
> > >  
> > > +	/*
> > > +	 * ADC and touchscreen share the IRQ line.
> > > +	 * FIFO1 threshold, FIFO1 Overrun and FIFO1 underflow
> > > +	 * interrupts are used by ADC,
> > > +	 * hence return from touchscreen IRQ handler if FIFO1
> > > +	 * related interrupts occurred.
> > > +	 */
> > > +	if ((status & IRQENB_FIFO1THRES) ||
> > > +			(status & IRQENB_FIFO1OVRRUN) ||
> > > +			(status & IRQENB_FIFO1UNDRFLW))
> > > +		return IRQ_NONE;
> > > +	else if (status & IRQENB_FIFO0THRES) {
> 
> What happens if both parts have data at the same time? Can both
> IRQENB_FIFO1THRES and IRQENB_FIFO0THRES be signalled? What will happen
> in this case?

If ADC is sampling and someone is touching the TSC, both interrupts
can signal so closely that for the purpose of the kernel,
they can be seen as signaled together.

FIFO 1 used only by ADC and FIFO1THRES handler is inside the iio/adc driver
FIFO 0 used only by TSC and FIFO0THRES handler is inside the input/touchscreen

Note: These are level interrupts.

I would like some input on how to handle such a situation. 

Thanks
Zubair Lutfullah
