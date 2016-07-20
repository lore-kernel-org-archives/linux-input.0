From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tsc200x - Report proper input_dev name
Date: Wed, 20 Jul 2016 10:04:12 -0700
Message-ID: <20160720170412.GC25655@dtor-ws>
References: <20160720014424.GI19250@dtor-ws>
 <20160720065405.GD3792@amd>
 <20160720164503.GB25655@dtor-ws>
 <201607201856.51367@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201607201856.51367@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, sre@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 20, 2016 at 06:56:51PM +0200, Pali Roh=E1r wrote:
> On Wednesday 20 July 2016 18:45:03 Dmitry Torokhov wrote:
> > On Wed, Jul 20, 2016 at 08:54:05AM +0200, Pavel Machek wrote:
> > > On Wed 2016-07-20 01:50:24, Michael Welling wrote:
> > > > On Wed, Jul 20, 2016 at 08:31:06AM +0200, Pavel Machek wrote:
> > > > > Hi!
> > > > >=20
> > > > > > Passes input_id struct to the the common probe function for
> > > > > > the tsc200x drivers instead of just the bustype.
> > > > > >=20
> > > > > > This allows for the use of the product variable to set the
> > > > > > input_dev->name variable according to the type of
> > > > > > touchscreen used.
> > > > > >=20
> > > > > > Signed-off-by: Michael Welling <mwelling@ieee.org>
> > > > > > ---
> > > > > >=20
> > > > > >  drivers/input/touchscreen/tsc2004.c      | 7 ++++++-
> > > > > >  drivers/input/touchscreen/tsc2005.c      | 7 ++++++-
> > > > > >  drivers/input/touchscreen/tsc200x-core.c | 7 ++++---
> > > > > >  drivers/input/touchscreen/tsc200x-core.h | 2 +-
> > > > > >  4 files changed, 17 insertions(+), 6 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/input/touchscreen/tsc2004.c
> > > > > > b/drivers/input/touchscreen/tsc2004.c index 7295c19..6fe55d=
5
> > > > > > 100644
> > > > > > --- a/drivers/input/touchscreen/tsc2004.c
> > > > > > +++ b/drivers/input/touchscreen/tsc2004.c
> > > > > > @@ -22,6 +22,11 @@
> > > > > >=20
> > > > > >  #include <linux/regmap.h>
> > > > > >  #include "tsc200x-core.h"
> > > > > >=20
> > > > > > +static const struct input_id tsc2004_input_id =3D {
> > > > > > +	.bustype =3D BUS_I2C,
> > > > > > +	.product =3D 2004,
> > > > > > +};
> > > > > > +
> > > > > >=20
> > > > > >  static int tsc2004_cmd(struct device *dev, u8 cmd)
> > > > > >  {
> > > > > > =20
> > > > > >  	u8 tx =3D TSC200X_CMD | TSC200X_CMD_12BIT | cmd;
> > > > > >=20
> > > > > > @@ -42,7 +47,7 @@ static int tsc2004_probe(struct i2c_clien=
t
> > > > > > *i2c,
> > > > > >=20
> > > > > >  			 const struct i2c_device_id *id)
> > > > > > =20
> > > > > >  {
> > > > > >=20
> > > > > > -	return tsc200x_probe(&i2c->dev, i2c->irq, BUS_I2C,
> > > > > > +	return tsc200x_probe(&i2c->dev, i2c->irq,
> > > > > > &tsc2004_input_id,
> > > > > >=20
> > > > > >  			     devm_regmap_init_i2c(i2c,
> > > > > >  			     &tsc200x_regmap_config),
> > > > > >  			     tsc2004_cmd);
> > > > > > =20
> > > > > >  }
> > > > > >=20
> > > > > > diff --git a/drivers/input/touchscreen/tsc2005.c
> > > > > > b/drivers/input/touchscreen/tsc2005.c index b9f593d..f2c5f0=
e
> > > > > > 100644
> > > > > > --- a/drivers/input/touchscreen/tsc2005.c
> > > > > > +++ b/drivers/input/touchscreen/tsc2005.c
> > > > > > @@ -24,6 +24,11 @@
> > > > > >=20
> > > > > >  #include <linux/regmap.h>
> > > > > >  #include "tsc200x-core.h"
> > > > > >=20
> > > > > > +static const struct input_id tsc2005_input_id =3D {
> > > > > > +	.bustype =3D BUS_SPI,
> > > > > > +	.product =3D 2005,
> > > > > > +};
> > > > > > +
> > > > > >=20
> > > > > >  static int tsc2005_cmd(struct device *dev, u8 cmd)
> > > > > >  {
> > > > > > =20
> > > > > >  	u8 tx =3D TSC200X_CMD | TSC200X_CMD_12BIT | cmd;
> > > > > >=20
> > > > > > @@ -62,7 +67,7 @@ static int tsc2005_probe(struct spi_devic=
e
> > > > > > *spi)
> > > > > >=20
> > > > > >  	if (error)
> > > > > >  =09
> > > > > >  		return error;
> > > > > >=20
> > > > > > -	return tsc200x_probe(&spi->dev, spi->irq, BUS_SPI,
> > > > > > +	return tsc200x_probe(&spi->dev, spi->irq,
> > > > > > &tsc2005_input_id,
> > > > > >=20
> > > > > >  			     devm_regmap_init_spi(spi,
> > > > > >  			     &tsc200x_regmap_config),
> > > > > >  			     tsc2005_cmd);
> > > > > > =20
> > > > > >  }
> > > > > >=20
> > > > > > diff --git a/drivers/input/touchscreen/tsc200x-core.c
> > > > > > b/drivers/input/touchscreen/tsc200x-core.c index
> > > > > > 26e81d1b..5e625c4 100644
> > > > > > --- a/drivers/input/touchscreen/tsc200x-core.c
> > > > > > +++ b/drivers/input/touchscreen/tsc200x-core.c
> > > > > > @@ -450,7 +450,7 @@ static void tsc200x_close(struct
> > > > > > input_dev *input)
> > > > > >=20
> > > > > >  	mutex_unlock(&ts->mutex);
> > > > > > =20
> > > > > >  }
> > > > > >=20
> > > > > > -int tsc200x_probe(struct device *dev, int irq, __u16
> > > > > > bustype, +int tsc200x_probe(struct device *dev, int irq,
> > > > > > const struct input_id *tsc_id,
> > > > > >=20
> > > > > >  		  struct regmap *regmap,
> > > > > >  		  int (*tsc200x_cmd)(struct device *dev, u8 cmd))
> > > > > > =20
> > > > > >  {
> > > > > >=20
> > > > > > @@ -547,9 +547,10 @@ int tsc200x_probe(struct device *dev,
> > > > > > int irq, __u16 bustype,
> > > > > >=20
> > > > > >  	snprintf(ts->phys, sizeof(ts->phys),
> > > > > >  =09
> > > > > >  		 "%s/input-ts", dev_name(dev));
> > > > > >=20
> > > > > > -	input_dev->name =3D "TSC200X touchscreen";
> > > > > > +	input_dev->name =3D devm_kasprintf(dev, GFP_KERNEL, "TSC%=
04d
> > > > > > touchscreen", +					tsc_id->product);
> > > > >=20
> > > > > What about:
> > > > >      if (tsc_id->product =3D=3D 2005)
> > > > >     =20
> > > > >           input_dev->name =3D "TSC2005 touchscreen";
> > > > >     =20
> > > > >      else
> > > > >     =20
> > > > >           input_dev->name =3D "TSC200X touchscreen";
> > > > >=20
> > > > > We do want to use 'TSC2005' name for TSC2005, because
> > > > > compatibility, but you should keep TSC200X.... because
> > > > > compatibility. You don't want to break people's setups by
> > > > > going from TSC200X to TSC2004.
> > > >=20
> > > > By same logic we shouldn't change from TSC200X back to TSC2005
> > > > because of people's possibly new setup in the last 9 months.
> > >=20
> > > That's your, broken logic.
> > >=20
> > > TSC200X->TSC2005 needs to be fixed, because people seen the TSC20=
05
> > > for past few years.
> >=20
> > People might have also seen  TSC2005->TSC200X for the last few
> > months. They could be dependent on this now and start complaining
> > once we revert.
>=20
> They could. But did it? Is there real breakage of real existing=20
> applications which are in use? I doubt. But there is for opposite=20
> scenario.
>=20
> Older applications (like Maemo mce) worked with older kernel version,=
=20
> but not with new due to this change TSC2005->TSC200X.
>=20
> So I still think this is a regression, which should be fixed...

OK, fine, let's keep 200X for 2004, and real number for everyone else.

Thanks.

--=20
Dmitry
