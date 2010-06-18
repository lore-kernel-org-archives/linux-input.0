From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v2] input/imx_keypad: add PM support
Date: Fri, 18 Jun 2010 12:16:26 +0200
Message-ID: <1276856186.3146.5.camel@realization>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:47711 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0FRKQd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 06:16:33 -0400
Received: by wwb22 with SMTP id 22so5645wwb.19
        for <linux-input@vger.kernel.org>; Fri, 18 Jun 2010 03:16:31 -0700 (PDT)
In-Reply-To: <1276801147-4103-1-git-send-email-eric@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Eric,

On gio, 2010-06-17 at 20:59 +0200, Eric B=C3=A9nard wrote:
> We use keypad_data to enable wakeup from platform data
>=20
> suspend/resume is tested on an i.MX27 when keypad is not
> in use and when it's is in use (in which case we immediatly
> get the key pressed at wakeup)
>=20
> Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
> Cc: maramaopercheseimorto@gmail.com
> Cc: linux-input@vger.kernel.org
> Cc: dmitry.torokhov@gmail.com
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> v2 :
> 	- simplify suspend & resume functions
> 	- convert to pm_ops
>=20
>  drivers/input/keyboard/imx_keypad.c |   40 +++++++++++++++++++++++++=
++++++++-
>  1 files changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyb=
oard/imx_keypad.c
> index d92c15c..9aa0005 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -364,6 +364,38 @@ static void imx_keypad_inhibit(struct imx_keypad=
 *keypad)
>  	writew(0xff00, keypad->mmio_base + KPCR);
>  }
> =20
> +#ifdef CONFIG_PM
> +static int mxc_kpp_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct imx_keypad *keypad =3D platform_get_drvdata(pdev);
> +
> +	keypad->enabled =3D false;
> +	synchronize_irq(keypad->irq);
> +	disable_irq(keypad->irq);
> +	clk_disable(keypad->clk);
> +
> +	return 0;
> +}
> +
> +static int mxc_kpp_resume(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct imx_keypad *keypad =3D platform_get_drvdata(pdev);
> +
> +	keypad->enabled =3D true;
> +	clk_enable(keypad->clk);
> +	enable_irq(keypad->irq);
> +
> +	return 0;
> +}

Ok, so with this patch the keypad cannot wake the system?
It is scheduled another patch?


--=20
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
