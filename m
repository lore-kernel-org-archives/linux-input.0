From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: rotary-encoder: use request_any_context_irq and
 gpio_get_value_cansleep
Date: Thu, 7 Jan 2016 10:08:16 -0800
Message-ID: <20160107180816.GB12332@dtor-ws>
References: <1450896115-12422-1-git-send-email-timo.teras@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33385 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbcAGSIU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2016 13:08:20 -0500
Received: by mail-pa0-f48.google.com with SMTP id cy9so264303469pac.0
        for <linux-input@vger.kernel.org>; Thu, 07 Jan 2016 10:08:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1450896115-12422-1-git-send-email-timo.teras@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Timo =?iso-8859-1?Q?Ter=E4s?= <timo.teras@iki.fi>
Cc: linux-input@vger.kernel.org

On Wed, Dec 23, 2015 at 08:41:55PM +0200, Timo Ter=E4s wrote:
> This allows to use GPIO expanders behind I2C or SPI bus.
>=20
> Signed-off-by: Timo Ter=E4s <timo.teras@iki.fi>
> ---
>  drivers/input/misc/rotary_encoder.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc=
/rotary_encoder.c
> index 8aee719..8bedd7b 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -48,8 +48,8 @@ struct rotary_encoder {
> =20
>  static int rotary_encoder_get_state(const struct rotary_encoder_plat=
form_data *pdata)
>  {
> -	int a =3D !!gpio_get_value(pdata->gpio_a);
> -	int b =3D !!gpio_get_value(pdata->gpio_b);
> +	int a =3D !!gpio_get_value_cansleep(pdata->gpio_a);
> +	int b =3D !!gpio_get_value_cansleep(pdata->gpio_b);
> =20
>  	a ^=3D pdata->inverted_a;
>  	b ^=3D pdata->inverted_b;
> @@ -335,18 +335,18 @@ static int rotary_encoder_probe(struct platform=
_device *pdev)
>  		goto exit_free_gpio_b;
>  	}
> =20
> -	err =3D request_irq(encoder->irq_a, handler,
> -			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -			  DRV_NAME, encoder);
> -	if (err) {
> +	err =3D request_any_context_irq(encoder->irq_a, handler,
> +				      IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				      DRV_NAME, encoder);
> +	if (err < 0) {

This is wrong. If you are saying that you can use any context IRQ you
can get hard irq, but in rotary_encoder_get_state() (which is called
from IRQ handler) you are using sleeping gpio accessors.

I guess you need to explicitly request threaded IRQs.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
