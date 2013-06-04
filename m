From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] input/ti_am335x_tsc: fold regbit_map() and simplfy
Date: Tue, 4 Jun 2013 09:53:11 -0700
Message-ID: <20130604165311.GG26400@core.coreip.homeip.net>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
 <1369847397-27451-4-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:37750 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab3FDQxP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Jun 2013 12:53:15 -0400
Content-Disposition: inline
In-Reply-To: <1369847397-27451-4-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, sameo@linux.intel.com, jic23@cam.ac.uk, balbi@ti.com

On Wed, May 29, 2013 at 07:09:54PM +0200, Sebastian Andrzej Siewior wro=
te:
> If we put the values which are looked up by regbit_map() directly in =
the
> config array then we can remove the function.
> And now when I look at it I don't understand why the array has to hav=
e
> two dimensions. One does it, too. And while at it, the description sa=
ys
> that AIN0 =E2=80=A6 AIN7 can be used so allow this.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c |   76 ++++++++-----------=
----------
>  1 file changed, 19 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/inpu=
t/touchscreen/ti_am335x_tsc.c
> index 7c97fc7..63cee57 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -37,15 +37,11 @@
>  #define TSCADC_DELTA_X		15
>  #define TSCADC_DELTA_Y		15
> =20
> -/*
> - * Refer to function regbit_map() to
> - * map the values in the matrix.
> - */
> -static int config[4][4] =3D {
> -		{1,	0,	1,	0},
> -		{2,	3,	2,	3},
> -		{4,	5,	4,	5},
> -		{0,	6,	0,	6}
> +static const int config_pins[] =3D {
> +		XPP,
> +		XNN,
> +		YPP,
> +		YNN,
>  };
> =20
>  struct titsc {
> @@ -79,45 +75,11 @@ static void titsc_writel(struct titsc *tsc, unsig=
ned int reg,
>  	regmap_write(tsc->mfd_tscadc->regmap_tscadc, reg, val);
>  }
> =20
> -/*
> - * Each of the analog lines are mapped
> - * with one or two register bits,
> - * which can be either pulled high/low
> - * depending on the value to be read.
> - */
> -static int regbit_map(int val)
> -{
> -	int map_bits =3D 0;
> -
> -	switch (val) {
> -	case 1:
> -		map_bits =3D XPP;
> -		break;
> -	case 2:
> -		map_bits =3D XNP;
> -		break;
> -	case 3:
> -		map_bits =3D XNN;
> -		break;
> -	case 4:
> -		map_bits =3D YPP;
> -		break;
> -	case 5:
> -		map_bits =3D YPN;
> -		break;
> -	case 6:
> -		map_bits =3D YNN;
> -		break;
> -	}
> -
> -	return map_bits;
> -}
> -
>  static int titsc_config_wires(struct titsc *ts_dev)
>  {
>  	u32 analog_line[4];
>  	u32 wire_order[4];
> -	int i, temp_bits;
> +	int i, bit_cfg;
> =20
>  	for (i =3D 0; i < 4; i++) {
>  		/*
> @@ -126,9 +88,9 @@ static int titsc_config_wires(struct titsc *ts_dev=
)
>  		 */
>  		analog_line[i] =3D (ts_dev->config_inp[i] & 0xF0) >> 4;
>  		wire_order[i] =3D ts_dev->config_inp[i] & 0x0F;
> -		if (WARN_ON(analog_line[i] > 4))
> +		if (WARN_ON(analog_line[i] > 7))
>  				return -EINVAL;
> -		if (WARN_ON(wire_order[i] > 4))
> +		if (WARN_ON(wire_order[i] > ARRAY_SIZE(config_pins)))
>  				return -EINVAL;
>  	}
> =20
> @@ -138,27 +100,27 @@ static int titsc_config_wires(struct titsc *ts_=
dev)
> =20
>  		an_line =3D analog_line[i];
>  		wi_order =3D wire_order[i];
> -		temp_bits =3D config[an_line][wi_order];
> -		if (temp_bits =3D=3D 0)
> +		bit_cfg =3D config_pins[wi_order];
> +		if (bit_cfg =3D=3D 0)
>  			return -EINVAL;
> -		switch (wire_order[i]) {
> +		switch (wi_order) {
>  		case 0:
> -			ts_dev->bit_xp =3D regbit_map(temp_bits);
> -			ts_dev->inp_xp =3D analog_line[i];
> +			ts_dev->bit_xp =3D bit_cfg;
> +			ts_dev->inp_xp =3D an_line;
>  			break;
> =20
>  		case 1:
> -			ts_dev->bit_xn =3D regbit_map(temp_bits);
> -			ts_dev->inp_xn =3D analog_line[i];
> +			ts_dev->bit_xn =3D bit_cfg;
> +			ts_dev->inp_xn =3D an_line;
>  			break;
> =20
>  		case 2:
> -			ts_dev->bit_yp =3D regbit_map(temp_bits);
> -			ts_dev->inp_yp =3D analog_line[i];
> +			ts_dev->bit_yp =3D bit_cfg;
> +			ts_dev->inp_yp =3D an_line;
>  			break;
>  		case 3:
> -			ts_dev->bit_yn =3D regbit_map(temp_bits);
> -			ts_dev->inp_yn =3D analog_line[i];
> +			ts_dev->bit_yn =3D bit_cfg;
> +			ts_dev->inp_yn =3D an_line;
>  			break;
>  		}
>  	}
> --=20
> 1.7.10.4
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
