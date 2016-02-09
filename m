From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 4/8] mfd: fsl imx25 Touchscreen ADC driver
Date: Tue, 9 Feb 2016 10:35:13 +0000
Message-ID: <20160209103513.GC24522@x1>
References: <1450101234-2191-1-git-send-email-mpa@pengutronix.de>
 <1450101234-2191-5-git-send-email-mpa@pengutronix.de>
 <20160111065441.GW3331@x1>
 <6151166.y0HMDdqtvF@adelgunde>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6151166.y0HMDdqtvF@adelgunde>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 02 Feb 2016, Markus Pargmann wrote:

> Hi,
>=20
> On Monday, January 11, 2016 06:54:41 AM Lee Jones wrote:
> > On Mon, 14 Dec 2015, Markus Pargmann wrote:
> >=20
> > > This is the core driver for imx25 touchscreen/adc driver. The mod=
ule
> > > has one shared ADC and two different conversion queues which use =
the
> > > ADC. The two queues are identical. Both can be used for general p=
urpose
> > > ADC but one is meant to be used for touchscreens.
> > >=20
> > > This driver is the core which manages the central components and
> > > registers of the TSC/ADC unit. It manages the IRQs and forwards t=
hem to
> > > the correct components.
> > >=20
> > > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> > >=20
> > > [ensure correct ADC clock depending on the IPG clock]
> > > Signed-off-by: Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > ---
> > >=20
> > > Notes:
> > >     Changes in v7:
> > >      - Cleanup bit defines in header files to be more readable
> > >      - Fix irq check to return with an error for irq <=3D 0
> > >      - Add COMPILE_TEST in Kconfig file
> > >    =20
> > >     Changes in v5:
> > >      - Remove ifdef CONFIG_OF as this driver is only for DT usage
> > >      - Remove module owner
> > >      - Add Kconfig dependencies ARCH_MX25 and OF
> > >=20
> > >  drivers/mfd/Kconfig             |   9 ++
> > >  drivers/mfd/Makefile            |   2 +
> > >  drivers/mfd/fsl-imx25-tsadc.c   | 203 ++++++++++++++++++++++++++=
++++++++++++++
> > >  include/linux/mfd/imx25-tsadc.h | 140 ++++++++++++++++++++++++++=
+
> > >  4 files changed, 354 insertions(+)
> > >  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
> > >  create mode 100644 include/linux/mfd/imx25-tsadc.h
> >=20
> > For my own reference:
> >   Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >=20
> > I will apply this and sent out pull-requests to the relevant
> > maintainers once -rc1 is out.
>=20
> Thanks. Do you mean just this patch or the whole series?

I will take all of the /driver patches.  The ARM patches need to go in
through ARM-SoC via the relevant sub-arch maintainer(s).

> Shall I resend the whole series to fix the commit title of the first
> patch?

No, that's fine.  I'll handle that *this time*.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
