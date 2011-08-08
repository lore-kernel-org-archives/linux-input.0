From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Mon, 8 Aug 2011 17:55:03 +0900
Message-ID: <20110808085459.GA12376@opensource.wolfsonmicro.com>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58533 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750821Ab1HHIzL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Aug 2011 04:55:11 -0400
Content-Disposition: inline
In-Reply-To: <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: dmitry.torokhov@gmail.com, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

On Mon, Aug 08, 2011 at 04:38:41PM +0800, Barry Song wrote:
> 2011/8/8 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> Without this patch, DT can still connect driver with device by the
> heuristic way(of_modalias_node).

Well, the other part of things is that it explicitly defines the
bindings (including qualification for the manufacturer, for Wolfson I
know we've got an occasional collision with chips from Wondermedia who
also use wm as a prefix for their part numbers).  The match tables
aren't particularly exciting in themselves but they're also very low
cost.

>=20
> i have a patch just like yours in input subsystem "[PATCH v2] input:
> touchscreen: add OF match table for ads7846" with "Acked-by: Grant
> Likely", but Dmitry seems to just ignore it.
>=20
> so not sure whether this kind of new added match tables are totally
> liked by people or not.
>=20
> > ---
> > =A0Documentation/devicetree/bindings/sound/wm8753.txt | =A0 18 ++++=
++++++++++++++
> > =A0sound/soc/codecs/wm8753.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 =A09 +++++++++
> > =A02 files changed, 27 insertions(+), 0 deletions(-)
> > =A0create mode 100644 Documentation/devicetree/bindings/sound/wm875=
3.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/wm8753.txt b/D=
ocumentation/devicetree/bindings/sound/wm8753.txt
> > new file mode 100644
> > index 0000000..e65277a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/wm8753.txt
> > @@ -0,0 +1,18 @@
> > +WM8753 audio CODEC
> > +
> > +This device supports both I2C and SPI (configured with pin strappi=
ng
> > +on the board).
> > +
> > +Required properties:
> > +
> > + =A0- compatible : "wlf,wm8753"
> > +
> > + =A0- reg : the I2C address of the device for I2C, the chip select
> > + =A0 =A0 =A0 =A0 =A0number for SPI.
> > +
> > +Example:
> > +
> > +codec: wm8737@1a {
> > + =A0 =A0 =A0 compatible =3D "wlf,wm8753";
> > + =A0 =A0 =A0 reg =3D <0x1a>;
> > +};
> > diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
> > index a702550..fe04a10 100644
> > --- a/sound/soc/codecs/wm8753.c
> > +++ b/sound/soc/codecs/wm8753.c
> > @@ -38,6 +38,7 @@
> > =A0#include <linux/delay.h>
> > =A0#include <linux/pm.h>
> > =A0#include <linux/i2c.h>
> > +#include <linux/of_device.h>
> > =A0#include <linux/platform_device.h>
> > =A0#include <linux/spi/spi.h>
> > =A0#include <linux/slab.h>
> > @@ -1490,6 +1491,12 @@ static struct snd_soc_codec_driver soc_codec=
_dev_wm8753 =3D {
> > =A0 =A0 =A0 =A0.reg_cache_default =3D wm8753_reg,
> > =A0};
> >
> > +static const struct of_device_id wm8753_of_match[] =3D {
> > + =A0 =A0 =A0 { .compatible =3D "wlf,wm8753", },
> > + =A0 =A0 =A0 { }
> > +};
> > +MODULE_DEVICE_TABLE(of, wm8753_of_match);
> > +
> > =A0#if defined(CONFIG_SPI_MASTER)
> > =A0static int __devinit wm8753_spi_probe(struct spi_device *spi)
> > =A0{
> > @@ -1521,6 +1528,7 @@ static struct spi_driver wm8753_spi_driver =3D=
 {
> > =A0 =A0 =A0 =A0.driver =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "wm8753",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D wm8753_of_match,
> > =A0 =A0 =A0 =A0},
> > =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D wm8753_spi_probe,
> > =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(wm8753_spi_r=
emove),
> > @@ -1565,6 +1573,7 @@ static struct i2c_driver wm8753_i2c_driver =3D=
 {
> > =A0 =A0 =A0 =A0.driver =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "wm8753",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D wm8753_of_match,
> > =A0 =A0 =A0 =A0},
> > =A0 =A0 =A0 =A0.probe =3D =A0 =A0wm8753_i2c_probe,
> > =A0 =A0 =A0 =A0.remove =3D =A0 __devexit_p(wm8753_i2c_remove),
> > --
> > 1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
