From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Mon, 24 Feb 2014 15:38:26 +0100
Message-ID: <201402241538.26530.jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <201402241416.24270.jbe@pengutronix.de> <20140224133316.GI26722@mwanda>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140224133316.GI26722@mwanda>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dan,

On Monday 24 February 2014 14:33:16 Dan Carpenter wrote:
> On Mon, Feb 24, 2014 at 02:16:24PM +0100, Juergen Beisert wrote:
> > > While I don't have much experience with the TS part of the code b=
ut I
> > > can investigate if you don't have any idea.
> >
> > can you please test the following patch?
> > After releasing the touchscreen the internal state machine was left=
 in a
> > wrong state.
> >
> > diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/=
iio/adc/mxs-lradc.c
> > index e2dd783..558a76c 100644
> > --- a/drivers/staging/iio/adc/mxs-lradc.c =20
> > +++ b/drivers/staging/iio/adc/mxs-lradc.c
> > @@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct
> > mxs_lradc *lradc, bool valid) }
> >
> >         /* if it is released, wait for the next touch via IRQ */
> > +       lradc->cur_plate =3D LRADC_TOUCH;
> >         mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LR=
ADC_CTRL1);
> >         mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, L=
RADC_CTRL1);
> >         }=20
>
> I am confused.  Why don't you send this like a normal patch?

=46or testing fist. But you are right, patch will follow.

Regards,
Juergen

--=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengut=
ronix.de/  |
