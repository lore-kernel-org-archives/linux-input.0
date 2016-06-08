From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/8] mfd: ti_am335x_tscadc: Unify variable naming when
 refrencing ti_tscadc_dev
Date: Wed, 8 Jun 2016 16:34:14 +0100
Message-ID: <20160608153414.GS14888@dell>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-5-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160531170013.2649-5-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> All functions in this driver reference the same ti_tscadc_dev per dev=
ice
> but use several different names for this structure pointer, this can
> be confusing when following the code. Use the name 'tscadc' everywher=
e.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 88 +++++++++++++++++++++-----------=
----------
>  1 file changed, 44 insertions(+), 44 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index 613f15d..9b293b1 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -34,89 +34,89 @@ static const struct regmap_config tscadc_regmap_c=
onfig =3D {
>  	.val_bits =3D 32,
>  };
> =20
> -void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tsadc, u32 val)
> +void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tscadc, u32 val)
>  {
>  	unsigned long flags;
> =20
> -	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->reg_se_cache |=3D val;
> -	if (tsadc->adc_waiting)
> -		wake_up(&tsadc->reg_se_wait);
> -	else if (!tsadc->adc_in_use)
> -		regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
> +	spin_lock_irqsave(&tscadc->reg_lock, flags);
> +	tscadc->reg_se_cache |=3D val;
> +	if (tscadc->adc_waiting)
> +		wake_up(&tscadc->reg_se_wait);
> +	else if (!tscadc->adc_in_use)
> +		regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
> =20
> -	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
> +	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_set_cache);
> =20
> -static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tsadc)
> +static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tscadc)
>  {
>  	DEFINE_WAIT(wait);
>  	u32 reg;
> =20
> -	regmap_read(tsadc->regmap_tscadc, REG_ADCFSM, &reg);
> +	regmap_read(tscadc->regmap_tscadc, REG_ADCFSM, &reg);
>  	if (reg & SEQ_STATUS) {
> -		tsadc->adc_waiting =3D true;
> -		prepare_to_wait(&tsadc->reg_se_wait, &wait,
> +		tscadc->adc_waiting =3D true;
> +		prepare_to_wait(&tscadc->reg_se_wait, &wait,
>  				TASK_UNINTERRUPTIBLE);
> -		spin_unlock_irq(&tsadc->reg_lock);
> +		spin_unlock_irq(&tscadc->reg_lock);
> =20
>  		schedule();
> =20
> -		spin_lock_irq(&tsadc->reg_lock);
> -		finish_wait(&tsadc->reg_se_wait, &wait);
> +		spin_lock_irq(&tscadc->reg_lock);
> +		finish_wait(&tscadc->reg_se_wait, &wait);
> =20
>  		/*
>  		 * Sequencer should either be idle or
>  		 * busy applying the charge step.
>  		 */
> -		regmap_read(tsadc->regmap_tscadc, REG_ADCFSM, &reg);
> +		regmap_read(tscadc->regmap_tscadc, REG_ADCFSM, &reg);
>  		WARN_ON((reg & SEQ_STATUS) && !(reg & CHARGE_STEP));
> -		tsadc->adc_waiting =3D false;
> +		tscadc->adc_waiting =3D false;
>  	}
> -	tsadc->adc_in_use =3D true;
> +	tscadc->adc_in_use =3D true;
>  }
> =20
> -void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
> +void am335x_tsc_se_set_once(struct ti_tscadc_dev *tscadc, u32 val)
>  {
> -	spin_lock_irq(&tsadc->reg_lock);
> -	am335x_tscadc_need_adc(tsadc);
> +	spin_lock_irq(&tscadc->reg_lock);
> +	am335x_tscadc_need_adc(tscadc);
> =20
> -	regmap_write(tsadc->regmap_tscadc, REG_SE, val);
> -	spin_unlock_irq(&tsadc->reg_lock);
> +	regmap_write(tscadc->regmap_tscadc, REG_SE, val);
> +	spin_unlock_irq(&tscadc->reg_lock);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_set_once);
> =20
> -void am335x_tsc_se_adc_done(struct ti_tscadc_dev *tsadc)
> +void am335x_tsc_se_adc_done(struct ti_tscadc_dev *tscadc)
>  {
>  	unsigned long flags;
> =20
> -	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->adc_in_use =3D false;
> -	regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
> -	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
> +	spin_lock_irqsave(&tscadc->reg_lock, flags);
> +	tscadc->adc_in_use =3D false;
> +	regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
> +	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_adc_done);
> =20
> -void am335x_tsc_se_clr(struct ti_tscadc_dev *tsadc, u32 val)
> +void am335x_tsc_se_clr(struct ti_tscadc_dev *tscadc, u32 val)
>  {
>  	unsigned long flags;
> =20
> -	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->reg_se_cache &=3D ~val;
> -	regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
> -	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
> +	spin_lock_irqsave(&tscadc->reg_lock, flags);
> +	tscadc->reg_se_cache &=3D ~val;
> +	regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
> +	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_clr);
> =20
> -static void tscadc_idle_config(struct ti_tscadc_dev *config)
> +static void tscadc_idle_config(struct ti_tscadc_dev *tscadc)
>  {
>  	unsigned int idleconfig;
> =20
>  	idleconfig =3D STEPCONFIG_YNN | STEPCONFIG_INM_ADCREFM |
>  			STEPCONFIG_INP_ADCREFM | STEPCONFIG_YPN;
> =20
> -	regmap_write(config->regmap_tscadc, REG_IDLECONFIG, idleconfig);
> +	regmap_write(tscadc->regmap_tscadc, REG_IDLECONFIG, idleconfig);
>  }
> =20
>  static	int ti_tscadc_probe(struct platform_device *pdev)
> @@ -298,9 +298,9 @@ static int ti_tscadc_remove(struct platform_devic=
e *pdev)
> =20
>  static int __maybe_unused tscadc_suspend(struct device *dev)
>  {
> -	struct ti_tscadc_dev	*tscadc_dev =3D dev_get_drvdata(dev);
> +	struct ti_tscadc_dev	*tscadc =3D dev_get_drvdata(dev);
> =20
> -	regmap_write(tscadc_dev->regmap_tscadc, REG_SE, 0x00);
> +	regmap_write(tscadc->regmap_tscadc, REG_SE, 0x00);
>  	pm_runtime_put_sync(dev);
> =20
>  	return 0;
> @@ -308,26 +308,26 @@ static int __maybe_unused tscadc_suspend(struct=
 device *dev)
> =20
>  static int __maybe_unused tscadc_resume(struct device *dev)
>  {
> -	struct ti_tscadc_dev	*tscadc_dev =3D dev_get_drvdata(dev);
> +	struct ti_tscadc_dev	*tscadc =3D dev_get_drvdata(dev);
>  	u32 ctrl;
> =20
>  	pm_runtime_get_sync(dev);
> =20
>  	/* context restore */
>  	ctrl =3D CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> -	regmap_write(tscadc_dev->regmap_tscadc, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
> =20
> -	if (tscadc_dev->tsc_cell !=3D -1) {
> -		if (tscadc_dev->tsc_wires =3D=3D 5)
> +	if (tscadc->tsc_cell !=3D -1) {
> +		if (tscadc->tsc_wires =3D=3D 5)
>  			ctrl |=3D CNTRLREG_5WIRE | CNTRLREG_TSCENB;
>  		else
>  			ctrl |=3D CNTRLREG_4WIRE | CNTRLREG_TSCENB;
> -		tscadc_idle_config(tscadc_dev);
> +		tscadc_idle_config(tscadc);
>  	}
>  	ctrl |=3D CNTRLREG_TSCSSENB;
> -	regmap_write(tscadc_dev->regmap_tscadc, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
> =20
> -	regmap_write(tscadc_dev->regmap_tscadc, REG_CLKDIV, tscadc_dev->clk=
_div);
> +	regmap_write(tscadc->regmap_tscadc, REG_CLKDIV, tscadc->clk_div);
> =20
>  	return 0;
>  }

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
