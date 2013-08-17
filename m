From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Sat, 17 Aug 2013 09:58:25 +0100
Message-ID: <20130817085824.GA5090@gmail.com>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
 <520CBEC6.8010400@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <520CBEC6.8010400-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Aug 15, 2013 at 12:43:02PM +0100, Jonathan Cameron wrote:
> Note I'd also like a much more detailed description in the patch header.
> 
> I would also expect an option for the trigger to be supplied from the
> chip itself based on fifo watershead interrupts.  Thus the adc could be
> operated at full rate without losing data.  As you described in a previous
> email this is much more similar to a one shot osciloscope trigger where it
> grabs the next set of readings.  Now this is an interesting option, but
> it isn't the standard one for IIO.  I'd be interested to see a proposal
> for adding this functionality to the core in a more general fashion.

When I read trigger, this functionality is what comes to my mind.
Not the single scan current implementation in IIO. My background I guess.

Adding this feature to the core feels a bit above my level at the moment.
I'd like to get this driver sorted first.
> 
> For now I'd be much happier if this driver conformed to more or less the
> standard form with the one exception being that the 'trigger' is based on
> the fifo threshold and so it might appear to grab multiple scans of the
> enabled channels for each trigger (which is fine). Even if we provide the
> functionality sketched out above, it would still be as core functionality, not
> in the driver as you have done here.
> 
> Jonathan

Will that affect the way generic_buffer.c will read from the driver?

Rest comments below.

> > diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> > +	/* FIFO Overrun. Clear flag. Disable/Enable ADC to recover */
> > +	if (status & IRQENB_FIFO1OVRRUN) {
> > +		config = tiadc_readl(adc_dev, REG_CTRL);
> > +		config &= ~(CNTRLREG_TSCSSENB);
> > +		tiadc_writel(adc_dev, REG_CTRL, config);
> > +		tiadc_writel(adc_dev, REG_IRQSTATUS, IRQENB_FIFO1OVRRUN |
> > +				IRQENB_FIFO1UNDRFLW | IRQENB_FIFO1THRES);
> > +		tiadc_writel(adc_dev, REG_CTRL, (config | CNTRLREG_TSCSSENB));
> > +	} else if (status & IRQENB_FIFO1THRES) {
> 
> I'd normally expect this interrupt to drive a trigger that in turn results in
> the data being dumped into the software buffers.
> 
The work handler is sort of providing similar functionality..
But, I guess using the trigger ABI is more efficient.
> > +
> > +	tiadc_writel(adc_dev,  REG_IRQSTATUS, IRQENB_FIFO1THRES |
> > +			 IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW);
> > +	tiadc_writel(adc_dev,  REG_IRQENABLE, IRQENB_FIFO1THRES
> > +				| IRQENB_FIFO1OVRRUN);
> > +
> > +	iio_trigger_notify_done(indio_dev->trig);
> Are you actually done?  What happens if another trigger turns up in the
> meantime?  I'd expect this to occur only after the results of the trigger
> have been handled.

Indeed Done is passed immediately while ADC is still sampling.
Because of the way the trigger was used and structure of the driver.

> > +static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> Don't have pointless wrappers like this.

Noted
> > +	return iio_sw_buffer_preenable(indio_dev);
> > +}
> > +
> > +static void tiadc_adc_work(struct work_struct *work_s)
> > +{
> > +	struct tiadc_device *adc_dev =
> > +		container_of(work_s, struct tiadc_device, poll_work);
> > +	struct iio_dev *indio_dev = iio_priv_to_dev(adc_dev);
> > +	struct iio_buffer *buffer = indio_dev->buffer;
> > +	int i, j, k, fifo1count, read;
> > +	unsigned int config;
> So normally we'd just fill with one sample hence for this case
> I'd expect to push out whatever samples are in the fifo right now
> then return.  The next trigger would grab the next lot etc.
>
Again. If I understand correctly, 

I restructure the driver so that
enabling the buffer via userspace starts sampling the ADC channels.
Preenable/postenable do all that hard work.

I need to use iio_trigger_register to create an IIO trigger inside the
driver.

The IRQ handler for FIFO Threshold causes a trigger event.

The trigger handler pushes the entire fifo to userspace.

I'd like a small ACK before I get to work.
Just to make sure I got things correctly.

Thanks for the input
Zubair
