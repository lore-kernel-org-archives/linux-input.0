From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Mon, 22 Jan 2018 13:50:49 +0100
Message-ID: <20180122125049.4bqqqbgdlkdadpjh@flea.lan>
References: <20171201153957.13053-1-mylene.josserand@free-electrons.com>
 <20171201153957.13053-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2qxrwdnpwuosh4y6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201153957.13053-2-mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, thomas.petazzoni@free-electrons.com
List-Id: linux-input@vger.kernel.org


--2qxrwdnpwuosh4y6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dmitry,

On Fri, Dec 01, 2017 at 04:39:56PM +0100, Myl=E8ne Josserand wrote:
> This is the basic driver for the Cypress TrueTouch Gen5 touchscreen
> controllers. This driver supports only the I2C bus but it uses regmap
> so SPI support could be added later.
> The touchscreen can retrieve some defined zone that are handled as
> buttons (according to the hardware). That is why it handles
> button and multitouch events.
>=20
> Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@free-electrons.com>

Can we have some review here? This is the fourth iteration, with the
first having been sent back in May, and as far as I know we never got
any review from you. Can we please move forward on this?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2qxrwdnpwuosh4y6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpl3igACgkQ0rTAlCFN
r3TFkQ/6AhP31hSEL1wyw40vQ0dqOapJIdz4pDcNp4arCvxuRsIH4gno/vPrBtvi
kcvCpvB8ws6ZQU8+6cyuKSa+gMTO9WgD7iI6TPc5Yz8wzSxEfmrBHNT5E/OPksCl
di8IP9xwiAeCABgiCQksi+A6rWe1W94idGWAXXFw2miL5oLW81Qt8PCLadZmeVeR
hlIs2C+l1DY2Gi6iPk1Lqjc/9wZFIbEjpHN26zlSOKanRLIKUFXzD1DjEiy9z4lS
0ereNkyNu+rKqnNynS9VPZcveivh7czGVoy1PeG5PXjtX+mwcZpw94w13UfLPTBc
+vgh986EHo97tt6Lz5bYGSzwnpHA7HYfZ0Wqbq8NF6+bpBvY5rv2cjtY7i3xqvp4
UpCwxlDMVhioIjD5pxK4fsgcylSWZcD9W6Pa/ux/2093RGHOhwi6Uitz89oH2iVp
dJaERZVjdXxTAa7G9OJHmpypZpVL3IdMXj3MNQxnG7x9urC2GCRUNVFohtHEe2F/
PnrnWVl7uOPwQW/VhtwwrzJVkINq+905V5FmQdHiyqyABl4WO9RA7CqDRvDvFFxD
jMVEEZ9Vonp90ABnmgL89NhsdDCGFdAxMiV8QR4Ad2zCnkYd9hZTY1nmLtoYFlLh
FeBK+Iq9wgAFtalYJb431GPYahLhYFOwqYEeDZ69RTiLR/qG008=
=/AGC
-----END PGP SIGNATURE-----

--2qxrwdnpwuosh4y6--
