From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] imx_keypad: add PM support
Date: Wed, 2 Jun 2010 01:02:13 -0700
Message-ID: <20100602080212.GK3713@core.coreip.homeip.net>
References: <1275135823.3128.15.camel@realization>
 <1275209466-3899-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60790 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab0FBICS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 04:02:18 -0400
Received: by pwj2 with SMTP id 2so1575162pwj.19
        for <linux-input@vger.kernel.org>; Wed, 02 Jun 2010 01:02:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275209466-3899-1-git-send-email-eric@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-input@vger.kernel.org, maramaopercheseimorto@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Eric,

On Sun, May 30, 2010 at 10:51:06AM +0200, Eric B=E9nard wrote:
> * add suspend/resume support
> * use keypad_data to enable wakeup from platform data
> * suspend/resume tested when keypad is not in use and when it's
> is use (in which case we immediatly get the key pressed for
> wakeup)
>=20
> Signed-off-by: Eric B=E9nard <eric@eukrea.com>
> ---
>  drivers/input/keyboard/imx_keypad.c |   56 +++++++++++++++++++++++++=
++++++++-
>  1 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyb=
oard/imx_keypad.c
> index d92c15c..b303cc9 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -364,6 +364,55 @@ static void imx_keypad_inhibit(struct imx_keypad=
 *keypad)
>  	writew(0xff00, keypad->mmio_base + KPCR);
>  }
> =20
> +static int mxc_kpp_suspend(struct platform_device *pdev, pm_message_=
t state)
> +{
> +	struct imx_keypad *keypad =3D platform_get_drvdata(pdev);
> +	unsigned short reg_val;
> +
> +	clk_disable(keypad->clk);
> +
> +	if (device_may_wakeup(&pdev->dev)) {
> +		reg_val =3D readw(keypad->mmio_base + KPSR);
> +		if ((reg_val & KBD_STAT_KDIE) =3D=3D 0) {
> +			/* If no depress interrupt enable the release interrupt */
> +			reg_val |=3D KBD_STAT_KRIE;
> +			writew(reg_val, keypad->mmio_base + KPSR);
> +		}
> +		enable_irq_wake(keypad->irq);
> +	} else {
> +		keypad->enabled =3D false;
> +		synchronize_irq(keypad->irq);
> +		disable_irq(keypad->irq);

I'd factor it out as it is used in both suspend and close.

Does everythig (clk_disable, eit) work well in case when device is stil=
l
closed when it get ssuspended?

Also, do you really need such an elaborate setup when device is/is not
wakeup source? Do you really loose keypress if you always dosable IRQ i=
n
suspend and enable it in resume?

> +	}
> +
> +	return 0;
> +}
> +
> +/*!
> + * This function brings the Keypad controller back from low-power st=
ate.
> + * If Keypad is enabled as a wake source(i.e. it can resume the syst=
em
> + * from suspend mode), the Keypad controller doesn't enter low-power=
 state.
> + *
> + * @param   pdev  the device structure used to give information on K=
eypad
> + *                to resume
> + *
> + * @return  The function always returns 0.
> + */

This is not the standard kerneldoc markup.

> +static int mxc_kpp_resume(struct platform_device *pdev)
> +{
> +	struct imx_keypad *keypad =3D platform_get_drvdata(pdev);
> +
> +	clk_enable(keypad->clk);
> +	if (device_may_wakeup(&pdev->dev)) {
> +		/* The irq routine already cleared KRIE if it was set */
> +	} else {
> +		keypad->enabled =3D true;
> +		enable_irq(keypad->irq);
> +	}
> +
> +	return 0;
> +}
> +
>  static void imx_keypad_close(struct input_dev *dev)
>  {
>  	struct imx_keypad *keypad =3D input_get_drvdata(dev);
> @@ -410,7 +459,8 @@ open_err:
> =20
>  static int __devinit imx_keypad_probe(struct platform_device *pdev)
>  {
> -	const struct matrix_keymap_data *keymap_data =3D pdev->dev.platform=
_data;
> +	const struct matrix_keypad_platform_data *keypad_data =3D pdev->dev=
=2Eplatform_data;
> +	const struct matrix_keymap_data *keymap_data =3D keypad_data->keyma=
p_data;
>  	struct imx_keypad *keypad;
>  	struct input_dev *input_dev;
>  	struct resource *res;
> @@ -525,7 +575,7 @@ static int __devinit imx_keypad_probe(struct plat=
form_device *pdev)
>  	}
> =20
>  	platform_set_drvdata(pdev, keypad);
> -	device_init_wakeup(&pdev->dev, 1);
> +	device_init_wakeup(&pdev->dev, keypad_data->wakeup);
> =20
>  	return 0;
> =20
> @@ -574,6 +624,8 @@ static struct platform_driver imx_keypad_driver =3D=
 {
>  	},
>  	.probe		=3D imx_keypad_probe,
>  	.remove		=3D __devexit_p(imx_keypad_remove),
> +	.suspend =3D mxc_kpp_suspend,
> +	.resume =3D mxc_kpp_resume,

Please use pm_ops.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
