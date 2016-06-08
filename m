From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/8] mfd: ti_am335x_tscadc: Rename regmap_tscadc to regmap
Date: Wed, 8 Jun 2016 16:33:53 +0100
Message-ID: <20160608153353.GR14888@dell>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-6-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160531170013.2649-6-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> The regmap structuer pointer is named regmap_tscadc, this is not
> consistent with other drivers and is redundant, it also contributes
> to several checkpatch warnings involving long lines. Rename this.

Please spell check all of your subject lines and commit logs *before*
sending.

> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 36 ++++++++++++++++++--------=
----------
>  include/linux/mfd/ti_am335x_tscadc.h |  2 +-
>  2 files changed, 19 insertions(+), 19 deletions(-)

=46or the patch:
  Acked-by: Lee Jones <lee.jones@linaro.org>
 =20
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index 9b293b1..d30bea5 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -43,7 +43,7 @@ void am335x_tsc_se_set_cache(struct ti_tscadc_dev *=
tscadc, u32 val)
>  	if (tscadc->adc_waiting)
>  		wake_up(&tscadc->reg_se_wait);
>  	else if (!tscadc->adc_in_use)
> -		regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
> +		regmap_write(tscadc->regmap, REG_SE, tscadc->reg_se_cache);
> =20
>  	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
>  }
> @@ -54,7 +54,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc=
_dev *tscadc)
>  	DEFINE_WAIT(wait);
>  	u32 reg;
> =20
> -	regmap_read(tscadc->regmap_tscadc, REG_ADCFSM, &reg);
> +	regmap_read(tscadc->regmap, REG_ADCFSM, &reg);
>  	if (reg & SEQ_STATUS) {
>  		tscadc->adc_waiting =3D true;
>  		prepare_to_wait(&tscadc->reg_se_wait, &wait,
> @@ -70,7 +70,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc=
_dev *tscadc)
>  		 * Sequencer should either be idle or
>  		 * busy applying the charge step.
>  		 */
> -		regmap_read(tscadc->regmap_tscadc, REG_ADCFSM, &reg);
> +		regmap_read(tscadc->regmap, REG_ADCFSM, &reg);
>  		WARN_ON((reg & SEQ_STATUS) && !(reg & CHARGE_STEP));
>  		tscadc->adc_waiting =3D false;
>  	}
> @@ -82,7 +82,7 @@ void am335x_tsc_se_set_once(struct ti_tscadc_dev *t=
scadc, u32 val)
>  	spin_lock_irq(&tscadc->reg_lock);
>  	am335x_tscadc_need_adc(tscadc);
> =20
> -	regmap_write(tscadc->regmap_tscadc, REG_SE, val);
> +	regmap_write(tscadc->regmap, REG_SE, val);
>  	spin_unlock_irq(&tscadc->reg_lock);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_set_once);
> @@ -93,7 +93,7 @@ void am335x_tsc_se_adc_done(struct ti_tscadc_dev *t=
scadc)
> =20
>  	spin_lock_irqsave(&tscadc->reg_lock, flags);
>  	tscadc->adc_in_use =3D false;
> -	regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
> +	regmap_write(tscadc->regmap, REG_SE, tscadc->reg_se_cache);
>  	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_adc_done);
> @@ -104,7 +104,7 @@ void am335x_tsc_se_clr(struct ti_tscadc_dev *tsca=
dc, u32 val)
> =20
>  	spin_lock_irqsave(&tscadc->reg_lock, flags);
>  	tscadc->reg_se_cache &=3D ~val;
> -	regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
> +	regmap_write(tscadc->regmap, REG_SE, tscadc->reg_se_cache);
>  	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_clr);
> @@ -116,7 +116,7 @@ static void tscadc_idle_config(struct ti_tscadc_d=
ev *tscadc)
>  	idleconfig =3D STEPCONFIG_YNN | STEPCONFIG_INM_ADCREFM |
>  			STEPCONFIG_INP_ADCREFM | STEPCONFIG_YPN;
> =20
> -	regmap_write(tscadc->regmap_tscadc, REG_IDLECONFIG, idleconfig);
> +	regmap_write(tscadc->regmap, REG_IDLECONFIG, idleconfig);
>  }
> =20
>  static	int ti_tscadc_probe(struct platform_device *pdev)
> @@ -188,11 +188,11 @@ static	int ti_tscadc_probe(struct platform_devi=
ce *pdev)
>  	if (IS_ERR(tscadc->tscadc_base))
>  		return PTR_ERR(tscadc->tscadc_base);
> =20
> -	tscadc->regmap_tscadc =3D devm_regmap_init_mmio(&pdev->dev,
> +	tscadc->regmap =3D devm_regmap_init_mmio(&pdev->dev,
>  			tscadc->tscadc_base, &tscadc_regmap_config);
> -	if (IS_ERR(tscadc->regmap_tscadc)) {
> +	if (IS_ERR(tscadc->regmap)) {
>  		dev_err(&pdev->dev, "regmap init failed\n");
> -		err =3D PTR_ERR(tscadc->regmap_tscadc);
> +		err =3D PTR_ERR(tscadc->regmap);
>  		goto ret;
>  	}
> =20
> @@ -222,11 +222,11 @@ static	int ti_tscadc_probe(struct platform_devi=
ce *pdev)
> =20
>  	/* TSCADC_CLKDIV needs to be configured to the value minus 1 */
>  	tscadc->clk_div--;
> -	regmap_write(tscadc->regmap_tscadc, REG_CLKDIV, tscadc->clk_div);
> +	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
> =20
>  	/* Set the control register bits */
>  	ctrl =3D CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> -	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> =20
>  	/* Set register bits for Idle Config Mode */
>  	if (tsc_wires > 0) {
> @@ -240,7 +240,7 @@ static	int ti_tscadc_probe(struct platform_device=
 *pdev)
> =20
>  	/* Enable the TSC module enable bit */
>  	ctrl |=3D CNTRLREG_TSCSSENB;
> -	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> =20
>  	tscadc->used_cells =3D 0;
>  	tscadc->tsc_cell =3D -1;
> @@ -286,7 +286,7 @@ static int ti_tscadc_remove(struct platform_devic=
e *pdev)
>  {
>  	struct ti_tscadc_dev	*tscadc =3D platform_get_drvdata(pdev);
> =20
> -	regmap_write(tscadc->regmap_tscadc, REG_SE, 0x00);
> +	regmap_write(tscadc->regmap, REG_SE, 0x00);
> =20
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -300,7 +300,7 @@ static int __maybe_unused tscadc_suspend(struct d=
evice *dev)
>  {
>  	struct ti_tscadc_dev	*tscadc =3D dev_get_drvdata(dev);
> =20
> -	regmap_write(tscadc->regmap_tscadc, REG_SE, 0x00);
> +	regmap_write(tscadc->regmap, REG_SE, 0x00);
>  	pm_runtime_put_sync(dev);
> =20
>  	return 0;
> @@ -315,7 +315,7 @@ static int __maybe_unused tscadc_resume(struct de=
vice *dev)
> =20
>  	/* context restore */
>  	ctrl =3D CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> -	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> =20
>  	if (tscadc->tsc_cell !=3D -1) {
>  		if (tscadc->tsc_wires =3D=3D 5)
> @@ -325,9 +325,9 @@ static int __maybe_unused tscadc_resume(struct de=
vice *dev)
>  		tscadc_idle_config(tscadc);
>  	}
>  	ctrl |=3D CNTRLREG_TSCSSENB;
> -	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> =20
> -	regmap_write(tscadc->regmap_tscadc, REG_CLKDIV, tscadc->clk_div);
> +	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
> =20
>  	return 0;
>  }
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd=
/ti_am335x_tscadc.h
> index 1fd50dc..2567a87 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -153,7 +153,7 @@
> =20
>  struct ti_tscadc_dev {
>  	struct device *dev;
> -	struct regmap *regmap_tscadc;
> +	struct regmap *regmap;
>  	void __iomem *tscadc_base;
>  	int irq;
>  	int used_cells;	/* 1-2 */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
