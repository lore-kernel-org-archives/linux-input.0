From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Mon, 16 Sep 2013 10:38:13 +0200
Message-ID: <201309161038.13977.jbe@pengutronix.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <52359259.8010202@kernel.org> <5235DBEA.7030402@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5235DBEA.7030402-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Jonathan,

On Sunday 15 September 2013 18:10:18 Jonathan Cameron wrote:
> On 09/15/13 11:56, Jonathan Cameron wrote:
> > On 09/11/13 09:18, Juergen Beisert wrote:
> >> For battery driven systems it is a very bad idea to collect the
> >> touchscreen data within a kernel busy loop.
> >>
> >> This change uses the features of the hardware to delay and accumul=
ate
> >> samples in hardware to avoid a high interrupt and CPU load.
> >>
> >> Note: this is only tested on an i.MX23 SoC yet.
> >>
> >> Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >> CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> >> CC: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
> >> CC: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> >> CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >> CC: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> >
> > While this driver is placed in IIO within staging at the moment, th=
ese
> > changes are definitely input related.  Hence I have cc'd Dmitry and=
 the
> > input list.
> >
> > I am personaly a little uncomfortable that we have such a complex b=
it of
> > input code sat within an IIO driver but such is life.
>
> The logic in here looks reasonable to me. I am far from a specialist =
in how
> these touch screens are normally handled though.
>
> One thing to note is that you really want to get a proposed device tr=
ee
> spec out asap as that can take longer to review than the driver.  If =
you
> are proposing to do that as a future patch, then take into account th=
at
> you'll need to ensure these are the defaults if it is not specified i=
n the
> device tree for ever more (which is more painful than hammering out h=
e
> device tree stuff now!)
> ...

Will do.

Regards,
Juergen

--=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengut=
ronix.de/  |
