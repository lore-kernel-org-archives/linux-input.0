From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] Input: ti_am335x_tsc - Ack pending IRQs at probe and
 before suspend
Date: Tue, 17 May 2016 06:56:43 +0100
Message-ID: <20160517055643.GA17238@dell>
References: <1463397984-15766-1-git-send-email-vigneshr@ti.com>
 <1463397984-15766-4-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34954 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbcEQF42 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 01:56:28 -0400
Received: by mail-wm0-f51.google.com with SMTP id e201so124934812wme.0
        for <linux-input@vger.kernel.org>; Mon, 16 May 2016 22:56:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1463397984-15766-4-git-send-email-vigneshr@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 16 May 2016, Vignesh R wrote:

> From: Grygorii Strashko <grygorii.strashko@ti.com>
>=20
> It is seen that just enabling the TSC module triggers a HW_PEN IRQ
> without any interaction with touchscreen by user. This results in fir=
st
> suspend/resume sequence to fail as system immediately wakes up from
> suspend as soon as HW_PEN IRQ is enabled in suspend handler. due to t=
he
> pending IRQ. Therefore clear all IRQs at probe and also in suspend
> callback for sanity.
>=20
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 ++
>  include/linux/mfd/ti_am335x_tscadc.h      | 1 +

=46or the MFD change:
  Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 3 insertions(+)
>=20
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/inpu=
t/touchscreen/ti_am335x_tsc.c
> index 4683ed18b9f8..d2c55b5730e6 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -441,6 +441,7 @@ static int titsc_probe(struct platform_device *pd=
ev)
>  			dev_err(&pdev->dev, "irq wake enable failed.\n");
>  	}
> =20
> +	titsc_writel(ts_dev, REG_IRQSTATUS, IRQENB_MASK);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
>  	err =3D titsc_config_wires(ts_dev);
> @@ -506,6 +507,7 @@ static int __maybe_unused titsc_suspend(struct de=
vice *dev)
> =20
>  	tscadc_dev =3D ti_tscadc_dev_get(to_platform_device(dev));
>  	if (device_may_wakeup(tscadc_dev->dev)) {
> +		titsc_writel(ts_dev, REG_IRQSTATUS, IRQENB_MASK);
>  		idle =3D titsc_readl(ts_dev, REG_IRQENABLE);
>  		titsc_writel(ts_dev, REG_IRQENABLE,
>  				(idle | IRQENB_HW_PEN));
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd=
/ti_am335x_tscadc.h
> index 1fd50dcfe47c..a7ca0f908ba8 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -60,6 +60,7 @@
>  #define IRQENB_FIFO1OVRRUN	BIT(6)
>  #define IRQENB_FIFO1UNDRFLW	BIT(7)
>  #define IRQENB_PENUP		BIT(9)
> +#define IRQENB_MASK		(0x7FF)
> =20
>  /* Step Configuration */
>  #define STEPCONFIG_MODE_MASK	(3 << 0)

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
