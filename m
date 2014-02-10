From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] input: mc13783: Use module_platform_driver_probe()
Date: Mon, 10 Feb 2014 08:18:44 +0100
Message-ID: <20140210071844.GN17045@pengutronix.de>
References: <1392006138-10341-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48450 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbaBJHSs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Feb 2014 02:18:48 -0500
Content-Disposition: inline
In-Reply-To: <1392006138-10341-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

On Mon, Feb 10, 2014 at 08:22:18AM +0400, Alexander Shiyan wrote:
> Driver should be probed from MC13XXX MFD core only, so change
> driver declaration to use module_platform_driver_probe().
That reasoning is broken I think. At least it doesn't mean that a
button-device is only created at boot or module load time. I didn't tes=
t
it, but I'd expect that you can unbind/bind the mc13xxx driver via sysf=
s
and that makes the button support disappear.

(That doesn't necessarily means your change is wrong, just the reason
you provided to justify it is invalid.)

Best regards
Uwe

> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/input/misc/mc13783-pwrbutton.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/m=
isc/mc13783-pwrbutton.c
> index 60be67a..a1e45235 100644
> --- a/drivers/input/misc/mc13783-pwrbutton.c
> +++ b/drivers/input/misc/mc13783-pwrbutton.c
> @@ -88,7 +88,7 @@ static irqreturn_t button_irq(int irq, void *_priv)
>  	return IRQ_HANDLED;
>  }
> =20
> -static int mc13783_pwrbutton_probe(struct platform_device *pdev)
> +static int __init mc13xxx_pwrbutton_probe(struct platform_device *pd=
ev)
>  {
>  	const struct mc13xxx_buttons_platform_data *pdata;
>  	struct mc13xxx *mc13783 =3D dev_get_drvdata(pdev->dev.parent);
> @@ -229,7 +229,7 @@ free_input_dev:
>  	return err;
>  }
> =20
> -static int mc13783_pwrbutton_remove(struct platform_device *pdev)
> +static int mc13xxx_pwrbutton_remove(struct platform_device *pdev)
>  {
>  	struct mc13783_pwrb *priv =3D platform_get_drvdata(pdev);
>  	const struct mc13xxx_buttons_platform_data *pdata;
> @@ -253,18 +253,15 @@ static int mc13783_pwrbutton_remove(struct plat=
form_device *pdev)
>  	return 0;
>  }
> =20
> -static struct platform_driver mc13783_pwrbutton_driver =3D {
> -	.probe		=3D mc13783_pwrbutton_probe,
> -	.remove		=3D mc13783_pwrbutton_remove,
> +static struct platform_driver mc13xxx_pwrbutton_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "mc13783-pwrbutton",
>  		.owner	=3D THIS_MODULE,
>  	},
> +	.remove		=3D mc13xxx_pwrbutton_remove,
>  };
> +module_platform_driver_probe(mc13xxx_pwrbutton_driver, mc13xxx_pwrbu=
tton_probe);
> =20
> -module_platform_driver(mc13783_pwrbutton_driver);
> -
> -MODULE_ALIAS("platform:mc13783-pwrbutton");
>  MODULE_DESCRIPTION("MC13783 Power Button");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Philippe Retornaz");
> --=20
> 1.8.3.2
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
