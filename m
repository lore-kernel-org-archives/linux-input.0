From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: rotary_encoder - fix device tree error
 handling
Date: Sat, 16 Jan 2016 11:02:43 -0800
Message-ID: <20160116190243.GE9203@dtor-ws>
References: <1452890030-23316-1-git-send-email-timo.teras@iki.fi>
 <1452890030-23316-2-git-send-email-timo.teras@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36637 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbcAPTCq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jan 2016 14:02:46 -0500
Received: by mail-pa0-f51.google.com with SMTP id yy13so318866443pab.3
        for <linux-input@vger.kernel.org>; Sat, 16 Jan 2016 11:02:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452890030-23316-2-git-send-email-timo.teras@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Timo =?iso-8859-1?Q?Ter=E4s?= <timo.teras@iki.fi>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Timo,

On Fri, Jan 15, 2016 at 10:33:49PM +0200, Timo Ter=E4s wrote:
> of_get_gpio_flags() can fail, so pass through the error code
> properly. Most important use case is when it returns EPROBE_DEFER
> so that the probe gets called again later.
>=20
> Signed-off-by: Timo Ter=E4s <timo.teras@iki.fi>
> ---
>  drivers/input/misc/rotary_encoder.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc=
/rotary_encoder.c
> index 0f23d32..156f40f 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -206,7 +206,7 @@ static struct rotary_encoder_platform_data *rotar=
y_encoder_parse_dt(struct devic
>  	struct device_node *np =3D dev->of_node;
>  	struct rotary_encoder_platform_data *pdata;
>  	enum of_gpio_flags flags;
> -	int error;
> +	int ret;

I strongly prefer variables holding error codes and not being returned
to caller in success path to be called "error".

> =20
>  	if (!of_id || !np)
>  		return NULL;
> @@ -219,19 +219,25 @@ static struct rotary_encoder_platform_data *rot=
ary_encoder_parse_dt(struct devic
>  	of_property_read_u32(np, "rotary-encoder,steps", &pdata->steps);
>  	of_property_read_u32(np, "linux,axis", &pdata->axis);
> =20
> -	pdata->gpio_a =3D of_get_gpio_flags(np, 0, &flags);
> +	ret =3D of_get_gpio_flags(np, 0, &flags);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +	pdata->gpio_a =3D ret;

Instead of doing this maybe we could switch to gpiod interface that
handles polarity internally and does not depend on OF? The only issue i=
s
that we have a few board files in tree that use raw gpio numbers so
we'll need to convert them...

Thanks.

>  	pdata->inverted_a =3D flags & OF_GPIO_ACTIVE_LOW;
> =20
> -	pdata->gpio_b =3D of_get_gpio_flags(np, 1, &flags);
> +	ret =3D of_get_gpio_flags(np, 1, &flags);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +	pdata->gpio_b =3D ret;
>  	pdata->inverted_b =3D flags & OF_GPIO_ACTIVE_LOW;
> =20
>  	pdata->relative_axis =3D
>  		of_property_read_bool(np, "rotary-encoder,relative-axis");
>  	pdata->rollover =3D of_property_read_bool(np, "rotary-encoder,rollo=
ver");
> =20
> -	error =3D of_property_read_u32(np, "rotary-encoder,steps-per-period=
",
> -				     &pdata->steps_per_period);
> -	if (error) {
> +	ret =3D of_property_read_u32(np, "rotary-encoder,steps-per-period",
> +				   &pdata->steps_per_period);
> +	if (ret) {
>  		/*
>  		 * The 'half-period' property has been deprecated, you must use
>  		 * 'steps-per-period' and set an appropriate value, but we still
> --=20
> 2.7.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
