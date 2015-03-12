From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] input: eglx_ts, remove irq trigger flags
Date: Thu, 12 Mar 2015 16:37:01 +0100
Message-ID: <20150312153701.GB13382@pengutronix.de>
References: <1426171816-26609-1-git-send-email-mpa@pengutronix.de>
 <1426173483.14455.73.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426173483.14455.73.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 12, 2015 at 04:18:03PM +0100, Philipp Zabel wrote:
> Hi Markus,
>=20
> Am Donnerstag, den 12.03.2015, 15:50 +0100 schrieb Markus Pargmann:
> > The trigger settings for a given irq are parsed from DT. Defining them
> > as flag for devm_request_threaded_irq() overwrites these settings. This
> > results in wrong trigger settings for boards which have different irq
> > triggers.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/input/touchscreen/egalax_ts.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touc=
hscreen/egalax_ts.c
> > index 4c56299284ef..b0e6448b743c 100644
> > --- a/drivers/input/touchscreen/egalax_ts.c
> > +++ b/drivers/input/touchscreen/egalax_ts.c
> > @@ -218,7 +218,7 @@ static int egalax_ts_probe(struct i2c_client *clien=
t,
> > =20
> >  	error =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> >  					  egalax_ts_interrupt,
> > -					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +					  IRQF_ONESHOT,
> >  					  "egalax_ts", ts);
> >  	if (error < 0) {
> >  		dev_err(&client->dev, "Failed to register interrupt\n");
>=20
> There are three device trees which have eeti,egalax_ts nodes with
> interrupt flags 0:
>=20
> arch/arm/boot/dts/imx53-tx53-x13x.dts (twice),
> arch/arm/boot/dts/imx6dl-tx6u-811x.dts, and
> arch/arm/boot/dts/imx6q-tx6q-1110.dts.
>=20
> Will these still work after this change?

Oh right, thanks, these should be fixed as well.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAbKdAAoJEEpcgKtcEGQQdbMP/iT1Apb8C1Bf3GXz10rkX01Q
YSKso04u2fupe+DcIRFFgZOSCW4Fm8cUw979kE5/szHBESbfIxF+XNJM7/JNWHub
nedWw1VjRiJdQWnw/NCoSNDMae49JmIuZksbk+DQK1r/8lRULjvp5jdQdNION8qn
ShVyIa1YC8/3F0XtnFWpDBZVaP06SfyNnV7Ade2kNwgl3y7e8Fl9PQk71cD4f+qr
Tc0iH8k1dg0pP12EyThUqJPg8eu+Iu+zxtXayRKniOj08uA6o0BiqA1gQSzkOc4E
CzSDZiYEKhbUCRnpBT8719wdia24OdJfj5AyH1rM4+AMz7rto7mlqBcJ8SEufjha
mXjgx6zE1zH8ejdQ699rh8GHz2DbvywtlR+PxVPZHcBzWVz7pitozSbewtuK+glU
/n6LR6kPRAlIPjKT4iBmaBATxf8RtaZBLyy3FJnL2qhOH+UomXQqgzdnKRLRU4du
d+6Gzy8iMth2xSWB1zHguIhnMnf8WGFQQ8iA2NRQmdZy7cqZvdltTSZi7fW700U1
2ye2v8WYZc5Acz424lSh/Uw0m3aaMfLiEKepBlfPExEwwOin1tChtwrndmanI51y
VoEY/0xsaQ9Pr1GzEnftNX3BJo0hbs4Rt3zeYlpTNPM/LnpaKs/+0Cpl44F9fp6M
9PY2mPfXbEuYQvtfdb1j
=PtuA
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
