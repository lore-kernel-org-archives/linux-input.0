From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/10] input: Enable STMPE keypad driver for Device Tree
Date: Thu, 11 Oct 2012 09:10:21 +0100
Message-ID: <20121011081021.GT9707@gmail.com>
References: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
 <1349451107-8009-8-git-send-email-lee.jones@linaro.org>
 <20121010165004.GE19335@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55764 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758198Ab2JKIK1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 04:10:27 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so780372bkc.19
        for <linux-input@vger.kernel.org>; Thu, 11 Oct 2012 01:10:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121010165004.GE19335@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, linux-input@vger.kernel.org

On Wed, 10 Oct 2012, Dmitry Torokhov wrote:

> Hi Lee,
>=20
> On Fri, Oct 05, 2012 at 04:31:43PM +0100, Lee Jones wrote:
> > This patch allows the STMPE driver to be successfully probed and
> > initialised when Device Tree support is enabled. Besides the usual
> > platform data changes, we also separate the process of filling in
> > the 'in use' pin bitmap, as we have to extract the information from
> > Device Tree in the DT boot case.
>=20
>=20
> This generally looks OK although I wonder if we could not unify DT an=
d
> non-DT case by doing:
>=20
> 	for (row =3D 0; row < STMPE_KEYPAD_MAX_ROWS; row++) {
> 		if (col =3D 0; col < STMPE_KEYPAD_MAX_COLS; col++) {
> 			int code =3D MATRIX_SCAN_CODE(row, col,
> 						STMPE_KEYPAD_ROW_SHIFT);
> 			if (keypad->keymap[code] !=3D KEY_RESERVED) {
> 				keypad->rows |=3D 1 << row;
> 				keypad->cols |=3D 1 << col;
> 			}
> 		}
> 	}

Looks like it could work. I have a quite a long TODO list at the
moment, but I will add testing this to it.

> BTW, am I supposed to merge it or ack it?

If you Ack it, I can carry it for you no problem.

> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/input/keyboard/stmpe-keypad.c |   67 +++++++++++++++++++++=
+++++++-----
> >  drivers/mfd/stmpe.c                   |    1 +
> >  2 files changed, 59 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/=
keyboard/stmpe-keypad.c
> > index 470a877..c722d23 100644
> > --- a/drivers/input/keyboard/stmpe-keypad.c
> > +++ b/drivers/input/keyboard/stmpe-keypad.c
> > @@ -257,19 +257,73 @@ static int __devinit stmpe_keypad_chip_init(s=
truct stmpe_keypad *keypad)
> >  			      (plat->debounce_ms << 1));
> >  }
> > =20
> > +static int stmpe_keypad_fill_used_pins(struct platform_device *pde=
v,
> > +				struct stmpe_keypad *keypad,
> > +				struct stmpe_keypad_platform_data *plat)
> > +{
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	unsigned int proplen;
> > +	const __be32 *prop;
> > +	int i;
> > +
> > +	if (np) {
> > +		prop =3D of_get_property(np, "linux,keymap", &proplen);
> > +		if (!prop) {
> > +			dev_err(&pdev->dev,
> > +				"linux,keymap property not defined\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		for (i =3D 0; i < proplen / sizeof(u32); i++) {
> > +			unsigned int key =3D be32_to_cpup(prop + i);
> > +
> > +			keypad->cols |=3D 1 << KEY_COL(key);
> > +			keypad->rows |=3D 1 << KEY_ROW(key);
> > +		}
> > +	} else {
> > +		for (i =3D 0; i < plat->keymap_data->keymap_size; i++) {
> > +			unsigned int key =3D plat->keymap_data->keymap[i];
> > +
> > +			keypad->cols |=3D 1 << KEY_COL(key);
> > +			keypad->rows |=3D 1 << KEY_ROW(key);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void __devinit stmpe_keypad_of_probe(struct device_node *np=
,
> > +				struct stmpe_keypad_platform_data *plat)
> > +{
> > +	of_property_read_u32(np, "debounce-interval", &plat->debounce_ms)=
;
> > +	of_property_read_u32(np, "stericsson,scan-count", &plat->scan_cou=
nt);
> > +
> > +	if (of_get_property(np, "stericsson,no-autorepeat", NULL))
> > +		plat->no_autorepeat =3D true;
> > +}
> > +
> >  static int __devinit stmpe_keypad_probe(struct platform_device *pd=
ev)
> >  {
> >  	struct stmpe *stmpe =3D dev_get_drvdata(pdev->dev.parent);
> >  	struct stmpe_keypad_platform_data *plat;
> > +	struct device_node *np =3D pdev->dev.of_node;
> >  	struct stmpe_keypad *keypad;
> >  	struct input_dev *input;
> >  	int ret;
> >  	int irq;
> > -	int i;
> > =20
> >  	plat =3D stmpe->pdata->keypad;
> > -	if (!plat)
> > -		return -ENODEV;
> > +	if (!plat) {
> > +		if (np) {
> > +			plat =3D devm_kzalloc(&pdev->dev,
> > +					sizeof(*plat), GFP_KERNEL);
> > +			if (!plat)
> > +				return -ENOMEM;
> > +
> > +			stmpe_keypad_of_probe(np, plat);
> > +		} else
> > +			return -ENODEV;
> > +	}
> > =20
> >  	irq =3D platform_get_irq(pdev, 0);
> >  	if (irq < 0)
> > @@ -300,12 +354,7 @@ static int __devinit stmpe_keypad_probe(struct=
 platform_device *pdev)
> >  	if (!plat->no_autorepeat)
> >  		__set_bit(EV_REP, input->evbit);
> > =20
> > -	for (i =3D 0; i < plat->keymap_data->keymap_size; i++) {
> > -		unsigned int key =3D plat->keymap_data->keymap[i];
> > -
> > -		keypad->cols |=3D 1 << KEY_COL(key);
> > -		keypad->rows |=3D 1 << KEY_ROW(key);
> > -	}
> > +	stmpe_keypad_fill_used_pins(pdev, keypad, plat);
> > =20
> >  	keypad->stmpe =3D stmpe;
> >  	keypad->plat =3D plat;
> > diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> > index ba157d4..b03cc64 100644
> > --- a/drivers/mfd/stmpe.c
> > +++ b/drivers/mfd/stmpe.c
> > @@ -321,6 +321,7 @@ static struct resource stmpe_keypad_resources[]=
 =3D {
> > =20
> >  static struct mfd_cell stmpe_keypad_cell =3D {
> >  	.name		=3D "stmpe-keypad",
> > +	.of_compatible  =3D "st,stmpe-keypad",
> >  	.resources	=3D stmpe_keypad_resources,
> >  	.num_resources	=3D ARRAY_SIZE(stmpe_keypad_resources),
> >  };
> > --=20
> > 1.7.9.5
> >=20
>=20
> --=20
> Dmitry

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
