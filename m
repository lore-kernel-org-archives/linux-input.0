From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] mfd: input: iio: ti_amm335x: rework TSC/ADC
 synchronisation
Date: Thu, 19 Dec 2013 08:42:06 +0000
Message-ID: <20131219084206.GC2621@lee--X1>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
 <1387385577-24447-6-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387385577-24447-6-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> The ADC driver always programms all possible ADC values and discards
> them except for the value IIO asked for. On the am335x-evm the driver
> programs four values and it takes 500us to gather them. Reducing the =
number
> of coversations down to (required) one also reduces the busy loop dow=
n to
> 125us.
> This leads to another error, namely the FIFOCOUNT register is sometim=
es
> (like one out of 10 attempts) not updated in time leading to timeouts=
=2E
> The next read has the fifocount register updated.
> Checking for the ADCStatus status register for beeing idle isn't a go=
od
> choice either. The problem is that it often times out if the TSC is u=
sed
> at the same time. The problem is that the HW compelted the conversato=
n for
> the ADC *and* before the driver noticed it, the HW began to perfom a
> TSC conversation and so the driver never seen the HW idle. The next t=
ime
> we would have two values in the fifo but since the driver reads
> everything we always see the current one.
> So instead of polling for the IDLE bit, we check for the fifocount. I=
t
> should be one instead of zero because we request one value.
> This change in turn lead to another error :) Sometimes if TSC & ADC a=
re
> used together the TSC starts becomming interrupts even if nobody
> actually touched the touchscreen. The interrupts are valid because TS=
C's
> fifo is filled with values. This condition stops after a few ADC read=
s but
> will occur once TSC & ADC are used at the same time. So not good.
>=20
> On top of this (even without the changes I just mentioned) there is a=
 ADC
> & TSC lockup condition which was reported to my Jeff Lance including =
a test
> case:
> A busyloop of loop of "cat /sys/bus/iio/devices/iio\:device0/in_volta=
ge4_raw"
> and a mug on touch screen. Whith this setup, the hardware will lockup=
 after
> something between 20min and it could take up to a couple of hours. Du=
ring that
> lockup, the ADCSTAT says 0x30 (or 0x70) which means STEP_ID =3D IDLE =
and
> FSM_BUSY =3D yes. That means it says that it is idle and busy at the =
same
> time which is an invalid condition.
>=20
> For all this reasons I decided to rework this TSC/ADC part and add a
> handshake / synchronisation here:
> First the ADC signals that it needs the HW and writes a 0 mask into t=
he
> SE register. The HW (if active) will complete the current conversatio=
n
> and become idle. The TSC driver will gather the values from the FIFO
> (woken up by an interrupt) and won't "enable" another conversation.
> Instead it will wake up the ADC driver which is already waiting. The =
ADC
> driver will start "its" converstation and once it is done, it will
> enable the TSC events so the TSC will work again.

Spell check this entire block.

Smileys in commit messages are generally a bad idea.

Please insert '\n's between paragraphs.

Proof read, as some of the sentences are not comprehensible.

/* MFD Parts */

> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -24,6 +24,7 @@

> -static void am335x_tsc_se_update(struct ti_tscadc_dev *tsadc)
> +void am335x_tsc_se_set(struct ti_tscadc_dev *tsadc, u32 val)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tsadc->reg_lock, flags);
> +	tsadc->reg_se_cache |=3D val;
>  	tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
> +	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(am335x_tsc_se_set);
> =20
> -void am335x_tsc_se_set(struct ti_tscadc_dev *tsadc, u32 val)
> +void am335x_tsc_se_tsc_set(struct ti_tscadc_dev *tsadc, u32 val)

What's the difference between:

am335x_tsc_se_set()
and
am335x_tsc_se_tsc_set()

Why don't you have a am335x_tsc_se_tsc_set_tsc_se_tsc_set() ;)

Perhaps a better function name might be in order.

>  {
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->reg_se_cache |=3D val;
> -	am335x_tsc_se_update(tsadc);
> +	tsadc->reg_se_cache =3D val;
> +	if (tsadc->adc_in_use || tsadc->adc_waiting) {
> +		if (tsadc->adc_waiting)
> +			wake_up(&tsadc->reg_se_wait);

So if we're either in-use or waiting, the step mask is never set?

But I guess that the touchscreen driver assumes it has been set.

Is this okay?

> +	} else {
> +		tscadc_writel(tsadc, REG_SE, val);
> +	}

I think this would be better represented as:

        if (tsadc->adc_waiting)
                wake_up(&tsadc->reg_se_wait);
        else if (!tsadc->adc_in_use)
                tscadc_writel(tsadc, REG_SE, val);

>  	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
>  }
> -EXPORT_SYMBOL_GPL(am335x_tsc_se_set);
> +EXPORT_SYMBOL_GPL(am335x_tsc_se_tsc_set);

<snip>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
