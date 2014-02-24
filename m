From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver
 implementation
Date: Mon, 24 Feb 2014 15:26:58 +0100
Message-ID: <20140224142658.GD4436@piout.net>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <52CEA4AA.8050503@free-electrons.com>
 <201401100955.45885.jbe@pengutronix.de>
 <201402241416.24270.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201402241416.24270.jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Juergen,

On 24/02/2014 at 14:16:24 +0100, Juergen Beisert wrote :
> Hi Alexandre,
>=20
> > While I don't have much experience with the TS part of the code but=
 I
> > can investigate if you don't have any idea.
>=20
> can you please test the following patch?
> After releasing the touchscreen the internal state machine was left i=
n a
> wrong state.
>=20

This seems to solve the issue. You can send the patch with my Tested-by=
=2E

It is probably worth trying to get it in 3.14.

Thanks !

> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/ii=
o/adc/mxs-lradc.c
> index e2dd783..558a76c 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct m=
xs_lradc *lradc, bool valid)
>         }
>=20
>         /* if it is released, wait for the next touch via IRQ */
> +       lradc->cur_plate =3D LRADC_TOUCH;
>         mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRAD=
C_CTRL1);
>         mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRA=
DC_CTRL1);
>  }
>=20
> Regards,
> Juergen
>=20
> --=20
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
> Linux Solutions for Science and Industry =A0 =A0 =A0| Phone: +49-5121=
-206917-5128 |
> Peiner Str. 6-8, 31137 Hildesheim, Germany =A0 =A0| Fax: =A0 +49-5121=
-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 =A0 =A0| http://=
www.pengutronix.de/ =A0|

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
