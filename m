From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v3] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Wed, 27 Jan 2010 18:03:56 +0100
Message-ID: <19296.29180.633167.456022@ipc1.ka-ro>
References: <1264586106.2463.23.camel@realization>
	<19296.5728.557535.920849@ipc1.ka-ro>
	<1264594452.2463.62.camel@realization>
	<19296.12024.559688.606548@ipc1.ka-ro>
	<1264603193.2463.75.camel@realization>
	<19296.21298.394254.553268@ipc1.ka-ro>
	<1264606159.2463.81.camel@realization>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:58846 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704Ab0A0REA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2010 12:04:00 -0500
In-Reply-To: <1264606159.2463.81.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, H Hartley Sweeten <hartleys@visionengravers.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,

Alberto Panizzo writes:
> On mer, 2010-01-27 at 15:52 +0100, Lothar Wa=DFmann wrote:
> > Hi,
> >=20
> > Alberto Panizzo writes:
> > > On mer, 2010-01-27 at 13:18 +0100, Lothar Wa=DFmann wrote:
> > > > Hi,
> > > >=20
> > > > Alberto Panizzo writes:
> > > > > > > +	irq =3D platform_get_irq(pdev, 0);
> > > > > > > +	if (irq < 0) {
> > > > > > > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > > > > > > +		return -ENXIO;
> > > > > > > +	}
> > > > > > >
> > > > > > This should be -ENODEV.
> > > > > >=20
> > > > > Lot of reference keyboard driver use -ENXIO..
> > > > > May should be better: return irq ?
> > > > >=20
> > > > Yes, of course. If a function returns an error code that should=
 be
> > > > promoted to the caller instead of inventing a new error code.
> > > >=20
> > > >=20
> > > > Lothar Wa=DFmann
> > >=20
> > > But, errno.h say:
> > > #define ENXIO           6                // Device not configured
> > > #define ENODEV          19               // Operation not support=
ed by device
> > >=20
> > What errno.h file is that?
> > I have:
> > ./include/asm-generic/errno-base.h:#define      ENXIO            6 =
     /* No such device or address */
> > ./include/asm-generic/errno-base.h:#define      ENODEV          19 =
     /* No such device */
> >=20
> > AFAIK ENXIO is used when actual I/O has been attempted. But in this
> > case the driver is still being configured and did not do any I/O ye=
t.
> >=20
> >=20
> > Lothar Wa=DFmann
>=20
> The errno.h that I propose is a googled one and the kernel-one do not=
 explain well..
> Not for fighting, I wont understand.
>=20
> In drivers/base/platform.c:
>=20
> /**
>  * platform_get_irq - get an IRQ for a device
>  * @dev: platform device
>  * @num: IRQ number index
>  */
> int platform_get_irq(struct platform_device *dev, unsigned int num)
> {
> 	struct resource *r =3D platform_get_resource(dev, IORESOURCE_IRQ, nu=
m);
>=20
> 	return r ? r->start : -ENXIO;
> }
>=20
> If there isn't the irq resource asked platform_get_irq return ENXIO.
>=20
The POSIX spec says:
|[ENXIO]
|    No such device or address. Input or output on a special file
|refers to a device that does not exist, or makes a request beyond the
|capabilities of the device. It may also occur when, for example, a
|tape drive is not on-line.=20

http://www.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_03.h=
tml


Lothar Wa=DFmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
