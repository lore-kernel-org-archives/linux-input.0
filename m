From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCHv5 3/6] mfd: da9052: add register details for TSI
Date: Mon, 17 Jul 2017 17:20:17 +0200
Message-ID: <20170717152017.gtqa6g657k232z5k@earth>
References: <20170703084003.31184-1-sebastian.reichel@collabora.co.uk>
 <20170703084003.31184-4-sebastian.reichel@collabora.co.uk>
 <20170717143245.qvcshsnodtk7pi2h@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="67b5l5vhy3cwnku7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170717143245.qvcshsnodtk7pi2h@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--67b5l5vhy3cwnku7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2017 at 03:32:45PM +0100, Lee Jones wrote:
> On Mon, 03 Jul 2017, Sebastian Reichel wrote:
>=20
> > Add register details an channels definition for using the TSI
> > registers in the hwmon driver.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> > ---
> >  include/linux/mfd/da9052/da9052.h |  6 ++++++
> >  include/linux/mfd/da9052/reg.h    | 11 ++++++++++-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> Do other patches in this set depend on this change?

Patch 6 has a compile-time dependency on 3 (this one) + 5
and a runtime-dependency on patch 4. My proposed merge
solution would be an immutable branch for the mfd changes,
that can be pulled by hwmon.

-- Sebastian

--67b5l5vhy3cwnku7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlls1a4ACgkQ2O7X88g7
+prc0A//SybWijyIHY2bF3PfjjYQ5qzsHgOZEyoP8r+txUpvI5bMyef5AwIze5LR
JeNO8KhaddzohRr2VE9Z8Z8hLzzi3gL+u3AuFdN5aTjCitZ48aFIk887oU6RMGfw
POpPxQS0+t2JPk3q2JA1uePNdgb4klcd7MS6bByRww1HHsX6BI9CTu6CVY1aV/L4
fI9tay7mZjj8UdqJFfWp/404Tzn3+wqkkzKtpmBsOegUXvIHgAoTZJaF79DNV8mW
p8/QvMyIEQaPTz7j3zxFeYF8iLGVGwxSuR2yLPQ9v+fwsdmmPnkDL/s/8VUB3T1+
Bb2KRm1R8fRnUoYO0nbX8oRcqD6oFqUubLYfJ2werV9N0WR0yGFpBp+OvPL4GUfa
LW+pqNZ/E0/+9On+9/esYRpkSSSsw24vQEc9pMaatTd8CuhRWybK0ThhzCJ6WKVn
iY546HhwiF/POVXrrJYfLmK5XlvynVpafBjD2vn4dvXBpNWvMLznfb+00q9YruSL
xyCUqI+ynMLAZtWIop3GuQitOSop2D7hIhWgFhjSm7wLzR9/2FrR1CCgKE1Ne0nj
HIcCkUp7bWnvzIwqFbIn1Oq2CndYYJ4/hYOsWVhLkJudZPuN5UxFx7h7ub6H2MS/
N3xjym6gSPRsUcn+SIIajaOl4dhq5zBPPnPNIswCYNuFuyIRwUs=
=bmfY
-----END PGP SIGNATURE-----

--67b5l5vhy3cwnku7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
