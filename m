From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCHv2 0/2] Input: atmel_mxt_ts: Add reset support
Date: Tue, 25 Jul 2017 15:56:56 +0200
Message-ID: <20170725135656.2ua5j76fctkkdmlr@earth>
References: <20170703123843.19340-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6a732z5ywabqqao"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170703123843.19340-1-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nick Dyer <nick-gcszYUEDH4VrovVCs/uTlw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--q6a732z5ywabqqao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Gentle ping on this one. This helps to remove a hack from the
Droid 4 DT and will also be used by PPD, which is currently
being upstreamed:

https://lkml.org/lkml/2017/7/19/898

-- Sebastian

On Mon, Jul 03, 2017 at 02:38:41PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> This adds support for the reset pin of Atmel MXT.
>=20
> Changes since PATCHv1:
>  - Add new patch preparing for resource managed gpio
>  - Use resource managed gpio
>  - Wait for interrupt after reset
>=20
> -- Sebastian
>=20
> Sebastian Reichel (2):
>   Input: atmel_mxt_ts: Use more managed resources
>   Input: atmel_mxt_ts: Add support for reset line
>=20
>  .../devicetree/bindings/input/atmel,maxtouch.txt   |  2 ++
>  drivers/input/touchscreen/atmel_mxt_ts.c           | 42 +++++++++++++++-=
------
>  2 files changed, 31 insertions(+), 13 deletions(-)
>=20
> --=20
> 2.13.2
>=20

--q6a732z5ywabqqao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3TigACgkQ2O7X88g7
+pq9wA/+NxlcW+Xa8vFK+p1swCC1gFc0D9ljRG+VG0ptvQaMJyEaiqA6wOvhjMbw
U2MGwHYfB7VD9BikBkSvsn9FFxH9I8K1PLLPZYaqFNSiUFQadg21zlO2Gc3+4rxi
Klc1aJceSMtbKoLjxasvlnlrSFyqmV6EYqw9CyOuybcg8rTezgCcFQ7AQ+dJGGtG
GditDl7LfFsmfO3VyduDtfu4FomDw7sLwlMpcSFPW0QfxL3GfidM51KbLAVU506H
qZZkcVgZ8ZJhTqjq2ClRV1t27x8nhtEIWJeP7t6UgNyWoz5BdJREFvXEz6MwmsJv
iRNVyfXeInHcoR3Rv4GS7O92wFkafLHAZby1zFYaqv4m++8WoC422owYRjlOEmxv
x7pMhSyz9efUjtutWB1Teu9jVr+tifbFJ9yXsGXhkIBLJaD/GYotAj+tTV1vYBRe
UKxbI9hZSCVNU2NkTRJUw6q7gmcQyLJBojdPcWbh/slkfY/JSbj+cUupgFMIhkuA
0rDky9C/PKO7bDFMFshOwVi619WKNoPkFFn8di9sBdzNH62t9rZKU7INBkCJlKg5
z1LzU7GeHHYI31mo9DxBGima3lpwElpVKQsgzYd3QBhz7yDSAFqwsN8TCQrwRIzB
8SgfPcIpB3/0vgvmlVkmCohf+arahKo/iaiE99FloEs3wDtUpnk=
=dZY6
-----END PGP SIGNATURE-----

--q6a732z5ywabqqao--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
