From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] Input: Make ADS7846 independent on regulator
Date: Wed, 6 Oct 2010 19:16:05 +0200
Message-ID: <AANLkTindRMOmo8CrFuUsWqNRn6CZVKOMQZS2LXJ63=YC@mail.gmail.com>
References: <1280555108-27994-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58882 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab0JFRQH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Oct 2010 13:16:07 -0400
In-Reply-To: <1280555108-27994-1-git-send-email-marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, vapier@gentoo.org, pavel@ucw.cz, akpm@linux-foundation.org, khilman@deeprootsystems.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, eric.y.miao@gmail.com

2010/7/31 Marek Vasut <marek.vasut@gmail.com>:

> This fixes a problem on some Sharp Zaurus devices, where there is no =
regulator
> present and yet the touchscreen is used.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> =A0drivers/input/touchscreen/ads7846.c | =A0 50 +++++++++++++++++++++=
++------------
> =A01 files changed, 33 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touc=
hscreen/ads7846.c
> index a9fdf55..dafaef6 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -791,7 +791,10 @@ static void ads7846_disable(struct ads7846 *ts)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 regulator_disable(ts->reg);
> +#ifdef CONFIG_REGULATOR

Skip the #ifdef, if the regulators are configured out, there will be
a stub providing NULL for all get_regulator() calls anyway.

> + =A0 =A0 =A0 if (ts->reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_disable(ts->reg);
> +#endif
>
> =A0 =A0 =A0 =A0/* we know the chip's in lowpower mode since we always
> =A0 =A0 =A0 =A0 * leave it that way after every request
> @@ -804,7 +807,10 @@ static void ads7846_enable(struct ads7846 *ts)
> =A0 =A0 =A0 =A0if (!ts->disabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 regulator_enable(ts->reg);
> +#ifdef CONFIG_REGULATOR

Skip the #ifdef.

> + =A0 =A0 =A0 if (ts->reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_enable(ts->reg);
> +#endif
>
> =A0 =A0 =A0 =A0ts->disabled =3D 0;
> =A0 =A0 =A0 =A0ts->irq_disabled =3D 0;
> @@ -1161,18 +1167,21 @@ static int __devinit ads7846_probe(struct spi=
_device *spi)
>
> =A0 =A0 =A0 =A0ts->last_msg =3D m;
>
> +#ifdef CONFIG_REGULATOR

Skip the #ifdef.

> =A0 =A0 =A0 =A0ts->reg =3D regulator_get(&spi->dev, "vcc");
> - =A0 =A0 =A0 if (IS_ERR(ts->reg)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(ts->reg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "unable to get regul=
ator: %d\n", err);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_gpio;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 err =3D regulator_enable(ts->reg);
> - =A0 =A0 =A0 if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "unable to enable re=
gulator: %d\n", err);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_put_regulator;
> + =A0 =A0 =A0 if (IS_ERR(ts->reg))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->reg =3D NULL;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D regulator_enable(ts->reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "una=
ble to enable regulator: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_put_regulator;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> +#else
> + =A0 =A0 =A0 ts->reg =3D NULL;
> +#endif

Delete the #else/#endif clause entirely.

>
> =A0 =A0 =A0 =A0if (request_irq(spi->irq, ads7846_irq, IRQF_TRIGGER_FA=
LLING,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi->dev.driver->name,=
 ts)) {
> @@ -1218,10 +1227,13 @@ static int __devinit ads7846_probe(struct spi=
_device *spi)
> =A0err_free_irq:
> =A0 =A0 =A0 =A0free_irq(spi->irq, ts);
> =A0err_disable_regulator:
> - =A0 =A0 =A0 regulator_disable(ts->reg);
> +#ifdef CONFIG_REGULATOR

Skip the #ifdef.

> + =A0 =A0 =A0 if (ts->reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_disable(ts->reg);
> =A0err_put_regulator:
> - =A0 =A0 =A0 regulator_put(ts->reg);
> - err_free_gpio:
> + =A0 =A0 =A0 if (ts->reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_put(ts->reg);
> +#endif
> =A0 =A0 =A0 =A0if (ts->gpio_pendown !=3D -1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(ts->gpio_pendown);
> =A0err_cleanup_filter:
> @@ -1251,8 +1263,12 @@ static int __devexit ads7846_remove(struct spi=
_device *spi)
> =A0 =A0 =A0 =A0/* suspend left the IRQ disabled */
> =A0 =A0 =A0 =A0enable_irq(ts->spi->irq);
>
> - =A0 =A0 =A0 regulator_disable(ts->reg);
> - =A0 =A0 =A0 regulator_put(ts->reg);
> +#ifdef CONFIG_REGULATOR

Skip the #ifdef.

> + =A0 =A0 =A0 if (ts->reg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_disable(ts->reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_put(ts->reg);
> + =A0 =A0 =A0 }
> +#endif
>
> =A0 =A0 =A0 =A0if (ts->gpio_pendown !=3D -1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(ts->gpio_pendown);
> --
> 1.7.1

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
