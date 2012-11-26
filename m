From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] Input: bu21013_ts - Request a regulator that
 actually exists
Date: Mon, 26 Nov 2012 12:16:18 +0000
Message-ID: <20121126121618.GL12782@gmail.com>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37516 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab2KZMQX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 07:16:23 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4521953bkw.19
        for <linux-input@vger.kernel.org>; Mon, 26 Nov 2012 04:16:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352900837-20759-2-git-send-email-lee.jones@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, 14 Nov 2012, Lee Jones wrote:

> Currently the BU21013 Touch Screen driver requests a regulator by the
> name of 'V-TOUCH', which doesn't exist anywhere in the kernel. The
> correct name, as referenced in platform regulator code is 'avdd'. Her=
e,
> when we request a regulator, we use the correct name instead.
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/input/touchscreen/bu21013_ts.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/t=
ouchscreen/bu21013_ts.c
> index 5c487d2..2fae682 100644
> --- a/drivers/input/touchscreen/bu21013_ts.c
> +++ b/drivers/input/touchscreen/bu21013_ts.c
> @@ -461,7 +461,7 @@ static int __devinit bu21013_probe(struct i2c_cli=
ent *client,
>  	bu21013_data->chip =3D pdata;
>  	bu21013_data->client =3D client;
> =20
> -	bu21013_data->regulator =3D regulator_get(&client->dev, "V-TOUCH");
> +	bu21013_data->regulator =3D regulator_get(&client->dev, "avdd");
>  	if (IS_ERR(bu21013_data->regulator)) {
>  		dev_err(&client->dev, "regulator_get failed\n");
>  		error =3D PTR_ERR(bu21013_data->regulator);
> --=20
> 1.7.9.5

Did you see this one also Dmitry?

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
