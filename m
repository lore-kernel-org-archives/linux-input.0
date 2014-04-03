From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [patch v2] Input: edt-ft5x06 - add a missing condition
Date: Thu, 3 Apr 2014 08:40:29 +0200
Message-ID: <20140403084029.72b3a78c@ipc1.ka-ro>
References: <002101cf4eda$184e85b0$48eb9110$%han@samsung.com>
	<20140403013712.GA28270@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:56402 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162300AbaDCGkw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Apr 2014 02:40:52 -0400
In-Reply-To: <20140403013712.GA28270@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Fugang Duan <B38611@freescale.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi,

Dan Carpenter wrote:
> The if condition was accidentally deleted here so we return every tim=
e
> instead of returning on error.
>=20
> Fixes: fd335ab04b3f ('Input: edt-ft5x06 - add support for M09 firmwar=
e version')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: removed a stray tab character
>=20
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/t=
ouchscreen/edt-ft5x06.c
> index 75b666b..9d0b324 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -291,9 +291,10 @@ static int edt_ft5x06_register_read(struct edt_f=
t5x06_ts_data *tsdata,
>  		wrbuf[1] =3D tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
>  		wrbuf[1] |=3D tsdata->factory_mode ? 0x80 : 0x40;
> =20
> -		error =3D edt_ft5x06_ts_readwrite(tsdata->client,
> -						2, wrbuf, 2, rdbuf);
> -		return error;
> +		error =3D edt_ft5x06_ts_readwrite(tsdata->client, 2, wrbuf, 2,
> +						rdbuf);
> +		if (error)
> +			return error;
> =20
>  		if ((wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]) !=3D rdbuf[1]) {
>  			dev_err(&tsdata->client->dev,
>=20
Acked-By: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
