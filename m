From: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [RFC/PATCH 1/3] drivers: input: keyboard: adp5589: add DT support
Date: Mon, 2 Jun 2014 12:36:45 -0300
Message-ID: <20140602153645.GA26073@fox>
References: <1399467644-27222-1-git-send-email-guido@vanguardiasur.com.ar>
 <1399467644-27222-2-git-send-email-guido@vanguardiasur.com.ar>
 <20140518204009.GB13276@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140518204009.GB13276-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry, sorry for the terribly late reply.

On Sun, May 18, 2014 at 01:40:09PM -0700, Dmitry Torokhov wrote:
> Hi Guido,
>=20
> On Wed, May 07, 2014 at 10:00:42AM -0300, Guido Mart=EDnez wrote:
> > Add DT support for the Analog ADP5589 matrix keypad decoding functi=
ons.
> >=20
> > Signed-off-by: Guido Mart=EDnez <guido-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
> > ---
> >  drivers/input/keyboard/adp5589-keys.c | 207 ++++++++++++++++++++++=
+++++++++++-
> >  1 file changed, 206 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/=
keyboard/adp5589-keys.c
> > index 6329549..2b232c0 100644
> > --- a/drivers/input/keyboard/adp5589-keys.c
> > +++ b/drivers/input/keyboard/adp5589-keys.c
> > @@ -18,7 +18,10 @@
> >  #include <linux/i2c.h>
> >  #include <linux/gpio.h>
> >  #include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/err.h>
> > =20
> > +#include <linux/input/matrix_keypad.h>
> >  #include <linux/input/adp5589.h>
> > =20
> >  /* ADP5589/ADP5585 Common Registers */
> > @@ -246,6 +249,14 @@ struct adp5589_kpad {
> >  #endif
> >  };
> > =20
> > +static struct of_device_id adp5589_of_match[] =3D {
> > +	{
> > +		.compatible =3D "adi,adp5589",
> > +		.data =3D (void *)ADP5589
> > +	},
> > +	{ },
> > +};
> > +
> >  /*
> >   *  ADP5589 / ADP5585 derivative / variant handling
> >   */
> > @@ -858,6 +869,188 @@ static void adp5589_report_switch_state(struc=
t adp5589_kpad *kpad)
> >  	input_sync(kpad->input);
> >  }
> > =20
> > +#ifdef CONFIG_OF
> > +static int adp5589_key(int row, int col)
> > +{
> > +	return col + row * 11;
> > +}
> > +
> > +static int adp5589_dt_read_keymap(struct device *dev,
> > +				  struct adp5589_kpad_platform_data *pdata,
> > +				  const struct device_node *node)
> > +{
> > +	int i;
> > +	const u32 *dt_keymap;
> > +	unsigned short *keymap;
> > +	int keymap_len;
> > +
> > +	dt_keymap =3D of_get_property(node, "linux,keymap", &keymap_len);
> > +	if (!dt_keymap) {
> > +		dev_err(dev, "missing dt keymap\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (keymap_len % sizeof(u32)) {
> > +		dev_err(dev, "malformed keymap (len=3D%i)\n", keymap_len);
> > +		return -EINVAL;
> > +	}
> > +
> > +	keymap_len /=3D sizeof(u32);
> > +
> > +	keymap =3D devm_kzalloc(dev, ADP5589_KEYMAPSIZE * sizeof(u32),
> > +			      GFP_KERNEL);
> > +	if (!keymap)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < keymap_len; i++) {
> > +		u32 val;
> > +		u16 key;
> > +		u8 row, col;
> > +
> > +		val =3D be32_to_cpup(&dt_keymap[i]);
> > +
> > +		row =3D KEY_ROW(val);
> > +		col =3D KEY_COL(val);
> > +		key =3D KEY_VAL(val);
> > +
> > +		if (row > ADP5589_MAX_ROW_NUM) {
> > +			dev_err(dev, "invalid row number (%i)\n", row);
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (col > ADP5589_MAX_COL_NUM) {
> > +			dev_err(dev, "invalid column number (%i)\n", col);
> > +			return -EINVAL;
> > +		}
> > +
> > +		pdata->keypad_en_mask |=3D ADP_ROW(row);
> > +		pdata->keypad_en_mask |=3D ADP_COL(col);
> > +
> > +		keymap[adp5589_key(row, col)] =3D key;
> > +	}
> > +
> > +	pdata->keymap =3D keymap;
> > +	pdata->keymapsize =3D ADP5589_KEYMAPSIZE;
>=20
> I was wondering if we could also move non-DT variant to matrix-keypad
> infrastructure and use matrix_keypad_build_keymap and friends to hand=
le
> this uniformly.

Seems like a good idea, I'll look into it.

Thanks for reviewing this!

--=20
Guido Mart=EDnez, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
