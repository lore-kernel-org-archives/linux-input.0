From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv4 3/4] dt-bindings: mfd: da9052: support TSI as ADC
Date: Mon, 17 Jul 2017 13:27:11 +0200
Message-ID: <20170717112711.eskydrt4pu32v74g@earth>
References: <20170630143506.10541-1-sebastian.reichel@collabora.co.uk>
 <20170630143506.10541-4-sebastian.reichel@collabora.co.uk>
 <20170717104945.6qn6to7s3mlepxgj@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lzbokgjmvnqsodbo"
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717104945.6qn6to7s3mlepxgj@dell>
Sender: linux-hwmon-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Support Opensource <support.opensource@diasemi.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--lzbokgjmvnqsodbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Mon, Jul 17, 2017 at 11:49:45AM +0100, Lee Jones wrote:
> On Fri, 30 Jun 2017, Sebastian Reichel wrote:
>=20
> > DA9052 allows using the touchscreen input pins as general purpose
> > analogue input pin by wiring analogue inputs to X+, X-, Y+ and Y-
> > and providing a reference voltage at TSIREF pin.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  Documentation/devicetree/bindings/mfd/da9052-i2c.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt b/Doc=
umentation/devicetree/bindings/mfd/da9052-i2c.txt
> > index 9554292dc6cb..57fa74e65664 100644
> > --- a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> > +++ b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> > @@ -4,6 +4,14 @@ Required properties:
> >  - compatible : Should be "dlg,da9052", "dlg,da9053-aa",
> >  			 "dlg,da9053-ab", or "dlg,da9053-bb"
> > =20
> > +Optional properties:
> > +- dlg,tsi-as-adc : Boolean, if set the X+, X-, Y+, Y- touchscreen
> > +                    input lines are used as general purpose analogue
> > +					input.
> > +- tsiref-supply: Phandle to the regulator, which provides the reference
> > +                 voltage for the TSIREF pin. Must be provided when the
> > +			     touchscreen pins are used for ADC purposes.
> > +
>=20
> DT Ack please.

There is a v5 of this series, which has Acked-by from Rob already
and got positive feedback from Guenter Roeck for the hwmon parts:

http://lkml.iu.edu/hypermail/linux/kernel/1707.0/00518.html

(if you received v4, v5 should also be in your INBOX)

-- Sebastian

--lzbokgjmvnqsodbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllsnw8ACgkQ2O7X88g7
+prt6g//ZcOVdwkd+lzBrH8BOinm787NRA80Z2EQA7UPUnRA/djnSld3sHxAV16U
pqoLc77o4H/Djh4RRLGlh2SZ9Ne6DloouuXSilhc4I2M3Uzqc3I+hI5rlB3izCMv
uQmPhfip+U1GpZkPiLztXHHJ0OK8XXA+TFgn6cD8Pmbj3W1PYToyfNbX8PgqCrES
KG7gVKWuXOz1aD+vtSek0dXDRrX74Nz8pdJH5/3LvETG/ZkFnHt6qq7W4Koi0DQ/
QiRRHiHejPhsvOjG/zl1pWPJeqi+++vaLkdN0kBZHBbSzu7kM3tLEoCWznC3HwKm
DKSI2cJSaP1B4uEUJG4wZVheJHNxUcqD2U89YWKgl/ElJLy+0YG/wCOyc4mwUJG0
CFALgpUEXlh2nFDcWyaEp1Vfogb4VwBUrgiunUqUhxznIEAItoaXZMX1vs+/6pAF
i3WyvhVFjILfLWb9FFiS5d+OBLdPcrxSNpJNsrv/tiuE+BRPCkJuiPvuRtru6eNr
UHlLEtRYALspDdWHXrQRubMIh4TvXb0cmM7XMiNNz8GbJav1lJ71ueXDL4t5ZA0t
23wJ5QTSikcrEKx8uJEV/rmiHgdBsAl11RNvVFSyd9KimPyBBOVtqXDDsBaSiNTk
71z2YCQqcKHQnykx9rilmRYIGcWlyfkrXl+N8Vc2WLANLwQIoDY=
=lIX1
-----END PGP SIGNATURE-----

--lzbokgjmvnqsodbo--
