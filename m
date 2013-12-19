From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] mfd: input: iio: ti_amm335x: Rework TSC/ADC
 synchronization
Date: Fri, 20 Dec 2013 00:01:31 +0500
Message-ID: <20131219190126.GA5123@gmail.com>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
 <1387466911-3732-6-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387466911-3732-6-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 19, 2013 at 04:28:31PM +0100, Sebastian Andrzej Siewior wrote:
> The ADC driver always programs all possible ADC values and discards
> them except for the value IIO asked for. On the am335x-evm the driver
> programs four values and it takes 500us to gather them. Reducing the number
> of conversations down to the (required) one also reduces the busy loop down
> to 125us.
> 
> This leads to another error, namely the FIFOCOUNT register is sometimes
> (like one out of 10 attempts) not updated in time leading to EBUSY.
> The next read has the FIFOCOUNT register updated.
> Checking for the ADCSTAT register for being idle isn't a good choice either.
> The problem is that if TSC is used at the same time, the HW completes the
> conversation for ADC *and* before the driver noticed it, the HW begins to
> perform a TSC conversation and so the driver never seen the HW idle. The
> next time we would have two values in the FIFO but since the driver reads
> everything we always see the current one.
> So instead of polling for the IDLE bit in ADCStatus register, we should
> check the FIFOCOUNT register. It should be one instead of zero because we
> request one value.
> 
> This change in turn leads to another error. Sometimes if TSC & ADC are
> used together the TSC starts becoming interrupts even if nobody
> actually touched the touchscreen. The interrupts seem valid because TSC's
> FIFO is filled with values for each channel of the TSC. This condition stops
> after a few ADC reads but will occur again. Not good.
> 
> On top of this (even without the changes I just mentioned) there is a ADC
> & TSC lockup condition which was reported to me by Jeff Lance including the
> following test case:
> A busy loop of "cat /sys/bus/iio/devices/iio\:device0/in_voltage4_raw"
> and a mug on touch screen. With this setup, the hardware will lockup after
> something between 20 minutes and it could take up to a couple of hours.
> During that lockup, the ADCSTAT register says 0x30 (or 0x70) which means
> STEP_ID = IDLE and FSM_BUSY = yes. That means the hardware says that it is
> idle and busy at the same time which is an invalid condition.
I knew about FSM messing up. But couldn't investigate thouroughly
and didn't want to rework so much while adding continuous mode. 

Good work :)
> 
> For all this reasons I decided to rework this TSC/ADC part and add a
> handshake / synchronization here:
> First the ADC signals that it needs the HW and writes a 0 mask into the
> SE register. The HW (if active) will complete the current conversation
> and become idle. The TSC driver will gather the values from the FIFO
> (woken up by an interrupt) and won't "enable" another conversation.
> Instead it will wake up the ADC driver which is already waiting. The ADC
> driver will start "its" conversation and once it is done, it will
> enable the TSC steps so the TSC will work again.
> 
> After this rework I haven't observed the lockup so far. Plus the busy
> loop has been reduced from 500us to 125us.
> 
> The continues-read mode remains unchanged.

For one-shot reading from ADC, the TSC is 'disabled' for that moment.
Ok. But for continuous mode, reading from ADC disables TSC for that long time?

If it doesn't disable the TSC, does that mean that this fix would
correct the one-shot read. But the continuous mode is still prone to the 
FSM hanging up?

> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
...
> @@ -329,34 +347,43 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	unsigned int fifo1count, read, stepid;
>  	bool found = false;
>  	u32 step_en;
> -	unsigned long timeout = jiffies + usecs_to_jiffies
> -				(IDLE_TIMEOUT * adc_dev->channels);
> +	unsigned long timeout;
>  
>  	if (iio_buffer_enabled(indio_dev))
>  		return -EBUSY;
>  
> -	step_en = get_adc_step_mask(adc_dev);
> +	step_en = get_adc_chan_step_mask(adc_dev, chan);
> +	if (!step_en)
> +		return -EINVAL;
> +
> +	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
> +	while (fifo1count--)
> +		tiadc_readl(adc_dev, REG_FIFO1);
> +
Would this flush be needed ideally?

Thanks
Zubair 
