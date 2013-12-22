From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/5] mfd: ti_am335x_tscadc: Don't read back REG_SE
Date: Sun, 22 Dec 2013 17:46:44 +0000
Message-ID: <52B72584.5090608@kernel.org>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de> <1387466911-3732-4-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387466911-3732-4-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 12/19/13 15:28, Sebastian Andrzej Siewior wrote:
> The purpose of reg_se_cache has been defeated. It should avoid the
> read-back of the register to avoid the latency and the fact that the
> bits are reset to 0 after the individual conversation took place.
>=20
> The reason why this is required like this to work, is that read-back =
of
> the register removes the bits of the ADC so they do not start another
> conversation after the register is re-written from the TSC side for t=
he
> update.
> To avoid the not required read-back I introduce a "set once" variant =
which
> does not update the cache mask. After the conversation completes, the
> bit is removed from the SE register anyway and we don't plan a new
> conversation "any time soon". The current set function is renamed to
> set_cache to distinguish the two operations.
> This is a small preparation for a larger sync-rework.
>=20
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  drivers/iio/adc/ti_am335x_adc.c           |  4 ++--
>  drivers/input/touchscreen/ti_am335x_tsc.c |  4 ++--
>  drivers/mfd/ti_am335x_tscadc.c            | 16 ++++++++++++----
>  include/linux/mfd/ti_am335x_tscadc.h      |  3 ++-
>  4 files changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am3=
35x_adc.c
> index e948454..b5197a0 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -181,7 +181,7 @@ static int tiadc_buffer_postenable(struct iio_dev=
 *indio_dev)
>  		enb |=3D (get_adc_step_bit(adc_dev, bit) << 1);
>  	adc_dev->buffer_en_ch_steps =3D enb;
> =20
> -	am335x_tsc_se_set(adc_dev->mfd_tscadc, enb);
> +	am335x_tsc_se_set_cache(adc_dev->mfd_tscadc, enb);
> =20
>  	tiadc_writel(adc_dev,  REG_IRQSTATUS, IRQENB_FIFO1THRES
>  				| IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW);
> @@ -335,7 +335,7 @@ static int tiadc_read_raw(struct iio_dev *indio_d=
ev,
>  		return -EBUSY;
> =20
>  	step_en =3D get_adc_step_mask(adc_dev);
> -	am335x_tsc_se_set(adc_dev->mfd_tscadc, step_en);
> +	am335x_tsc_se_set_once(adc_dev->mfd_tscadc, step_en);
> =20
>  	/* Wait for ADC sequencer to complete sampling */
>  	while (tiadc_readl(adc_dev, REG_ADCFSM) & SEQ_STATUS) {
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/inpu=
t/touchscreen/ti_am335x_tsc.c
> index 68beada..2ca5a7b 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -198,7 +198,7 @@ static void titsc_step_config(struct titsc *ts_de=
v)
>  	/* The steps1 =E2=80=A6 end and bit 0 for TS_Charge */
>  	stepenable =3D (1 << (end_step + 2)) - 1;
>  	ts_dev->step_mask =3D stepenable;
> -	am335x_tsc_se_set(ts_dev->mfd_tscadc, ts_dev->step_mask);
> +	am335x_tsc_se_set_cache(ts_dev->mfd_tscadc, ts_dev->step_mask);
>  }
> =20
>  static void titsc_read_coordinates(struct titsc *ts_dev,
> @@ -322,7 +322,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
> =20
>  	if (irqclr) {
>  		titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
> -		am335x_tsc_se_set(ts_dev->mfd_tscadc, ts_dev->step_mask);
> +		am335x_tsc_se_set_cache(ts_dev->mfd_tscadc, ts_dev->step_mask);
>  		return IRQ_HANDLED;
>  	}
>  	return IRQ_NONE;
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index 67d0eb4..cb0c211 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -53,24 +53,32 @@ static void am335x_tsc_se_update(struct ti_tscadc=
_dev *tsadc)
>  	tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
>  }
> =20
> -void am335x_tsc_se_set(struct ti_tscadc_dev *tsadc, u32 val)
> +void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tsadc, u32 val)
>  {
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->reg_se_cache =3D tscadc_readl(tsadc, REG_SE);
>  	tsadc->reg_se_cache |=3D val;
>  	am335x_tsc_se_update(tsadc);
>  	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
>  }
> -EXPORT_SYMBOL_GPL(am335x_tsc_se_set);
> +EXPORT_SYMBOL_GPL(am335x_tsc_se_set_cache);
> +
> +void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tsadc->reg_lock, flags);
> +	tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache | val);
> +	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(am335x_tsc_se_set_once);
> =20
>  void am335x_tsc_se_clr(struct ti_tscadc_dev *tsadc, u32 val)
>  {
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->reg_se_cache =3D tscadc_readl(tsadc, REG_SE);
>  	tsadc->reg_se_cache &=3D ~val;
>  	am335x_tsc_se_update(tsadc);
>  	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd=
/ti_am335x_tscadc.h
> index 1fe7219..2fa9c06 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -176,7 +176,8 @@ static inline struct ti_tscadc_dev *ti_tscadc_dev=
_get(struct platform_device *p)
>  	return *tscadc_dev;
>  }
> =20
> -void am335x_tsc_se_set(struct ti_tscadc_dev *tsadc, u32 val);
> +void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tsadc, u32 val);
> +void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val);
>  void am335x_tsc_se_clr(struct ti_tscadc_dev *tsadc, u32 val);
> =20
>  #endif
>=20
