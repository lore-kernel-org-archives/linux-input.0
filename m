From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] Input: stmpe-ts - enforce device tree only mode
Date: Tue, 26 May 2015 09:42:03 +0100
Message-ID: <20150526084203.GD11677@x1>
References: <20150522225832.GA19831@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36726 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbbEZImI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 04:42:08 -0400
Received: by wgbgq6 with SMTP id gq6so90341750wgb.3
        for <linux-input@vger.kernel.org>; Tue, 26 May 2015 01:42:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150522225832.GA19831@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Marek Vasut <marex@denx.de>, Heiner Kallweit <hkallweit1@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org

On Fri, 22 May 2015, Dmitry Torokhov wrote:

> The STMPE MFD is only used with device tree configured systems (and S=
TMPE
> MFD core depends on OF), so force the configuration to come from devi=
ce
> tree only.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>=20
> Not tested as no device, please give it a spin.
>=20
>  drivers/input/touchscreen/Kconfig    |  1 +
>  drivers/input/touchscreen/stmpe-ts.c | 29 ++++--------------------
>  include/linux/mfd/stmpe.h            | 44 --------------------------=
----------

Less code for me to have to worry about:

=46or the MFD part:
  Acked-by: Lee Jones <lee.jones@linaro.org>

>  3 files changed, 6 insertions(+), 68 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index 80f6386..7afa6a2 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -958,6 +958,7 @@ config TOUCHSCREEN_ST1232
>  config TOUCHSCREEN_STMPE
>  	tristate "STMicroelectronics STMPE touchscreens"
>  	depends on MFD_STMPE
> +	depends on (OF || COMPILE_TEST)
>  	help
>  	  Say Y here if you want support for STMicroelectronics
>  	  STMPE touchscreen controllers.
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/tou=
chscreen/stmpe-ts.c
> index e4977c6..e414d43 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -267,27 +267,10 @@ static void stmpe_ts_close(struct input_dev *de=
v)
>  static void stmpe_ts_get_platform_info(struct platform_device *pdev,
>  					struct stmpe_touch *ts)
>  {
> -	struct stmpe *stmpe =3D dev_get_drvdata(pdev->dev.parent);
>  	struct device_node *np =3D pdev->dev.of_node;
> -	struct stmpe_ts_platform_data *ts_pdata =3D NULL;
> -
> -	ts->stmpe =3D stmpe;
> -
> -	if (stmpe->pdata && stmpe->pdata->ts) {
> -		ts_pdata =3D stmpe->pdata->ts;
> -
> -		ts->sample_time =3D ts_pdata->sample_time;
> -		ts->mod_12b =3D ts_pdata->mod_12b;
> -		ts->ref_sel =3D ts_pdata->ref_sel;
> -		ts->adc_freq =3D ts_pdata->adc_freq;
> -		ts->ave_ctrl =3D ts_pdata->ave_ctrl;
> -		ts->touch_det_delay =3D ts_pdata->touch_det_delay;
> -		ts->settling =3D ts_pdata->settling;
> -		ts->fraction_z =3D ts_pdata->fraction_z;
> -		ts->i_drive =3D ts_pdata->i_drive;
> -	} else if (np) {
> -		u32 val;
> +	u32 val;
> =20
> +	if (np) {
>  		if (!of_property_read_u32(np, "st,sample-time", &val))
>  			ts->sample_time =3D val;
>  		if (!of_property_read_u32(np, "st,mod-12b", &val))
> @@ -311,6 +294,7 @@ static void stmpe_ts_get_platform_info(struct pla=
tform_device *pdev,
> =20
>  static int stmpe_input_probe(struct platform_device *pdev)
>  {
> +	struct stmpe *stmpe =3D dev_get_drvdata(pdev->dev.parent);
>  	struct stmpe_touch *ts;
>  	struct input_dev *idev;
>  	int error;
> @@ -329,6 +313,7 @@ static int stmpe_input_probe(struct platform_devi=
ce *pdev)
>  		return -ENOMEM;
> =20
>  	platform_set_drvdata(pdev, ts);
> +	ts->stmpe =3D stmpe;
>  	ts->idev =3D idev;
>  	ts->dev =3D &pdev->dev;
> =20
> @@ -351,14 +336,13 @@ static int stmpe_input_probe(struct platform_de=
vice *pdev)
>  	idev->name =3D STMPE_TS_NAME;
>  	idev->phys =3D STMPE_TS_NAME"/input0";
>  	idev->id.bustype =3D BUS_I2C;
> -	idev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> -	idev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
> =20
>  	idev->open =3D stmpe_ts_open;
>  	idev->close =3D stmpe_ts_close;
> =20
>  	input_set_drvdata(idev, ts);
> =20
> +	input_set_capability(idev, EV_KEY, BTN_TOUCH);
>  	input_set_abs_params(idev, ABS_X, 0, XY_MASK, 0, 0);
>  	input_set_abs_params(idev, ABS_Y, 0, XY_MASK, 0, 0);
>  	input_set_abs_params(idev, ABS_PRESSURE, 0x0, 0xff, 0, 0);
> @@ -390,15 +374,12 @@ static struct platform_driver stmpe_ts_driver =3D=
 {
>  };
>  module_platform_driver(stmpe_ts_driver);
> =20
> -#ifdef CONFIG_OF
>  static const struct of_device_id stmpe_ts_ids[] =3D {
>  	{ .compatible =3D "st,stmpe-ts", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, stmpe_ts_ids);
> -#endif
> =20
>  MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
>  MODULE_DESCRIPTION("STMPEXXX touchscreen driver");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:" STMPE_TS_NAME);
> diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
> index c9d8690..cb83883 100644
> --- a/include/linux/mfd/stmpe.h
> +++ b/include/linux/mfd/stmpe.h
> @@ -118,47 +118,6 @@ extern int stmpe_disable(struct stmpe *stmpe, un=
signed int blocks);
>  #define STMPE_GPIO_NOREQ_811_TOUCH	(0xf0)
> =20
>  /**
> - * struct stmpe_ts_platform_data - stmpe811 touch screen controller =
platform
> - * data
> - * @sample_time: ADC converstion time in number of clock.
> - * (0 -> 36 clocks, 1 -> 44 clocks, 2 -> 56 clocks, 3 -> 64 clocks,
> - * 4 -> 80 clocks, 5 -> 96 clocks, 6 -> 144 clocks),
> - * recommended is 4.
> - * @mod_12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
> - * @ref_sel: ADC reference source
> - * (0 -> internal reference, 1 -> external reference)
> - * @adc_freq: ADC Clock speed
> - * (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
> - * @ave_ctrl: Sample average control
> - * (0 -> 1 sample, 1 -> 2 samples, 2 -> 4 samples, 3 -> 8 samples)
> - * @touch_det_delay: Touch detect interrupt delay
> - * (0 -> 10 us, 1 -> 50 us, 2 -> 100 us, 3 -> 500 us,
> - * 4-> 1 ms, 5 -> 5 ms, 6 -> 10 ms, 7 -> 50 ms)
> - * recommended is 3
> - * @settling: Panel driver settling time
> - * (0 -> 10 us, 1 -> 100 us, 2 -> 500 us, 3 -> 1 ms,
> - * 4 -> 5 ms, 5 -> 10 ms, 6 for 50 ms, 7 -> 100 ms)
> - * recommended is 2
> - * @fraction_z: Length of the fractional part in z
> - * (fraction_z ([0..7]) =3D Count of the fractional part)
> - * recommended is 7
> - * @i_drive: current limit value of the touchscreen drivers
> - * (0 -> 20 mA typical 35 mA max, 1 -> 50 mA typical 80 mA max)
> - *
> - * */
> -struct stmpe_ts_platform_data {
> -       u8 sample_time;
> -       u8 mod_12b;
> -       u8 ref_sel;
> -       u8 adc_freq;
> -       u8 ave_ctrl;
> -       u8 touch_det_delay;
> -       u8 settling;
> -       u8 fraction_z;
> -       u8 i_drive;
> -};
> -
> -/**
>   * struct stmpe_platform_data - STMPE platform data
>   * @id: device id to distinguish between multiple STMPEs on the same=
 board
>   * @blocks: bitmask of blocks to enable (use STMPE_BLOCK_*)
> @@ -168,7 +127,6 @@ struct stmpe_ts_platform_data {
>   * @irq_over_gpio: true if gpio is used to get irq
>   * @irq_gpio: gpio number over which irq will be requested (signific=
ant only if
>   *	      irq_over_gpio is true)
> - * @ts: touchscreen-specific platform data
>   */
>  struct stmpe_platform_data {
>  	int id;
> @@ -178,8 +136,6 @@ struct stmpe_platform_data {
>  	bool irq_over_gpio;
>  	int irq_gpio;
>  	int autosleep_timeout;
> -
> -	struct stmpe_ts_platform_data *ts;
>  };
> =20
>  #endif

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
