From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: am335x: IIO/ADC fixes if used together with TSC, v2
Date: Wed, 8 Jan 2014 08:08:54 +0000
Message-ID: <20140108080854.GB19974@lee--X1>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
 <20140107085456.GD3182@lee--X1>
 <20140108080359.GA16527@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140108080359.GA16527-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> > Dmitry, Jonathan,
> >=20
> > This is for you.
> >=20
> > The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503=
d79e42ae:
> >=20
> >   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.linaro.org/people/ljones/mfd.git tags/ib-iio-input-3.13=
-1
> >=20
> > for you to fetch changes up to 7ca6740cd1cd410828a01151a044b51910d0=
6eff:
> >=20
> >   mfd: input: iio: ti_amm335x: Rework TSC/ADC synchronization (2014=
-01-07 08:45:00 +0000)
> >=20
> > ----------------------------------------------------------------
> > Immutable branch for IIO and Input
> >=20
> > ----------------------------------------------------------------
> > Sebastian Andrzej Siewior (5):
> >       iio: ti_am335x_adc: Adjust the closing bracket in tiadc_read_=
raw()
> >       mfd: ti_am335x_tscadc: Make am335x_tsc_se_update() local
> >       mfd: ti_am335x_tscadc: Don't read back REG_SE
> >       mfd: ti_am335x: Drop am335x_tsc_se_update() from resume path
> >       mfd: input: iio: ti_amm335x: Rework TSC/ADC synchronization
> >=20
> >  drivers/iio/adc/ti_am335x_adc.c           | 68 +++++++++++++++++++=
++++++++++++++++++++++++++++++-------------------
> >  drivers/input/touchscreen/ti_am335x_tsc.c |  4 ++--
> >  drivers/mfd/ti_am335x_tscadc.c            | 71 +++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++-----------
> >  include/linux/mfd/ti_am335x_tscadc.h      |  8 ++++++--
> >  4 files changed, 117 insertions(+), 34 deletions(-)
>=20
> I do not have any pending changes to ti_am335x_tsc.c so it can all go
> through Jonathan's tree.

Well the patches are going through my tree, but in case either of you
have any changes to the above files you can merge this and Git will do
the rest during the merge-window. If neither of you do then no need to
pull. :)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
