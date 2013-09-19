From: =?utf-8?q?J=C3=BCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Thu, 19 Sep 2013 14:49:37 +0200
Message-ID: <201309191449.37274.jbe@pengutronix.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <201309161010.22151.jbe@pengutronix.de> <0fb59809-c835-49b0-bd82-e791db1a9db7@email.android.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0fb59809-c835-49b0-bd82-e791db1a9db7-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Jonathan,

On Monday 16 September 2013 17:30:32 Jonathan Cameron wrote:
> >On Sunday 15 September 2013 12:56:25 Jonathan Cameron wrote:
> >> On 09/11/13 09:18, Juergen Beisert wrote:
> >> > For battery driven systems it is a very bad idea to collect the
> >> > touchscreen data within a kernel busy loop.
> >> >
> >> > This change uses the features of the hardware to delay and
> >> > accumulate samples in hardware to avoid a high interrupt and CPU=
 load.
> >> >
> >> > Note: this is only tested on an i.MX23 SoC yet.
> >> >
> >> > Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >> > CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> >> > CC: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
> >> > CC: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> >> > CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >> > CC: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> >>
> >> While this driver is placed in IIO within staging at the moment,
> >> these changes are definitely input related.  Hence I have cc'd Dmi=
try and
> >> the input list.
> >>
> >> I am personaly a little uncomfortable that we have such a complex =
bit
> >> of input code sat within an IIO driver but such is life.
> >
> > Maybe an MFD for this ADC unit would be a better way to go?
>
> That would be great and is definitely the preferred method.

Cannot continue to convert the driver into an MFD device. The project d=
oes not=20
give me the time to do so.

Regards,
Juergen

--=20
Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Juergen Beisert =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
Linux Solutions for Science and Industry =C2=A0 =C2=A0 =C2=A0| http://w=
ww.pengutronix.de/  |
