From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] Input: gpio_keys_polled - defer probing if GPIO probing
 is deferred
Date: Sun, 23 Dec 2012 18:51:05 +0100
Message-ID: <50D74489.2030000@openwrt.org>
References: <1356251523-28359-1-git-send-email-juhosg@openwrt.org> <20121223100625.GB17407@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:33862 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599Ab2LWRvF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Dec 2012 12:51:05 -0500
In-Reply-To: <20121223100625.GB17407@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alexandre Pereira da Silva <aletes.xgr@gmail.com>, stable@vger.kernel.org

2012.12.23. 11:06 keltez=E9ssel, Dmitry Torokhov =EDrta:

> Well spotted, thanks. However I think the patch should look like the =
one
> below as we should propagate all errors, not only -EPROBE_DEFER, up t=
he
> stack.
>=20
> Thanks.
>=20
>=20
> Input: gpio_keys_polled - defer probing if GPIO probing is deferred
>=20
> From: Gabor Juhos <juhosg@openwrt.org>
>=20
> If GPIO probing is deferred, the driver tries to claim an invalid GPI=
O line
> which leads to an error message like this:
>=20
>   gpio-keys-polled buttons.2: unable to claim gpio 4294966779, err=3D=
-22
>   gpio-keys-polled: probe of buttons.2 failed with error -22
>=20
> The patch ensures that error code returned by of_get_gpio_flags (incl=
uding
> -EPROBE_DEFER) is propagated up the stack.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/gpio_keys_polled.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/inpu=
t/keyboard/gpio_keys_polled.c
> index f686fd9..e75ca6b 100644
> --- a/drivers/input/keyboard/gpio_keys_polled.c
> +++ b/drivers/input/keyboard/gpio_keys_polled.c
> @@ -135,6 +135,7 @@ static struct gpio_keys_platform_data *gpio_keys_=
polled_get_devtree_pdata(struct
> =20
>  	i =3D 0;
>  	for_each_child_of_node(node, pp) {
> +		int gpio;
>  		enum of_gpio_flags flags;
> =20
>  		if (!of_find_property(pp, "gpios", NULL)) {
> @@ -143,9 +144,19 @@ static struct gpio_keys_platform_data *gpio_keys=
_polled_get_devtree_pdata(struct
>  			continue;
>  		}
> =20
> +		gpio =3D of_get_gpio_flags(pp, 0, &flags);
> +		if (gpio < 0) {
> +			error =3D gpio;
> +			if (error !=3D -EPROBE_DEFER)
> +				dev_err(dev,
> +					"Failed to get gpio flags, error: %d\n",
> +					error);
> +			goto err_free_pdata;
> +		}
> +
>  		button =3D &pdata->buttons[i++];
> =20
> -		button->gpio =3D of_get_gpio_flags(pp, 0, &flags);
> +		button->gpio =3D gpio;
>  		button->active_low =3D flags & OF_GPIO_ACTIVE_LOW;
> =20
>  		if (of_property_read_u32(pp, "linux,code", &button->code)) {

Yes, this looks saner. I have replaced my patch with this, and it is wo=
rking as
intended. The kernel says this:

platform buttons.2: Driver gpio-keys-polled requests probe deferral

BTW, it seems that the gpio-keys driver needs a similar fix.

-Gabor
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
