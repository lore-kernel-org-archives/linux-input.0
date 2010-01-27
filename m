From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v3] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Wed, 27 Jan 2010 13:14:12 +0100
Message-ID: <1264594452.2463.62.camel@realization>
References: <1264586106.2463.23.camel@realization>
	 <19296.5728.557535.920849@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62586 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab0A0MOR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2010 07:14:17 -0500
Received: by ewy19 with SMTP id 19so365164ewy.21
        for <linux-input@vger.kernel.org>; Wed, 27 Jan 2010 04:14:15 -0800 (PST)
In-Reply-To: <19296.5728.557535.920849@ipc1.ka-ro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-input <linux-input@vger.kernel.org>, H Hartley Sweeten <hartleys@visionengravers.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Lothar,

On mer, 2010-01-27 at 11:33 +0100, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Alberto Panizzo writes:
> [...]
> > +#include <linux/input/matrix_keypad.h>
> > +
> > +#define MAX_MATRIX_KEY_ROWS	(8)
> > +#define MAX_MATRIX_KEY_COLS	(8)
> > +#define MATRIX_ROW_SHIFT	(3)
> > +
> pointless '()'

Ok.

> > [...]
> > +
> > +	/* Configure columns as output, rows as input (KDDR[15:0]) */
> > +	reg_val =3D readw(keypad->mmio_base + KDDR);
> > +	reg_val |=3D 0xff00;
> > +	reg_val &=3D 0xff00;
> >
> This is effectively the same as: 'reg_val =3D 0xff00;' which makes th=
e
> readw() above pointless. Was this really intended?
>=20
> > +	writew(reg_val, keypad->mmio_base + KDDR);

Yes, it should be instead:
	writew(0xff00, keypad->mmio_base + KDDR);


> > [...]
> > +	/* Sanity control, not all the rows must be to 0s now. */
> > +	if ((readw(keypad->mmio_base + KPDR) & keypad->rows_en_mask) =3D=3D=
 0) {
> > +		dev_err(&dev->dev, "Too much keys pressed for now, "
> > +				"control pins initialisation\n");
> >
> It helps grepping for a message, if it is not split into multiple
> lines.

Ok.

>=20
> > [...]
> > +
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > +		return -ENXIO;
> > +	}
> >
> This should be -ENODEV.
>=20
Lot of reference keyboard driver use -ENXIO..
May should be better: return irq ?

> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (res =3D=3D NULL) {
> > +		dev_err(&pdev->dev, "failed to get I/O memory\n");
> > +		return -ENXIO;
> >
> same as above.

same as above?


> > +
> > +	keypad->pdata =3D pdata;
> > +	keypad->input_dev =3D input_dev;
> > +	keypad->irq =3D irq;
> > +
> > +	keypad->mmio_base =3D ioremap(res->start, resource_size(res));
> > +	if (keypad->mmio_base =3D=3D NULL) {
> > +		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> > +		error =3D -ENXIO;
> >
> -ENOMEM;

Ok.
>=20
> > +		goto failed_free_priv;
> > +	}
> > +
> > +	keypad->clk =3D clk_get(NULL, "kpp");
> >
> clk_get(&pdev->dev, "kpp");
>=20
Ok.

Alberto!




--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
