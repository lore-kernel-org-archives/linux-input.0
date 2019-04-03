From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] input: da9063_onkey: remove platform_data support
Date: Wed, 3 Apr 2019 11:24:33 +0200
Message-ID: <20190403092432.qofl5szh5zpfhvlm@ninjato>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-3-wsa+renesas@sang-engineering.com>
 <VI1PR10MB2352701871983EF8677C5CB8FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xnv5sx6mtiqadw4j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR10MB2352701871983EF8677C5CB8FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--xnv5sx6mtiqadw4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Subject: [PATCH 2/6] input: da9063_onkey: remove platform_data support
> >=20
> > There are no in-kernel users anymore, so remove this outdated interface.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/input/misc/da9063_onkey.c | 11 ++---------
> >  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> Thanks!
> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Dmitry, if you are OK with the series going in via MFD, could you ack
this patch? As you see, Steve is fine with the patch and tested it, too.


--xnv5sx6mtiqadw4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyke9AACgkQFA3kzBSg
KbamOw/+K6NXMZKR1ZgBFZvMQleB6Xj97G7Qk7mAdxbjTO3hXMUI1G1rHVqAjuy+
Tp0G0nJvb/ZeuDxHSGckXcHQ2C4OJEq5mWyQI1ZOGmNOGPyuJ/r4JsutQLkWIi1y
yfBMV+MXkx/sVPP2z4FTk2DEO2VTRMtyzRFd2zNV+yTcE8NpWmzW1TP7zlYy/eiK
1Qa4yPZWXwiGhVrn5erZywkjxhAgfPuoGNOxodMLNpjmyELbA8eztvc/dHbBkjwj
/2I2pLVUWAswS2iYc29re6YUtUMLlxatggHxYxLr/a8jMciAfvy3SmGtDZ2Uo+s9
79D/wEjsPCBOwdV/KS9ZbGRw8DhaUwso7nNaYB//twjfQpqz0QrvEIDQXZ6sQF+P
iKdg1gh+GkltCvg6Oas3HLBuXNFedebAjF5hcxEIYSpjCbmF/Pb+DTg2BIPb3fwz
qVCZgAU7XZBR4HsEJIlCaYq2K2FC9RB1LUSQEuHmLJBLa7eGnu8I8GjKmW64vvKO
JSHNxTnN8Ns00zWKlNpCH3g4GtynaFB70Iebyvd65wSgkH29Sky4MzocyuU5Yy67
hcoOTz1CwNLYzw76ZrejEz6/AG9c7jD6hLTgluJVpEvxH26NcPFtn5A1P9v4IOUW
IHztBBXwmDxlnE90Xnk467DCQ3jynzBOS3N91JdevyGYcPvP3Kc=
=flns
-----END PGP SIGNATURE-----

--xnv5sx6mtiqadw4j--
