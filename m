From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Sun, 4 Aug 2013 14:11:10 +0100
Message-ID: <20130804131109.GA30541@gmail.com>
References: <1374882674-18403-1-git-send-email-zubair.lutfullah@gmail.com>
 <1374882674-18403-3-git-send-email-zubair.lutfullah@gmail.com>
 <51FE357C.2040401@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51FE357C.2040401-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Aug 04, 2013 at 12:05:32PM +0100, Jonathan Cameron wrote:
> I'm afraid the tree has moved on a bit so this will need rebasing
> against what is currently in iio.git.

The patches apply on top of fixes-to greg branch because of a recent fix
in there. Which branch should I rebase them on?

Also, I've squashed a few more bug fixes I have found since then. 
Will update accordingly next time I send.

> 
> I would like a description in here of what form of buffered sampling the
> driver/device provides.  Does it run on it's own internal clock?  E.g.
> are we dealing with a fairly autonomous device with a data ready trigger?
> Is the driver to always be driven from an external trigger?
> This looks like there is no explicit trigger at all (which is an unusual
> case).  I vaguely remember discussing this before and concluding it was
> probably valid for this device (as it is a hardware fifo pushed into a software
> one).  If nothing else generic_buffer.c won't cover this case so might need
> appropriately updating with a 'don't bother with an explicit trigger' option.
> 
> Having this stuff in the git commit log would be good as well as available
> at time of review.  It's also usually best to assume everyone has forgotten
> everything about the driver inbetween reviews ;)
> 
> Nearly there.
> 
> Jonathan
> 

The trigger here is simply to give certain functionality like an oscilloscope 
trigger. The control is given to the userspace application via IIO triggers 
(so sysfs/gpio/timer etc can be used)

A buffer of samples is read on one trigger.

An alternative would be the buffer being sampled and read as soon as the 
buffer is enabled. Which would lead to a buffer enable/disable if another 
buffer is to be read.

This is NOT a data ready trigger like in spi adcs.

The TSCADC module is inside the processor. Hardware FIFO interrupts and handler
reads samples from fifo and pushes to software FIFO.

At the moment, I use sysfs triggers to check this.
I'm still not sure on how to connect the gpio trigger driver by IIO.

generic_buffer.c reads the samples with a simple sysfs trigger.

So.
Additional description in the git log only?

I'll add following in log message.
"Any IIO trigger can be used to trigger driver to read a buffer
of samples from enabled channels."

Responses on comments on actual code is inline below.

Thanks
Zubair Lutfullah

> > +++ b/drivers/iio/adc/ti_am335x_adc.c
> > @@ -26,14 +26,25 @@
> >  #include <linux/of_device.h>
> >  #include <linux/iio/machine.h>
> Err, what is the machine header doing in here?
> (clearly my review of the original driver missed a few
> things).
I have no idea. 
Old stuff. I'll remove and see if it changes anything..
> 

> >  #include <linux/iio/driver.h>
> > -
> Cleaner to group the headers appropriately.
Ok

> > @@ -251,6 +451,10 @@ static int tiadc_probe(struct platform_device *pdev)
> >
> >  	return 0;
> >
> The error handling in this function is thoroughly scrambled up. Please review
> it and fix it.
Sure.
> 
> > +err_unregister:
> This label is too generic to make for easy review.
Ok.


> > +++ b/include/linux/mfd/ti_am335x_tscadc.h
> 
> Clearly you are working in keeping with the current driver
> but these defines could really do with appropriate prefixes
> to make them more specific to the driver.  You are almost
> certain that one of these will turn up in a general header
> at some point.
>
I understand your point.
But this header is common and affects mfd, input and iio.
Changing all of them now is going to be a massive(impossible) pain..

And adding new defines should conform to the naming of the previous.

What should I do?
> > @@ -46,17 +46,23 @@
> >  /* Step Enable */
> >  #define STEPENB_MASK		(0x1FFFF << 0)
> >  #define STEPENB(val)		((val) << 0)
> > +#define ENB(val)			(1 << (val))
> > +#define STPENB_STEPENB		STEPENB(0x1FFFF)
> > +#define STPENB_STEPENB_TC	STEPENB(0x1FFF)
> >
