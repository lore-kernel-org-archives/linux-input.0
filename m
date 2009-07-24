From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] tsc2007: reduced number of I2C transfers
Date: Fri, 24 Jul 2009 11:00:22 -0700
Message-ID: <20090724180022.GA6477@dtor-d630.eng.vmware.com>
References: <4A69DDED.50402@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:64098 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbZGXSAa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2009 14:00:30 -0400
Content-Disposition: inline
In-Reply-To: <4A69DDED.50402@mocean-labs.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>

On Fri, Jul 24, 2009 at 06:14:37PM +0200, Richard R=F6jfors wrote:
> Decreases the number of I2C transactions transferred by the driver.
> During probe we don't need to ask for the coordinates from the contro=
ller.
> When polling the controller we don't need to power down and enable IR=
Q =20
> if we are going to poll again.
>
> Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com=
>
> ---
> Index: linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 10=
40)
> +++ linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 10=
53)
> @@ -178,6 +178,12 @@
>  		ts->penstate =3D PEN_STATE_UP;
>  }
>
> +static void tsc2007_power_down(struct tsc2007 *tsc)
> +{
> +	/* power down */
> +	tsc2007_xfer(tsc, PWRDOWN);
> +}
> +
>  static int tsc2007_read_values(struct tsc2007 *tsc)
>  {
>  	/* y- still on; turn on only y+ (and ADC) */
> @@ -188,11 +194,8 @@
>
>  	/* turn y+ off, x- on; we'll use formula #1 */
>  	tsc->tc.z1 =3D tsc2007_xfer(tsc, READ_Z1);
> -	tsc->tc.z2 =3D tsc2007_xfer(tsc, READ_Z2);
> +	tsc->tc.z2 =3D tsc2007_xfer(tsc, READ_Z2 | TSC2007_POWER_OFF_IRQ_EN=
);

I think this leaves the controller powered on and with with PENIRQ
disabled.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
