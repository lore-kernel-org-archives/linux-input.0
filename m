From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] input: eglx_ts, remove irq trigger flags
Date: Tue, 24 Mar 2015 11:46:03 +0100
Message-ID: <20150324104603.GA28604@pengutronix.de>
References: <1426171816-26609-1-git-send-email-mpa@pengutronix.de>
 <1426173483.14455.73.camel@pengutronix.de>
 <20150312153701.GB13382@pengutronix.de>
 <20150312162813.GA4720@dtor-ws>
 <20150313071447.GA16614@pengutronix.de>
 <20150318165003.GA11485@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150318165003.GA11485@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2015 at 09:50:03AM -0700, Dmitry Torokhov wrote:
> On Fri, Mar 13, 2015 at 08:14:47AM +0100, Markus Pargmann wrote:
> > On Thu, Mar 12, 2015 at 09:28:13AM -0700, Dmitry Torokhov wrote:
> > > On Thu, Mar 12, 2015 at 04:37:01PM +0100, Markus Pargmann wrote:
> > > > Hi,
> > > >=20
> > > > On Thu, Mar 12, 2015 at 04:18:03PM +0100, Philipp Zabel wrote:
> > > > > Hi Markus,
> > > > >=20
> > > > > Am Donnerstag, den 12.03.2015, 15:50 +0100 schrieb Markus Pargman=
n:
> > > > > > The trigger settings for a given irq are parsed from DT. Defini=
ng them
> > > > > > as flag for devm_request_threaded_irq() overwrites these settin=
gs. This
> > > > > > results in wrong trigger settings for boards which have differe=
nt irq
> > > > > > triggers.
> > > > > >=20
> > > > > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > > > ---
> > > > > >  drivers/input/touchscreen/egalax_ts.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/in=
put/touchscreen/egalax_ts.c
> > > > > > index 4c56299284ef..b0e6448b743c 100644
> > > > > > --- a/drivers/input/touchscreen/egalax_ts.c
> > > > > > +++ b/drivers/input/touchscreen/egalax_ts.c
> > > > > > @@ -218,7 +218,7 @@ static int egalax_ts_probe(struct i2c_clien=
t *client,
> > > > > > =20
> > > > > >  	error =3D devm_request_threaded_irq(&client->dev, client->irq=
, NULL,
> > > > > >  					  egalax_ts_interrupt,
> > > > > > -					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > > > > > +					  IRQF_ONESHOT,
> > > > > >  					  "egalax_ts", ts);
> > > > > >  	if (error < 0) {
> > > > > >  		dev_err(&client->dev, "Failed to register interrupt\n");
> > > > >=20
> > > > > There are three device trees which have eeti,egalax_ts nodes with
> > > > > interrupt flags 0:
> > > > >=20
> > > > > arch/arm/boot/dts/imx53-tx53-x13x.dts (twice),
> > > > > arch/arm/boot/dts/imx6dl-tx6u-811x.dts, and
> > > > > arch/arm/boot/dts/imx6q-tx6q-1110.dts.
> > > > >=20
> > > > > Will these still work after this change?
> > > >=20
> > > > Oh right, thanks, these should be fixed as well.
> > >=20
> > > If by fixing you mean changing DTS I do not think we can do that. May=
be
> > > the driver should check if there is non-empty trigger flags in the
> > > interrupt description and fall back to IRQF_TRIGGER_LOW if they are
> > > absent.
> >=20
> > I think this is more of a driver/dts bug. The devicetree binding
> > documentation for the egalax_ts [1] does not describe the interrupts
> > flags that should be set or that the flag should be 0. Even the example
> > shows the interrupt flags being '2'(trigger high-to-low edge). These
> > flags are described by the interrupt-controller. The generic
> > interrupt-controller bindings describe the second parameter for
> > interrupts as interrupt trigger flags [2].
> >=20
> > So I think having a '0' as second parameter in the 'interrupts' field i=
s a
> > wrong representation of the actual hardware. This of course works as
> > long as the driver ignores the trigger settings from DT which is not
> > specified in the bindings.
>=20
> The point is that we should not break boards with existing DTS. Yes, DTS
> may be wrong, not optimal, whatever, but if it used to work we need to
> keep it working.

I don't really like this as this wrong behaviour is not defined in the
binding. However I will add a check for an empty interrupt trigger to
not break the old DTS files.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEUBrAAoJEEpcgKtcEGQQNSoQAIs825bF/5aKWQ+AHkB/4LuZ
E25s7Jk3VL9rvr6fE8coDiyibDUnv0CF40cSTztoJOXfF5kuISroBQKibQ9fvoPj
cK7/IJqCDZiqP78s6436ADk9cs/GqCWTFO+N127i6PhbJAKJ6e03Z/Znt4H6BOtj
H6p9P2dWl4K+sF3ikA2Ou7kc/R3CSzzUXHJ+BOwZZ0M2VMb9mACZ1RqoKXQp9Xzt
7HREL8kxeUepkgSBZXBuDzMsecVB4OZdzvxoBW/l2l/grL54CS0ZQqE831E5Sikg
0QjSDbenNYJJ7iLE6ysmtY5xqBG2oB/byQG+oTsY4uKakta8MTNSXRV+fwZ/PLaY
xpVp76nR45p6ufwO074sI46oWt4PdC3bletg8mtwlFX8SzaLS3wSwQpIIMkziWiG
HSryGYwk6sEAPyv0+HUxQZdE7fyC3hdoPglaL8KH+MUHRsZRaLYfy58lgN9MJviY
DtIUIjYHQ7B7J9pdrlfL0NhZsqne8dJtrEk1s/rTVUQiB9U32/oCzlpwv7ZB5ZJa
+FKVp+07KG+MXfMkLG6+UGFIFNTGHAFp9L+zVq+bUMJMIr8zhtPjkQpBcbFc7Hic
KeWGs8bWcI7mq5MmGYFeJeRIml/c8A2XhsKLf9BmnNM3iw/k0lRSgvHizVm1iDXo
+bU04Sv6yMRE9CYHfur+
=Olp2
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
