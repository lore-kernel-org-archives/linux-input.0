From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v3] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Wed, 27 Jan 2010 16:29:19 +0100
Message-ID: <1264606159.2463.81.camel@realization>
References: <1264586106.2463.23.camel@realization>
	 <19296.5728.557535.920849@ipc1.ka-ro>
	 <1264594452.2463.62.camel@realization>
	 <19296.12024.559688.606548@ipc1.ka-ro>
	 <1264603193.2463.75.camel@realization>
	 <19296.21298.394254.553268@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:6739 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab0A0P3Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2010 10:29:25 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1524691eyd.19
        for <linux-input@vger.kernel.org>; Wed, 27 Jan 2010 07:29:24 -0800 (PST)
In-Reply-To: <19296.21298.394254.553268@ipc1.ka-ro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-input <linux-input@vger.kernel.org>, H Hartley Sweeten <hartleys@visionengravers.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On mer, 2010-01-27 at 15:52 +0100, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Alberto Panizzo writes:
> > On mer, 2010-01-27 at 13:18 +0100, Lothar Wa=C3=9Fmann wrote:
> > > Hi,
> > >=20
> > > Alberto Panizzo writes:
> > > > > > +	irq =3D platform_get_irq(pdev, 0);
> > > > > > +	if (irq < 0) {
> > > > > > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > > > > > +		return -ENXIO;
> > > > > > +	}
> > > > > >
> > > > > This should be -ENODEV.
> > > > >=20
> > > > Lot of reference keyboard driver use -ENXIO..
> > > > May should be better: return irq ?
> > > >=20
> > > Yes, of course. If a function returns an error code that should b=
e
> > > promoted to the caller instead of inventing a new error code.
> > >=20
> > >=20
> > > Lothar Wa=C3=9Fmann
> >=20
> > But, errno.h say:
> > #define ENXIO           6                // Device not configured
> > #define ENODEV          19               // Operation not supported=
 by device
> >=20
> What errno.h file is that?
> I have:
> ./include/asm-generic/errno-base.h:#define      ENXIO            6   =
   /* No such device or address */
> ./include/asm-generic/errno-base.h:#define      ENODEV          19   =
   /* No such device */
>=20
> AFAIK ENXIO is used when actual I/O has been attempted. But in this
> case the driver is still being configured and did not do any I/O yet.
>=20
>=20
> Lothar Wa=C3=9Fmann

The errno.h that I propose is a googled one and the kernel-one do not e=
xplain well..
Not for fighting, I wont understand.

In drivers/base/platform.c:

/**
 * platform_get_irq - get an IRQ for a device
 * @dev: platform device
 * @num: IRQ number index
 */
int platform_get_irq(struct platform_device *dev, unsigned int num)
{
	struct resource *r =3D platform_get_resource(dev, IORESOURCE_IRQ, num)=
;

	return r ? r->start : -ENXIO;
}

If there isn't the irq resource asked platform_get_irq return ENXIO.

Alberto

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
