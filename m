From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/8] mfd: ti_am335x_tscadc: Use SIMPLE_DEV_PM_OPS helper
 macro
Date: Wed, 8 Jun 2016 16:35:59 +0100
Message-ID: <20160608153559.GV14888@dell>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37986 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161857AbcFHPfa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jun 2016 11:35:30 -0400
Received: by mail-wm0-f45.google.com with SMTP id m124so22625518wme.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jun 2016 08:35:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160531170013.2649-2-afd@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> Replace ifdefs with SIMPLE_DEV_PM_OPS helper macro.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index e4e4b22..644128b 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -310,8 +310,7 @@ static int ti_tscadc_remove(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_PM
> -static int tscadc_suspend(struct device *dev)
> +static int __maybe_unused tscadc_suspend(struct device *dev)
>  {
>  	struct ti_tscadc_dev	*tscadc_dev =3D dev_get_drvdata(dev);
> =20
> @@ -321,7 +320,7 @@ static int tscadc_suspend(struct device *dev)
>  	return 0;
>  }
> =20
> -static int tscadc_resume(struct device *dev)
> +static int __maybe_unused tscadc_resume(struct device *dev)
>  {
>  	struct ti_tscadc_dev	*tscadc_dev =3D dev_get_drvdata(dev);
>  	u32 ctrl;
> @@ -347,14 +346,7 @@ static int tscadc_resume(struct device *dev)
>  	return 0;
>  }
> =20
> -static const struct dev_pm_ops tscadc_pm_ops =3D {
> -	.suspend =3D tscadc_suspend,
> -	.resume =3D tscadc_resume,
> -};
> -#define TSCADC_PM_OPS (&tscadc_pm_ops)
> -#else
> -#define TSCADC_PM_OPS NULL
> -#endif
> +static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resum=
e);
> =20
>  static const struct of_device_id ti_tscadc_dt_ids[] =3D {
>  	{ .compatible =3D "ti,am3359-tscadc", },
> @@ -365,7 +357,7 @@ MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
>  static struct platform_driver ti_tscadc_driver =3D {
>  	.driver =3D {
>  		.name   =3D "ti_am3359-tscadc",
> -		.pm	=3D TSCADC_PM_OPS,
> +		.pm	=3D &tscadc_pm_ops,
>  		.of_match_table =3D ti_tscadc_dt_ids,
>  	},
>  	.probe	=3D ti_tscadc_probe,

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
