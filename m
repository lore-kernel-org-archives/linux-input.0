From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] tsc2007: make platform callbacks optional
Date: Mon, 13 Jul 2009 21:17:59 -0700
Message-ID: <20090714041759.GA2822@dtor-d630.eng.vmware.com>
References: <4A40C28E.1070109@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f185.google.com ([209.85.216.185]:52710 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbZGNESH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 00:18:07 -0400
Content-Disposition: inline
In-Reply-To: <4A40C28E.1070109@mocean-labs.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

Hi Richard,

On Tue, Jun 23, 2009 at 01:54:54PM +0200, Richard R=F6jfors wrote:
> The platform callbacks are only called if supplied. Makes the driver
> to fallback on only pressure calculation to decide when the pen is up=
=2E
>=20
> Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com=
>
> ---
> Index: linux-2.6.30/drivers/input/touchscreen/tsc2007.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.30/drivers/input/touchscreen/tsc2007.c	(revision 943)
> +++ linux-2.6.30/drivers/input/touchscreen/tsc2007.c	(revision 945)
> @@ -59,6 +59,10 @@
>  #define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
>  #define PWRDOWN		(TSC2007_12BIT | TSC2007_POWER_OFF_IRQ_EN)
>=20
> +#define PEN_STATE_UP	0x00
> +#define PEN_STATE_DOWN	0x01
> +#define PEN_STATE_IRQ	0x01

Why the last 2 are the same?

> +
>  struct ts_event {
>  	u16	x;
>  	u16	y;
> @@ -76,7 +80,7 @@
>  	u16			model;
>  	u16			x_plate_ohms;
>=20
> -	unsigned		pendown;
> +	unsigned		penstate;
>  	int			irq;
>=20
>  	int			(*get_pendown_state)(void);
> @@ -149,15 +153,18 @@
>  	 *
>  	 * The only safe way to check for the pen up condition is in the
>  	 * work function by reading the pen signal state (it's a GPIO and I=
RQ).
> +	 *
> +	 * But sadly we don't always have the possibility to use such callb=
ack
> +	 * in that case rely on the pressure anyway
>  	 */
>  	if (rt) {
>  		struct input_dev *input =3D ts->input;
>=20
> -		if (!ts->pendown) {
> +		if (ts->penstate !=3D PEN_STATE_DOWN) {
>  			dev_dbg(&ts->client->dev, "DOWN\n");
>=20
>  			input_report_key(input, BTN_TOUCH, 1);
> -			ts->pendown =3D 1;
> +			ts->penstate =3D PEN_STATE_DOWN;
>  		}
>=20
>  		input_report_abs(input, ABS_X, x);
> @@ -168,7 +175,9 @@
>=20
>  		dev_dbg(&ts->client->dev, "point(%4d,%4d), pressure (%4u)\n",
>  			x, y, rt);
> -	}
> +	} else if (!ts->get_pendown_state)
> +		/* no callback to check pendown state, use pressure */
> +		ts->penstate =3D PEN_STATE_UP;
>=20

Since we are not going to re-check pen state why don't we report "pen
up" event here right away and forego rescheduling the work?

>  	schedule_delayed_work(&ts->work, TS_POLL_PERIOD);
>  }

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
