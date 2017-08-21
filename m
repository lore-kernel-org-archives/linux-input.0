From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv2 0/2] Input: atmel_mxt_ts: Add reset support
Date: Mon, 21 Aug 2017 12:03:51 +0200
Message-ID: <20170821100351.iou3b26hypuc7f4h@earth>
References: <20170703123843.19340-1-sebastian.reichel@collabora.co.uk>
 <20170725135656.2ua5j76fctkkdmlr@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7m4ythvkybslxqsg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170725135656.2ua5j76fctkkdmlr@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--7m4ythvkybslxqsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

ping?

-- Sebastian

On Tue, Jul 25, 2017 at 03:56:56PM +0200, Sebastian Reichel wrote:
> Hi Dmitry,
>=20
> Gentle ping on this one. This helps to remove a hack from the
> Droid 4 DT and will also be used by PPD, which is currently
> being upstreamed:
>=20
> https://lkml.org/lkml/2017/7/19/898
>=20
> -- Sebastian
>=20
> On Mon, Jul 03, 2017 at 02:38:41PM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > This adds support for the reset pin of Atmel MXT.
> >=20
> > Changes since PATCHv1:
> >  - Add new patch preparing for resource managed gpio
> >  - Use resource managed gpio
> >  - Wait for interrupt after reset
> >=20
> > -- Sebastian
> >=20
> > Sebastian Reichel (2):
> >   Input: atmel_mxt_ts: Use more managed resources
> >   Input: atmel_mxt_ts: Add support for reset line
> >=20
> >  .../devicetree/bindings/input/atmel,maxtouch.txt   |  2 ++
> >  drivers/input/touchscreen/atmel_mxt_ts.c           | 42 ++++++++++++++=
+-------
> >  2 files changed, 31 insertions(+), 13 deletions(-)
> >=20
> > --=20
> > 2.13.2
> >=20



--7m4ythvkybslxqsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmasAQACgkQ2O7X88g7
+poxdQ/9HCGNJ5Q5IhbsPrLYJezuOeSpP0w2iEqz0uV/3nnVhc8uCovPxBbtMyCk
pIEa0C4Ot6c+9ucUkKHH2WBRWd3SAnMAwWAy/xO6Ubz1UQizp7LWSpeoFFP1O0XD
YwydUwWmY+W8ChYqOZhIj9sTXu0T4UEdahvEJmQXH3y3+2lm0kDkCKVsOAc2KKJx
uqToNb9US+MiM/Oma/rwCnI/jrY7W8KWqXY/aJBZo4kzTWezICW1W7mrdrCh2T0z
69eD+U7+OV8MKJcVNkP3NqBpapLsYNxPrvJ1Ti7O5ArxF6dQTVz1nUCjK8AcKP/d
XKILZpb1fF48U21sfQ99Jf3yaM9bnmlGm0HCVPraCbpslpdbauvkZ/JU6hmtbSL4
ltkPxAv3ff2qvadThjfiE/66cQX/Z7TIjZGqSHnZGUwJ+3XcWNzy5DIbz+jikF39
PzF2R0G1AKMKypOevGSoeHluntGnMImFynJUHe9KJyKYlcgYlQ0ozbmT/3krYQMp
nbGU5zM4+Sb4fIFi1zLhNP8K12Ve+Ee5VshatJRxTB6Mp3EFdW2JNxT/or+M9iVn
2xX3VQ5ktB2QOhpalqE2HZKgAWQn3AUPvY364ENj6dS1CNXROYAoQ9gdRPGe9ZdD
KWUsJmDH0ka66aa/GUZ7hTHv72phKE9aa9CwYaDnqn56yikRHYA=
=hznz
-----END PGP SIGNATURE-----

--7m4ythvkybslxqsg--
