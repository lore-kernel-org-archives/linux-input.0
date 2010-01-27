From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v3] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Wed, 27 Jan 2010 18:42:33 +0100
Message-ID: <1264614153.2463.134.camel@realization>
References: <1264586106.2463.23.camel@realization>
	 <19296.5728.557535.920849@ipc1.ka-ro>
	 <1264594452.2463.62.camel@realization>
	 <19296.12024.559688.606548@ipc1.ka-ro>
	 <1264603193.2463.75.camel@realization>
	 <19296.21298.394254.553268@ipc1.ka-ro>
	 <1264606159.2463.81.camel@realization>
	 <19296.29180.633167.456022@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:51390 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab0A0Rmm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2010 12:42:42 -0500
Received: by ewy19 with SMTP id 19so707952ewy.21
        for <linux-input@vger.kernel.org>; Wed, 27 Jan 2010 09:42:41 -0800 (PST)
In-Reply-To: <19296.29180.633167.456022@ipc1.ka-ro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-input <linux-input@vger.kernel.org>, H Hartley Sweeten <hartleys@visionengravers.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,
On mer, 2010-01-27 at 18:03 +0100, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Alberto Panizzo writes:
> > On mer, 2010-01-27 at 15:52 +0100, Lothar Wa=C3=9Fmann wrote:
> > > Hi,
> > >=20
> > > Alberto Panizzo writes:
> > > > On mer, 2010-01-27 at 13:18 +0100, Lothar Wa=C3=9Fmann wrote:
> > > > > Hi,
> > > > >=20
> > > > > Alberto Panizzo writes:
> > > > > > > > +	irq =3D platform_get_irq(pdev, 0);
> > > > > > > > +	if (irq < 0) {
> > > > > > > > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > > > > > > > +		return -ENXIO;
> > > > > > > > +	}
> > > > > > > >
> > > > > > > This should be -ENODEV.
> > > > > > >=20
> > > > > > Lot of reference keyboard driver use -ENXIO..
> > > > > > May should be better: return irq ?
> > > > > >=20
> > > > > Yes, of course. If a function returns an error code that shou=
ld be
> > > > > promoted to the caller instead of inventing a new error code.
> > > > >=20
> > > > >=20
> > > > > Lothar Wa=C3=9Fmann
> > > >=20
> > > > But, errno.h say:
> > > > #define ENXIO           6                // Device not configur=
ed
> > > > #define ENODEV          19               // Operation not suppo=
rted by device
> > > >=20
> > > What errno.h file is that?
> > > I have:
> > > ./include/asm-generic/errno-base.h:#define      ENXIO            =
6      /* No such device or address */
> > > ./include/asm-generic/errno-base.h:#define      ENODEV          1=
9      /* No such device */
> > >=20
> > > AFAIK ENXIO is used when actual I/O has been attempted. But in th=
is
> > > case the driver is still being configured and did not do any I/O =
yet.
> > >=20
> > >=20
> > > Lothar Wa=C3=9Fmann
> >=20
> > The errno.h that I propose is a googled one and the kernel-one do n=
ot explain well..
> > Not for fighting, I wont understand.
> >=20
> > In drivers/base/platform.c:
> >=20
> > /**
> >  * platform_get_irq - get an IRQ for a device
> >  * @dev: platform device
> >  * @num: IRQ number index
> >  */
> > int platform_get_irq(struct platform_device *dev, unsigned int num)
> > {
> > 	struct resource *r =3D platform_get_resource(dev, IORESOURCE_IRQ, =
num);
> >=20
> > 	return r ? r->start : -ENXIO;
> > }
> >=20
> > If there isn't the irq resource asked platform_get_irq return ENXIO=
=2E
> >=20
> The POSIX spec says:
> |[ENXIO]
> |    No such device or address. Input or output on a special file
> |refers to a device that does not exist, or makes a request beyond th=
e
> |capabilities of the device. It may also occur when, for example, a
> |tape drive is not on-line.=20

And I am not doing any I/O, while I am requesting something that is bey=
ond
the capability defined in platform_data.

While=20
|[ENODEV]
|  No such device. An attempt was made to apply an inappropriate functi=
on=20
|to a device; for example, trying to read a write-only device such as a=
 printer.

And:
-the device is present (registered in the driver model)=20
-I am not trying to apply an inappropriate function..=20

Maybe the problem have to be attacked form another point of view:
Platform resources are parameters of the driver, the absence of IRQ and=
 IO mem
would be considered as wrong parameters so the error should be EINVAL.

>=20
> http://www.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_03=
=2Ehtml
>=20
Bookmarked!!!! :)


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
