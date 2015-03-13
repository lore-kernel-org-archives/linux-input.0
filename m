From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] input: eglx_ts, remove irq trigger flags
Date: Fri, 13 Mar 2015 08:14:47 +0100
Message-ID: <20150313071447.GA16614@pengutronix.de>
References: <1426171816-26609-1-git-send-email-mpa@pengutronix.de>
 <1426173483.14455.73.camel@pengutronix.de>
 <20150312153701.GB13382@pengutronix.de>
 <20150312162813.GA4720@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150312162813.GA4720@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 09:28:13AM -0700, Dmitry Torokhov wrote:
> On Thu, Mar 12, 2015 at 04:37:01PM +0100, Markus Pargmann wrote:
> > Hi,
> >=20
> > On Thu, Mar 12, 2015 at 04:18:03PM +0100, Philipp Zabel wrote:
> > > Hi Markus,
> > >=20
> > > Am Donnerstag, den 12.03.2015, 15:50 +0100 schrieb Markus Pargmann:
> > > > The trigger settings for a given irq are parsed from DT. Defining t=
hem
> > > > as flag for devm_request_threaded_irq() overwrites these settings. =
This
> > > > results in wrong trigger settings for boards which have different i=
rq
> > > > triggers.
> > > >=20
> > > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > ---
> > > >  drivers/input/touchscreen/egalax_ts.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/=
touchscreen/egalax_ts.c
> > > > index 4c56299284ef..b0e6448b743c 100644
> > > > --- a/drivers/input/touchscreen/egalax_ts.c
> > > > +++ b/drivers/input/touchscreen/egalax_ts.c
> > > > @@ -218,7 +218,7 @@ static int egalax_ts_probe(struct i2c_client *c=
lient,
> > > > =20
> > > >  	error =3D devm_request_threaded_irq(&client->dev, client->irq, NU=
LL,
> > > >  					  egalax_ts_interrupt,
> > > > -					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > > > +					  IRQF_ONESHOT,
> > > >  					  "egalax_ts", ts);
> > > >  	if (error < 0) {
> > > >  		dev_err(&client->dev, "Failed to register interrupt\n");
> > >=20
> > > There are three device trees which have eeti,egalax_ts nodes with
> > > interrupt flags 0:
> > >=20
> > > arch/arm/boot/dts/imx53-tx53-x13x.dts (twice),
> > > arch/arm/boot/dts/imx6dl-tx6u-811x.dts, and
> > > arch/arm/boot/dts/imx6q-tx6q-1110.dts.
> > >=20
> > > Will these still work after this change?
> >=20
> > Oh right, thanks, these should be fixed as well.
>=20
> If by fixing you mean changing DTS I do not think we can do that. Maybe
> the driver should check if there is non-empty trigger flags in the
> interrupt description and fall back to IRQF_TRIGGER_LOW if they are
> absent.

I think this is more of a driver/dts bug. The devicetree binding
documentation for the egalax_ts [1] does not describe the interrupts
flags that should be set or that the flag should be 0. Even the example
shows the interrupt flags being '2'(trigger high-to-low edge). These
flags are described by the interrupt-controller. The generic
interrupt-controller bindings describe the second parameter for
interrupts as interrupt trigger flags [2].

So I think having a '0' as second parameter in the 'interrupts' field is a
wrong representation of the actual hardware. This of course works as
long as the driver ignores the trigger settings from DT which is not
specified in the bindings.

Best Regards,

Markus


[1] Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
[2] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAo5nAAoJEEpcgKtcEGQQed0P/0L/9QUZRjc+IcV5sDfjKwPt
9i2PVBNODXq0/cjvB//2+B3zK/YN9no3Iez56pwNHLdT04Taeqt0UJE6Zf4HJGSi
KNUSudmsMoqfKIllhIxEef0wduESDi5gw3Lcikhhvc66BCK31i42JETJzVpDeLTx
Gy8kh2+dB3KHp4wAmTW7aG3T7TtfqeLlS+oNWSoWu924Se97+nqnZ+eoYSXu0pXD
W+AODrp4HnviiRHusxidqvxseTRQ9JKUALrVTy8u6IgBSrUH4V4mJCU3oMCtw9rw
sVm/KqZoMQbNgojYGFFDqj3xphGHvFHhsNnsINCBptPjBfDf/W6wVfBdhxV2asW7
GfW7NIS+QTABlEKzkSihlWxrMie0UpF355SLyQ/P/XHaPYM8muvvO46XA2lSM4xF
6z27I/q5mYaiBU5QKAZDUugkt5jvjWgltjZnc6OCv5Ir/XpKYC+G0oBxTQMHCi8Z
5IlodGArJF4Cvpu/jKq9bnEG6ICLiMQGoqKlWJ8SnsGwayKZW3XgUriMYfOChItb
9JUFoIWanVlAh6udbrWNHqjqRXSlAdGCgChfqjG7NVb/SXrABiDrC0VxlrIXksA+
1NqeRNR25wCTHwwWatFoLuEXUIloO28QJ0Wgtt3QMM909lIS4QmAJsiwH5ggD3Yy
Ql+kQnXp8SlHglUUWihe
=1x84
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
