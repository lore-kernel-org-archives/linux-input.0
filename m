From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Mon, 16 Sep 2013 16:23:48 +0200
Message-ID: <201309161623.48247.marex@denx.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <52359259.8010202@kernel.org> <201309161010.22151.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201309161010.22151.jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Otavio Salvador <otavio.salvador-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Dear J=FCrgen Beisert,

> Hi Jonathan,
>=20
> On Sunday 15 September 2013 12:56:25 Jonathan Cameron wrote:
> > On 09/11/13 09:18, Juergen Beisert wrote:
> > > For battery driven systems it is a very bad idea to collect the
> > > touchscreen data within a kernel busy loop.
> > >=20
> > > This change uses the features of the hardware to delay and accumu=
late
> > > samples in hardware to avoid a high interrupt and CPU load.
> > >=20
> > > Note: this is only tested on an i.MX23 SoC yet.
> > >=20
> > > Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > > CC: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
> > > CC: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > > CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > CC: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> >=20
> > While this driver is placed in IIO within staging at the moment, th=
ese
> > changes are definitely input related.  Hence I have cc'd Dmitry and=
 the
> > input list.
> >=20
> > I am personaly a little uncomfortable that we have such a complex b=
it of
> > input code sat within an IIO driver but such is life.
>=20
> Maybe an MFD for this ADC unit would be a better way to go? Currently=
 I
> have a different problem with this driver, because the ADC unit monit=
ors
> the battery as well. And the charging driver from the power subsystem
> needs these values to charge the battery in a correct manner.

Are you planning to post the power block patches too ?

Best regards,
Marek Vasut
