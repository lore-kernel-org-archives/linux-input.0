From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: adp5588 - add support for gpio names
Date: Mon, 9 Jan 2012 11:22:26 -0800
Message-ID: <20120109192226.GA15158@core.coreip.homeip.net>
References: <1326136527-31447-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51976 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932851Ab2AITWc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 14:22:32 -0500
Received: by iaeh11 with SMTP id h11so7011001iae.19
        for <linux-input@vger.kernel.org>; Mon, 09 Jan 2012 11:22:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326136527-31447-1-git-send-email-jeff.dagenais@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Dagenais <jeff.dagenais@gmail.com>
Cc: linux-input@vger.kernel.org, Michael.Hennerich@analog.com

On Mon, Jan 09, 2012 at 02:15:26PM -0500, Jean-Fran=E7ois Dagenais wrot=
e:
>=20
> Signed-off-by: Jean-Fran=E7ois Dagenais <jeff.dagenais@gmail.com>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/input/keyboard/adp5588-keys.c |    1 +
>  include/linux/i2c/adp5588.h           |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/ke=
yboard/adp5588-keys.c
> index e34eeb8..6412ced 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -197,6 +197,7 @@ static int __devinit adp5588_gpio_add(struct adp5=
588_kpad *kpad)
>  	kpad->gc.base =3D gpio_data->gpio_start;
>  	kpad->gc.label =3D kpad->client->name;
>  	kpad->gc.owner =3D THIS_MODULE;
> +	kpad->gc.names =3D gpio_data->names;
> =20
>  	mutex_init(&kpad->gpio_lock);
> =20
> diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.=
h
> index cec17cf..d8341cb 100644
> --- a/include/linux/i2c/adp5588.h
> +++ b/include/linux/i2c/adp5588.h
> @@ -157,6 +157,7 @@ struct i2c_client; /* forward declaration */
> =20
>  struct adp5588_gpio_platform_data {
>  	int gpio_start;		/* GPIO Chip base # */
> +	const char *const *names;

I think it is 1 const too much - you won't be able to use non-statioc
initialization...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
