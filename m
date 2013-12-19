From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5] mfd: ti_am335x_tscadc: Make am335x_tsc_se_update()
 local
Date: Thu, 19 Dec 2013 17:16:17 +0000
Message-ID: <20131219171617.GB16145@lee--X1>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
 <1387466911-3732-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:39194 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab3LSRQY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Dec 2013 12:16:24 -0500
Received: by mail-wi0-f175.google.com with SMTP id hi5so7205885wib.14
        for <linux-input@vger.kernel.org>; Thu, 19 Dec 2013 09:16:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387466911-3732-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 19 Dec 2013, Sebastian Andrzej Siewior wrote:

> Since the "recent" changes, am335x_tsc_se_update() has no longer any
> users outside of this file so make it local.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I'm pretty sure I Acked this already.

> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 3 +--
>  include/linux/mfd/ti_am335x_tscadc.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index 88718ab..67d0eb4 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -48,11 +48,10 @@ static const struct regmap_config tscadc_regmap_c=
onfig =3D {
>  	.val_bits =3D 32,
>  };
> =20
> -void am335x_tsc_se_update(struct ti_tscadc_dev *tsadc)
> +static void am335x_tsc_se_update(struct ti_tscadc_dev *tsadc)
>  {
>  	tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
>  }
> -EXPORT_SYMBOL_GPL(am335x_tsc_se_update);
> =20
>  void am335x_tsc_se_set(struct ti_tscadc_dev *tsadc, u32 val)
>  {
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd=
/ti_am335x_tscadc.h
> index d498d98f..1fe7219 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -176,7 +176,6 @@ static inline struct ti_tscadc_dev *ti_tscadc_dev=
_get(struct platform_device *p)
>  	return *tscadc_dev;
>  }
> =20
> -void am335x_tsc_se_update(struct ti_tscadc_dev *tsadc);
>  void am335x_tsc_se_set(struct ti_tscadc_dev *tsadc, u32 val);
>  void am335x_tsc_se_clr(struct ti_tscadc_dev *tsadc, u32 val);
> =20

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
