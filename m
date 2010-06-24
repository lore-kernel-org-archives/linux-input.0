From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input/imx_keypad: add PM support
Date: Thu, 24 Jun 2010 09:39:07 -0700
Message-ID: <20100624163907.GB25119@core.coreip.homeip.net>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39789 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015Ab0FXQjN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jun 2010 12:39:13 -0400
Received: by pvg2 with SMTP id 2so433936pvg.19
        for <linux-input@vger.kernel.org>; Thu, 24 Jun 2010 09:39:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1276801147-4103-1-git-send-email-eric@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: maramaopercheseimorto@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 17, 2010 at 08:59:01PM +0200, Eric B=E9nard wrote:
> We use keypad_data to enable wakeup from platform data
>=20
> suspend/resume is tested on an i.MX27 when keypad is not
> in use and when it's is in use (in which case we immediatly
> get the key pressed at wakeup)
>=20
> Signed-off-by: Eric B=E9nard <eric@eukrea.com>
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

This is not correct. imx_keypad_probe() keypad->enabled =3D false, wait=
ing for
imx_keypad_open() to be called. However if nobody opens the device and
you go through suspend/resume cycle you'll leave keypad->enabled =3D tr=
ue.


BTW, why do you call new functions mxc_kpp_XXX  while the rest of the
driver uses imx_keypad_XXX naming?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
