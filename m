From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Tue, 17 Sep 2013 09:33:08 +0200
Message-ID: <201309170933.08505.jbe@pengutronix.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <52359259.8010202@kernel.org> <20130916152846.GC12105@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130916152846.GC12105-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Monday 16 September 2013 17:28:46 Dmitry Torokhov wrote:
> [...]
> > >  static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
> > > @@ -641,6 +1056,7 @@ static void mxs_lradc_ts_unregister(struct
> > > mxs_lradc *lradc)
> > >
> > >  	cancel_work_sync(&lradc->ts_work);
> > >
> > > +	mxs_lradc_disable_ts(lradc);
> > >  	input_unregister_device(lradc->ts_input);
> > >  }
>
> This looks iffy... Normally you disable the device so that it does no=
t
> generate more interrupts, and then cancel outstanding work(s), otherw=
ise
> newly generated interrupts may cause more work to be scheduled. Or I
> missed some of the context and this is not a concern here?

This part gets removed in patch 6/6:

@@ -1054,8 +891,6 @@ static void mxs_lradc_ts_unregister(struct mxs_lra=
dc *lradc)
=A0=A0=A0=A0=A0=A0=A0=A0if (!lradc->use_touchscreen)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
=A0
-=A0=A0=A0=A0=A0=A0=A0cancel_work_sync(&lradc->ts_work);
-
=A0=A0=A0=A0=A0=A0=A0=A0mxs_lradc_disable_ts(lradc);
=A0=A0=A0=A0=A0=A0=A0=A0input_unregister_device(lradc->ts_input);
=A0}

But you are right, I should move this into patch 5/6.

Thanks

Regards,
Juergen

--=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengut=
ronix.de/  |
