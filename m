From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/8] mfd: ti_am335x_tscadc: Remove use of single line
 functions
Date: Wed, 8 Jun 2016 16:35:08 +0100
Message-ID: <20160608153508.GT14888@dell>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-4-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36379 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbcFHPei (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jun 2016 11:34:38 -0400
Received: by mail-wm0-f42.google.com with SMTP id n184so187384074wmn.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jun 2016 08:34:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160531170013.2649-4-afd@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> tscadc_readl and tscadc_writel are single line functions and do not s=
ave
> use anything, remove these.

Right.  I usually push back on these type of abstraction when they are
submitted.

Acked-by: Lee Jones <lee.jones@linaro.org>

> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 44 ++++++++++++++------------------=
----------
>  1 file changed, 15 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index 644128b..613f15d 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -27,20 +27,6 @@
> =20
>  #include <linux/mfd/ti_am335x_tscadc.h>
> =20
> -static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsign=
ed int reg)
> -{
> -	unsigned int val;
> -
> -	regmap_read(tsadc->regmap_tscadc, reg, &val);
> -	return val;
> -}
> -
> -static void tscadc_writel(struct ti_tscadc_dev *tsadc, unsigned int =
reg,
> -					unsigned int val)
> -{
> -	regmap_write(tsadc->regmap_tscadc, reg, val);
> -}
> -
>  static const struct regmap_config tscadc_regmap_config =3D {
>  	.name =3D "ti_tscadc",
>  	.reg_bits =3D 32,
> @@ -57,7 +43,7 @@ void am335x_tsc_se_set_cache(struct ti_tscadc_dev *=
tsadc, u32 val)
>  	if (tsadc->adc_waiting)
>  		wake_up(&tsadc->reg_se_wait);
>  	else if (!tsadc->adc_in_use)
> -		tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
> +		regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
> =20
>  	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
>  }
> @@ -68,7 +54,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc=
_dev *tsadc)
>  	DEFINE_WAIT(wait);
>  	u32 reg;
> =20
> -	reg =3D tscadc_readl(tsadc, REG_ADCFSM);
> +	regmap_read(tsadc->regmap_tscadc, REG_ADCFSM, &reg);
>  	if (reg & SEQ_STATUS) {
>  		tsadc->adc_waiting =3D true;
>  		prepare_to_wait(&tsadc->reg_se_wait, &wait,
> @@ -84,7 +70,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc=
_dev *tsadc)
>  		 * Sequencer should either be idle or
>  		 * busy applying the charge step.
>  		 */
> -		reg =3D tscadc_readl(tsadc, REG_ADCFSM);
> +		regmap_read(tsadc->regmap_tscadc, REG_ADCFSM, &reg);
>  		WARN_ON((reg & SEQ_STATUS) && !(reg & CHARGE_STEP));
>  		tsadc->adc_waiting =3D false;
>  	}
> @@ -96,7 +82,7 @@ void am335x_tsc_se_set_once(struct ti_tscadc_dev *t=
sadc, u32 val)
>  	spin_lock_irq(&tsadc->reg_lock);
>  	am335x_tscadc_need_adc(tsadc);
> =20
> -	tscadc_writel(tsadc, REG_SE, val);
> +	regmap_write(tsadc->regmap_tscadc, REG_SE, val);
>  	spin_unlock_irq(&tsadc->reg_lock);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_set_once);
> @@ -107,7 +93,7 @@ void am335x_tsc_se_adc_done(struct ti_tscadc_dev *=
tsadc)
> =20
>  	spin_lock_irqsave(&tsadc->reg_lock, flags);
>  	tsadc->adc_in_use =3D false;
> -	tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
> +	regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
>  	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_adc_done);
> @@ -118,7 +104,7 @@ void am335x_tsc_se_clr(struct ti_tscadc_dev *tsad=
c, u32 val)
> =20
>  	spin_lock_irqsave(&tsadc->reg_lock, flags);
>  	tsadc->reg_se_cache &=3D ~val;
> -	tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
> +	regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
>  	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_clr);
> @@ -130,7 +116,7 @@ static void tscadc_idle_config(struct ti_tscadc_d=
ev *config)
>  	idleconfig =3D STEPCONFIG_YNN | STEPCONFIG_INM_ADCREFM |
>  			STEPCONFIG_INP_ADCREFM | STEPCONFIG_YPN;
> =20
> -	tscadc_writel(config, REG_IDLECONFIG, idleconfig);
> +	regmap_write(config->regmap_tscadc, REG_IDLECONFIG, idleconfig);
>  }
> =20
>  static	int ti_tscadc_probe(struct platform_device *pdev)
> @@ -236,11 +222,11 @@ static	int ti_tscadc_probe(struct platform_devi=
ce *pdev)
> =20
>  	/* TSCADC_CLKDIV needs to be configured to the value minus 1 */
>  	tscadc->clk_div--;
> -	tscadc_writel(tscadc, REG_CLKDIV, tscadc->clk_div);
> +	regmap_write(tscadc->regmap_tscadc, REG_CLKDIV, tscadc->clk_div);
> =20
>  	/* Set the control register bits */
>  	ctrl =3D CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> -	tscadc_writel(tscadc, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
> =20
>  	/* Set register bits for Idle Config Mode */
>  	if (tsc_wires > 0) {
> @@ -254,7 +240,7 @@ static	int ti_tscadc_probe(struct platform_device=
 *pdev)
> =20
>  	/* Enable the TSC module enable bit */
>  	ctrl |=3D CNTRLREG_TSCSSENB;
> -	tscadc_writel(tscadc, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
> =20
>  	tscadc->used_cells =3D 0;
>  	tscadc->tsc_cell =3D -1;
> @@ -300,7 +286,7 @@ static int ti_tscadc_remove(struct platform_devic=
e *pdev)
>  {
>  	struct ti_tscadc_dev	*tscadc =3D platform_get_drvdata(pdev);
> =20
> -	tscadc_writel(tscadc, REG_SE, 0x00);
> +	regmap_write(tscadc->regmap_tscadc, REG_SE, 0x00);
> =20
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -314,7 +300,7 @@ static int __maybe_unused tscadc_suspend(struct d=
evice *dev)
>  {
>  	struct ti_tscadc_dev	*tscadc_dev =3D dev_get_drvdata(dev);
> =20
> -	tscadc_writel(tscadc_dev, REG_SE, 0x00);
> +	regmap_write(tscadc_dev->regmap_tscadc, REG_SE, 0x00);
>  	pm_runtime_put_sync(dev);
> =20
>  	return 0;
> @@ -329,7 +315,7 @@ static int __maybe_unused tscadc_resume(struct de=
vice *dev)
> =20
>  	/* context restore */
>  	ctrl =3D CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> -	tscadc_writel(tscadc_dev, REG_CTRL, ctrl);
> +	regmap_write(tscadc_dev->regmap_tscadc, REG_CTRL, ctrl);
> =20
>  	if (tscadc_dev->tsc_cell !=3D -1) {
>  		if (tscadc_dev->tsc_wires =3D=3D 5)
> @@ -339,9 +325,9 @@ static int __maybe_unused tscadc_resume(struct de=
vice *dev)
>  		tscadc_idle_config(tscadc_dev);
>  	}
>  	ctrl |=3D CNTRLREG_TSCSSENB;
> -	tscadc_writel(tscadc_dev, REG_CTRL, ctrl);
> +	regmap_write(tscadc_dev->regmap_tscadc, REG_CTRL, ctrl);
> =20
> -	tscadc_writel(tscadc_dev, REG_CLKDIV, tscadc_dev->clk_div);
> +	regmap_write(tscadc_dev->regmap_tscadc, REG_CLKDIV, tscadc_dev->clk=
_div);
> =20
>  	return 0;
>  }

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
